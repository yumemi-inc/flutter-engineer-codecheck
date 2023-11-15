import 'package:flutter_engineer_codecheck/app.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/ui/repo_detail/repo_detail_page.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../data/dummy/dummy_fetch_repo_content_result.dart';
import '../../data/dummy/dummy_repo.dart';
import '../../data/dummy/dummy_search_repos_result.dart';

class MockGithubRepositoryImpl extends Mock implements GithubRepositoryImpl {}

void main() {
  late MockGithubRepositoryImpl repository;
  late List<Device> devices;

  setUp(() async {
    repository = MockGithubRepositoryImpl();
    when(
      () => repository.searchRepos(
        any(),
        sort: any(named: 'sort'),
        order: any(named: 'order'),
        perPage: any(named: 'perPage'),
        page: any(named: 'page'),
      ),
    ).thenAnswer((_) => Future.value(dummySearchReposResult()));

    when(
      () => repository.fetchRepoContent(
        any(),
        any(),
      ),
    ).thenAnswer(
      (_) => Future.value(dummyFetchRepoContentResult),
    );

    devices = [
      Device.phone,
      Device.iphone11,
      Device.tabletPortrait,
      Device.tabletLandscape,
    ];

    await loadAppFonts();
  });

  group('RepoDetailPage', () {
    testGoldens('Golden', (tester) async {
      await mockNetworkImages(() async {
        await tester.runAsync(() async {
          await tester.pumpDeviceBuilder(
            DeviceBuilder()
              ..overrideDevicesForAllScenarios(devices: devices)
              ..addScenario(
                widget: const RepoDetailPage(repoId: 1),
              ),
            wrapper: (child) => ProviderScope(
              overrides: [
                repoProvider(1).overrideWith(
                  (provider) => dummyRepo(1, hasReadmeText: true),
                ),
              ],
              child: App(home: child),
            ),
          );
        });
        await screenMatchesGolden(tester, 'repo_detail_page');
      });
    });
  });
}

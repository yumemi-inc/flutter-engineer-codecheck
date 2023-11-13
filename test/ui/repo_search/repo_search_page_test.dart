import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/app.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

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

    devices = [
      Device.phone,
      Device.iphone11,
      Device.tabletPortrait,
      Device.tabletLandscape,
    ];

    await loadAppFonts();
  });

  group('RepoSearchPage', () {
    testGoldens('Golden', (tester) async {
      await mockNetworkImages(() async {
        await tester.runAsync(() async {
          await tester.pumpDeviceBuilder(
            DeviceBuilder()
              ..overrideDevicesForAllScenarios(devices: devices)
              ..addScenario(widget: const RepoSearchPage()),
            wrapper: (child) => ProviderScope(
              overrides: [
                githubRepositoryProvider.overrideWithValue(repository),
              ],
              child: App(home: child),
            ),
          );
        });
        await screenMatchesGolden(tester, 'repo_search_page');

        await tester.runAsync(() async {
          await tester.pumpDeviceBuilder(
            DeviceBuilder()
              ..overrideDevicesForAllScenarios(devices: devices)
              ..addScenario(
                widget: const RepoSearchPage(),
                onCreate: (scenarioWidgetKey) async {
                  final finder = find.descendant(
                    of: find.byKey(scenarioWidgetKey),
                    matching: find.byType(SearchBar),
                  );
                  expect(finder, findsOneWidget);
                  await tester.tap(finder);
                  await tester.enterText(finder, 'test');
                  await tester.testTextInput
                      .receiveAction(TextInputAction.done);
                  await tester.pumpAndSettle();
                },
              ),
            wrapper: (child) => ProviderScope(
              overrides: [
                githubRepositoryProvider.overrideWithValue(repository),
              ],
              child: App(home: child),
            ),
          );
        });

        await screenMatchesGolden(tester, 'repo_index_page');
      });
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/app.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model_state.dart';
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
    testWidgets('0文字では検索できない', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              githubRepositoryProvider.overrideWithValue(repository),
            ],
            child: const App(home: RepoSearchPage()),
          ),
        );
      });
      final element = tester.element(find.byType(RepoSearchPage));
      final container = ProviderScope.containerOf(element);
      final state = container.read(reposViewModelProvider);

      final finder = find.byType(SearchBar);
      expect(finder, findsOneWidget);
      await tester.tap(finder);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(state.status, ReposViewModelStatus.uninitialized);
    });
    testWidgets('256文字以上で検索できない', (tester) async {
      await mockNetworkImages(() async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                githubRepositoryProvider.overrideWithValue(repository),
              ],
              child: const App(home: RepoSearchPage()),
            ),
          );
        });

        final finder = find.byType(SearchBar);
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        await tester.enterText(finder, 'a' * 256);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();
        final controller = tester.widget<SearchBar>(finder).controller;
        if (controller == null) {
          fail('controller is null');
        }
        expect(controller.text, 'a' * 255);
      });
    });
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

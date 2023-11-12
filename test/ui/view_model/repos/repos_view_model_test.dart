import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../data/dummy/dummy_search_repos_result.dart';
import '../../../test_util/riverpod.dart';

class MockGithubRepositoryImpl extends Mock implements GithubRepositoryImpl {}

void main() {
  group('ReposViewModel', () {
    // 引数テストはUI側でテストしているので、ここでは正常系のみテストする
    test('.searchRepos', () async {
      final repository = MockGithubRepositoryImpl();
      final container = createContainer(
        overrides: [
          githubRepositoryProvider.overrideWith((ref) {
            return repository;
          }),
        ],
      );
      final viewModel = container.read(reposViewModelProvider.notifier);

      // 正常クエリ
      when(
        () => container.read(githubRepositoryProvider).searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
      ).thenAnswer(
        (_) => Future.value(dummySearchReposResult()),
      );
      await viewModel.searchRepos('test');

      final state = container.read(reposViewModelProvider);

      expect(state.status, ReposViewModelStatus.contentAvailable);
      expect(state.repos.length, 10);
      expect(state.error, isNull);
    });
    test('.searchReposNextPage', () async {
      final repository = MockGithubRepositoryImpl();
      final container = createContainer(
        overrides: [
          githubRepositoryProvider.overrideWith((ref) {
            return repository;
          }),
        ],
      );
      final viewModel = container.read(reposViewModelProvider.notifier);

      // 初回クエリ
      when(
        () => container.read(githubRepositoryProvider).searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
      ).thenAnswer(
        (_) => Future.value(dummySearchReposResult()),
      );
      await viewModel.searchRepos('test');

      // 追加クエリ
      when(
        () => container.read(githubRepositoryProvider).searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
      ).thenAnswer(
        (_) => Future.value(dummySearchReposResult(idStartWith: 11)),
      );
      await viewModel.searchReposNextPage();

      final state = container.read(reposViewModelProvider);

      expect(state.status, ReposViewModelStatus.contentAvailable);
      expect(state.repos.length, 20);
      expect(state.repos[0].id, 1);
      expect(state.error, isNull);
    });
    // 正常系はsearchRepos実行中のloading状態も含めてテストするために一つのテストにまとめている。
    // 異常系はそれぞれテストしている。
    group('状態遷移テスト', () {
      test('正常系', () async {
        final repository = MockGithubRepositoryImpl();

        var isAllContentLoaded = false;

        final container = createContainer(
          overrides: [
            githubRepositoryProvider.overrideWith((ref) {
              return repository;
            }),
          ],
        )..listen(reposViewModelProvider, (previous, next) {
            // providerの初期状態
            if (previous == null) {
              expect(next.status, ReposViewModelStatus.uninitialized);
              return;
            }
            switch (previous.status) {
              // 初期状態から初回ローディングへの遷移
              case ReposViewModelStatus.uninitialized:
                expect(next.status, ReposViewModelStatus.loading);
              // 初回ローディングからは3つの状態に遷移する
              // 1. エラーあり
              // 2. 結果が0件
              // 3. 結果が1件以上
              case ReposViewModelStatus.loading:
                if (next.error != null) {
                  fail('unexpected state transition');
                } else if (next.repos.isEmpty) {
                  expect(next.status, ReposViewModelStatus.empty);
                } else {
                  expect(next.status, ReposViewModelStatus.contentAvailable);
                }
              // 結果ありの状態からは、2種類の状態遷移がある
              // 1. 初回検索へ戻る
              // 2. 追加のデータの取得
              case ReposViewModelStatus.contentAvailable:
                if (next.repos.isEmpty) {
                  expect(next.status, ReposViewModelStatus.loading);
                } else {
                  expect(
                    next.status,
                    ReposViewModelStatus.loadingAdditionalContent,
                  );
                }
              // 追加のデータの取得からは、3種類の状態遷移がある
              // 1. これまでのデータが残っている & エラーあり
              // 2. 全てのデータを取得（これ以上のデータがない）
              // 3. 追加データ取得完了 (まだデータが残っている)
              case ReposViewModelStatus.loadingAdditionalContent:
                if (next.error != null) {
                  fail('unexpected state transition');
                } else if (!isAllContentLoaded) {
                  expect(next.status, ReposViewModelStatus.contentAvailable);
                } else {
                  expect(next.status, ReposViewModelStatus.allContentLoaded);
                }
              // 残りは再検索しかできない
              case ReposViewModelStatus.empty:
              case ReposViewModelStatus.allContentLoaded:
                expect(next.status, ReposViewModelStatus.loading);
              // 異常系にはならないはずなのでfailする
              case ReposViewModelStatus.error:
              case ReposViewModelStatus.contentAvailableWithError:
                fail('unexpected state transition');
            }
          });

        final viewModel = container.read(reposViewModelProvider.notifier);

        // 初回データ取得
        when(
          () => repository.searchRepos(
            any(),
            sort: any(named: 'sort'),
            order: any(named: 'order'),
            perPage: any(named: 'perPage'),
            page: any(named: 'page'),
          ),
        ).thenAnswer(
          (_) => Future.value(dummySearchReposResult()),
        );
        await viewModel.searchRepos('test');

        // 追加データ取得
        await viewModel.searchReposNextPage();

        // 全てのデータを取得
        // 外部からはデータが取得できているかどうかはわからないので、
        // 手動でフラグを立てている
        isAllContentLoaded = true;
        when(
          () => repository.searchRepos(
            any(),
            sort: any(named: 'sort'),
            order: any(named: 'order'),
            perPage: any(named: 'perPage'),
            page: any(named: 'page'),
          ),
        ).thenAnswer(
          (_) => Future.value(dummySearchReposResult().copyWith(items: [])),
        );
        await viewModel.searchReposNextPage();

        // 再検索 & 見つからない
        when(
          () => repository.searchRepos(
            any(),
            sort: any(named: 'sort'),
            order: any(named: 'order'),
            perPage: any(named: 'perPage'),
            page: any(named: 'page'),
          ),
        ).thenAnswer(
          (_) => Future.value(dummySearchReposResult().copyWith(items: [])),
        );
        await viewModel.searchRepos('test');
      });
      group('異常系', () {
        test('初回データ取得時にエラー', () async {
          final repository = MockGithubRepositoryImpl();

          final container = createContainer(
            overrides: [
              githubRepositoryProvider.overrideWith((ref) {
                return repository;
              }),
            ],
          );

          final subscription =
              container.listen(reposViewModelProvider, (_, __) {});
          final viewModel = container.read(reposViewModelProvider.notifier);

          when(
            () => repository.searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
          ).thenThrow(AppException(Exception('error')));
          await viewModel.searchRepos('test');

          expect(subscription.read().status, ReposViewModelStatus.error);
          expect(subscription.read().error, isA<AppException>());
        });
        test('追加データ取得時にエラー', () async {
          final repository = MockGithubRepositoryImpl();

          final container = createContainer(
            overrides: [
              githubRepositoryProvider.overrideWith((ref) {
                return repository;
              }),
            ],
          );

          final subscription =
              container.listen(reposViewModelProvider, (_, __) {});
          final viewModel = container.read(reposViewModelProvider.notifier);

          when(
            () => repository.searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
          ).thenAnswer(
            (_) => Future.value(dummySearchReposResult()),
          );
          await viewModel.searchRepos('test');

          when(
            () => repository.searchRepos(
              any(),
              sort: any(named: 'sort'),
              order: any(named: 'order'),
              perPage: any(named: 'perPage'),
              page: any(named: 'page'),
            ),
          ).thenThrow(AppException(Exception('error')));
          await viewModel.searchReposNextPage();

          expect(
            subscription.read().status,
            ReposViewModelStatus.contentAvailableWithError,
          );
          expect(
            subscription.read().repos.length,
            dummySearchReposResult().items.length,
          );
          expect(subscription.read().error, isA<AppException>());
        });
      });
    });
  });
}

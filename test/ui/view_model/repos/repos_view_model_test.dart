import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../data/dummy/dummy_fetch_repo_content_result.dart';
import '../../../data/dummy/dummy_search_repos_result.dart';
import '../../../test_util/riverpod.dart';

class MockGithubRepositoryImpl extends Mock implements GithubRepositoryImpl {}

// ここでは、ViewModelの状態遷移のみをテストしている
// 引数のテストは、UI側で行う
void main() {
  late MockGithubRepositoryImpl repository;
  late ProviderContainer container;
  late ReposViewModel viewModel;

  setUp(() {
    repository = MockGithubRepositoryImpl();
    container = createContainer(
      overrides: [
        githubRepositoryProvider.overrideWithValue(repository),
      ],
    );
    viewModel = container.read(reposViewModelProvider.notifier);
  });

  When<Future<SearchReposResult>> whenMockSearchReposAny() {
    return when(
      () => repository.searchRepos(
        any(),
        sort: any(named: 'sort'),
        order: any(named: 'order'),
        perPage: any(named: 'perPage'),
        page: any(named: 'page'),
      ),
    );
  }

  void mockSearchReposSuccess() {
    whenMockSearchReposAny().thenAnswer(
      (_) => Future.value(dummySearchReposResult()),
    );
  }

  void mockSearchReposNextPageSuccess() {
    whenMockSearchReposAny().thenAnswer(
      (_) => Future.value(dummySearchReposResult(idStartWith: 11)),
    );
  }

  void mockSearchReposEmpty() {
    whenMockSearchReposAny().thenAnswer(
      (_) => Future.value(dummySearchReposResult().copyWith(items: [])),
    );
  }

  void mockSearchReposError() {
    whenMockSearchReposAny().thenThrow(
      AppException(Exception('error')),
    );
  }

  void mockFetchRepoContentSuccess() {
    when(
      () => repository.fetchRepoContent(
        any(),
        any(),
      ),
    ).thenAnswer(
      (_) => Future.value(dummyFetchRepoContentResult),
    );
  }

  // 引数テストはUI側でテストしているので、ここでは状態遷移のみテストする
  group('ReposViewModel', () {
    test('初回検索', () async {
      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          expect(next.status, ReposViewModelStatus.uninitialized);
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.uninitialized:
            expect(next.status, ReposViewModelStatus.loading);
          case ReposViewModelStatus.loading:
            expect(next.status, ReposViewModelStatus.contentAvailable);
          default:
            fail('unexpected state transition');
        }
      });
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.contentAvailable);
      expect(state.repos.length, 10);
      expect(state.error, isNull);
    });
    test('追加検索', () async {
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.contentAvailable:
            expect(
              next.status,
              ReposViewModelStatus.loadingAdditionalContent,
            );
          case ReposViewModelStatus.loadingAdditionalContent:
            expect(next.status, ReposViewModelStatus.contentAvailable);
          default:
            fail('unexpected state transition');
        }
      });

      // 追加クエリ
      mockSearchReposNextPageSuccess();
      await viewModel.searchReposNextPage();

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.contentAvailable);
      expect(state.repos.length, 20);
      expect(state.repos[0].id, 1);
      expect(state.error, isNull);
    });
    test('全てのデータを取得', () async {
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.contentAvailable:
            expect(
              next.status,
              ReposViewModelStatus.loadingAdditionalContent,
            );
          case ReposViewModelStatus.loadingAdditionalContent:
            expect(next.status, ReposViewModelStatus.allContentLoaded);
          default:
            fail('unexpected state transition');
        }
      });

      // 追加クエリ
      mockSearchReposEmpty();
      await viewModel.searchReposNextPage();

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.allContentLoaded);
      expect(state.repos.length, 10);
      expect(state.error, isNull);
    });
    test('再検索', () async {
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.contentAvailable:
            expect(
              next.status,
              ReposViewModelStatus.loading,
            );
          case ReposViewModelStatus.loading:
            expect(next.status, ReposViewModelStatus.contentAvailable);
          default:
            fail('unexpected state transition');
        }
      });

      // 再検索
      mockSearchReposSuccess();
      await viewModel.searchRepos('test2');

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.contentAvailable);
      expect(state.repos.length, 10);
      expect(state.error, isNull);
    });
    test('初回検索で空', () async {
      // 初回クエリ
      mockSearchReposEmpty();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.loading:
            expect(next.status, ReposViewModelStatus.empty);
          default:
            fail('unexpected state transition');
        }
      });

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.empty);
      expect(state.repos.length, 0);
      expect(state.error, isNull);
    });
    test('初回検索でエラー', () async {
      // 初回クエリ
      mockSearchReposError();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.loading:
            expect(next.status, ReposViewModelStatus.error);
          default:
            fail('unexpected state transition');
        }
      });

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.error);
      expect(state.repos.length, 0);
      expect(state.error, isA<AppException>());
    });
    test('追加検索でエラー', () async {
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final subscription =
          container.listen(reposViewModelProvider, (previous, next) {
        if (previous == null) {
          return;
        }
        switch (previous.status) {
          case ReposViewModelStatus.contentAvailable:
            expect(
              next.status,
              ReposViewModelStatus.loadingAdditionalContent,
            );
          case ReposViewModelStatus.loadingAdditionalContent:
            expect(next.status, ReposViewModelStatus.contentAvailableWithError);
          default:
            fail('unexpected state transition');
        }
      });

      // 追加クエリ
      mockSearchReposError();
      await viewModel.searchReposNextPage();

      final state = subscription.read();

      expect(state.status, ReposViewModelStatus.contentAvailableWithError);
      expect(state.repos.length, 10);
      expect(state.error, isA<AppException>());
    });
    test('READMEを取得', () async {
      // 初回クエリ
      mockSearchReposSuccess();
      await viewModel.searchRepos('test');

      final subscription = container.listen(repoProvider(1), (_, __) {});

      expect(subscription.read().readmeText, isA<AsyncLoading<String>>());

      // README取得
      mockFetchRepoContentSuccess();
      await viewModel.fetchRepoReadme(1);

      expect(subscription.read().readmeText.value, 'hogehogehugahuga');
    });
  });
}

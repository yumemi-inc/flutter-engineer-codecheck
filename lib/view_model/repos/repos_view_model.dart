import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repos_view_model.g.dart';

@riverpod
Repo repo(RepoRef ref, int repoId) {
  return ref.watch(
    reposViewModelProvider.select((state) {
      return state.repos.firstWhere((repo) => repo.id == repoId);
    }),
  );
}

@riverpod
class ReposViewModel extends _$ReposViewModel {
  @override
  ReposViewModelState build() {
    return const ReposViewModelState();
  }

  late final GithubRepository _repository = ref.read(githubRepositoryProvider);

  String _query = '';
  final _perPage = 30;
  int _page = 1;

  Future<void> searchRepos(String query) async {
    state = const ReposViewModelState(status: ReposViewModelStatus.loading);

    _query = query;

    try {
      final result = await _repository.searchRepos(query);

      state = state.copyWith(
        status: result.items.isEmpty
            ? ReposViewModelStatus.empty
            : ReposViewModelStatus.contentAvailable,
        repos: result.items,
      );
    } on AppException catch (e) {
      state = state.copyWith(
        status: ReposViewModelStatus.error,
        error: e,
      );
    }
  }

  Future<void> searchReposNextPage() async {
    if (state.status == ReposViewModelStatus.allContentLoaded) {
      return;
    }

    state = state.copyWith(
      status: ReposViewModelStatus.loadingAdditionalContent,
    );

    try {
      _page++;
      final result = await _repository.searchRepos(
        _query,
        perPage: _perPage,
        page: _page,
      );
      if (result.items.isEmpty) {
        state = state.copyWith(
          status: ReposViewModelStatus.allContentLoaded,
        );
        return;
      }
      final repos = result.items;

      state = state.copyWith(
        status: ReposViewModelStatus.contentAvailable,
        repos: [...state.repos, ...repos],
      );
    } on AppException catch (e) {
      state = state.copyWith(
        status: ReposViewModelStatus.contentAvailableWithError,
        error: e,
      );
    }
  }
}

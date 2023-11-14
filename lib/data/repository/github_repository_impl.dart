import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:flutter_engineer_codecheck/data/model/fetch_repo_content_result.dart';
import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';
import 'package:flutter_engineer_codecheck/data/remote/github_data_source.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_repository_impl.g.dart';

@riverpod
GithubRepositoryImpl githubRepository(GithubRepositoryRef ref) {
  return GithubRepositoryImpl(ref);
}

class GithubRepositoryImpl implements GithubRepository {
  GithubRepositoryImpl(this.ref);

  final GithubRepositoryRef ref;

  late final GithubDataSource _dataSource = ref.read(githubDataSourceProvider);

  @override
  Future<SearchReposResult> searchRepos(
    String query, {
    String? sort,
    String? order,
    int? perPage,
    int? page,
  }) async {
    try {
      final retrofitObject = await _dataSource.searchRepositories(
        query,
        sort,
        order,
        perPage,
        page,
      );
      final json = retrofitObject.json;

      return SearchReposResult.fromJson(json);
    } on Exception catch (error) {
      throw AppException(error);
    }
  }

  @override
  Future<FetchRepoContentResult> fetchRepoContent(
    String fullName,
    String path,
  ) async {
    try {
      final retrofitObject = await _dataSource.getRepoContent(fullName, path);
      final json = retrofitObject.json;

      return FetchRepoContentResult.fromJson(json);
    } on Exception catch (error) {
      throw AppException(error);
    }
  }
}

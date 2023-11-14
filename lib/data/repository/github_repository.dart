import 'package:flutter_engineer_codecheck/data/model/fetch_repo_content_result.dart';
import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';

abstract class GithubRepository {
  Future<SearchReposResult> searchRepos(
    String query, {
    String? sort,
    String? order,
    int? perPage,
    int? page,
  });

  Future<FetchRepoContentResult> fetchRepoContent(
    String fullName,
    String path,
  );
}

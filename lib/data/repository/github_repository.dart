import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';

abstract class GithubRepository {
  Future<SearchReposResult> searchRepos(String query);
}

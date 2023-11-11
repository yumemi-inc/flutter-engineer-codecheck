import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';
import 'package:flutter_engineer_codecheck/data/remote/github_data_source.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_repository_impl.g.dart';

// TODO(kuwano): githubRepositoryImplProviderという名前のものが生成されるが、Implの部分を消したい
// アプリ内(ViewModel)ではGithubのRepositoryのことをRepoと呼ぶが、
// RemoteのgithubDataSourceではrepositoryと呼びたい。
// なので、ここで変換する。
// また、Retrofitの自動生成APIを使用したいが、モデル変換をしたくないので、RetrofitObjectというモックを作成して、
// jsonをそのまま保持している。
// TODO(kuwano): retrofitを使用せずに、dioだけで実装する
@riverpod
class GithubRepositoryImpl extends _$GithubRepositoryImpl
    implements GithubRepository {
  @override
  GithubRepository build() {
    return this;
  }

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
}

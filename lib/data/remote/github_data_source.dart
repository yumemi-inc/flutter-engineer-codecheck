import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/data/remote/github_dio.dart';
import 'package:flutter_engineer_codecheck/data/remote/retrofit_object.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_data_source.g.dart';

@riverpod
GithubDataSource githubDataSource(GithubDataSourceRef ref) {
  return GithubDataSource(ref);
}

// TODO: baseUrlを切り替えられるようにする
@RestApi()
abstract class GithubDataSource {
  factory GithubDataSource(GithubDataSourceRef ref) =>
      _GithubDataSource(ref.read(githubDioProvider));

  @GET('/search/repositories')
  Future<RetrofitObject> searchRepositories(
    @Query('q') String query,
  );
}

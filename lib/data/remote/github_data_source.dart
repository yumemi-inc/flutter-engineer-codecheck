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

@RestApi()
abstract class GithubDataSource {
  factory GithubDataSource(GithubDataSourceRef ref) =>
      _GithubDataSource(ref.read(githubDioProvider));

  @GET('/search/repositories')
  Future<RetrofitObject> searchRepositories(
    @Query('q') String query,
    @Query('sort') String? sort,
    @Query('order') String? order,
    @Query('per_page') int? perPage,
    @Query('page') int? page,
  );

  @GET('/repos/{full_name}/contents/{path}')
  Future<RetrofitObject> getRepoContent(
    @Path('full_name') String fullName,
    @Path('path') String path,
  );
}

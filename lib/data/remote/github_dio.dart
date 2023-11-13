import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/data/remote/base_dio.dart';
import 'package:flutter_engineer_codecheck/foundation/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_dio.g.dart';

@riverpod
Dio githubDio(GithubDioRef ref) {
  final baseDio = ref.watch(baseDioProvider);

  baseDio.options = baseDio.options.copyWith(
    baseUrl: Env.githubUrl,
    headers: {
      'Accept': 'application/vnd.github.v3+json',
      'Authorization': 'Bearer ${Env.githubToken}',
      'X-Github-Api-Version': '2022-11-28',
    },
  );
  return baseDio;
}

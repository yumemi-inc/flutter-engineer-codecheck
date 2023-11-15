import 'package:flutter_engineer_codecheck/data/model/owner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// アーキテクチャのRepositoryと混同するので、Repoと命名しています。
@freezed
class Repo with _$Repo {
  factory Repo({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
    required Owner owner,
    @JsonKey(name: 'html_url') required String htmlUrl,
    required String? description,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'watchers_count') required int watchersCount,
    @JsonKey(name: 'forks_count') required int forksCount,
    @JsonKey(name: 'open_issues_count') required int openIssuesCount,
    @JsonKey(name: 'language') required String? language,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(AsyncLoading<String>())
    AsyncValue<String> readmeText,
  }) = _Repo;

  const Repo._();

  factory Repo.fromJson(Map<String, Object?> json) => _$RepoFromJson(json);
}

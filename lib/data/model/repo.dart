import 'package:flutter_engineer_codecheck/data/model/owner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// アーキテクチャのRepositoryと混同するので、Repoと命名しています。
@freezed
class Repo with _$Repo {
  const factory Repo({
    required int id,
    required String name,
    @JsonKey(name: 'full_name') required String fullName,
    required Owner owner,
    required String? description,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'language') required String? language,
  }) = _Repo;

  const Repo._();

  factory Repo.fromJson(Map<String, Object?> json) => _$RepoFromJson(json);
}

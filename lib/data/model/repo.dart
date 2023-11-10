import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

/// アーキテクチャのRepositoryと混同するので、Repoと命名しています。
@freezed
class Repo with _$Repo {
  const factory Repo({
    required int id,
    required String name,
  }) = _Repo;

  const Repo._();

  factory Repo.fromJson(Map<String, Object?> json) => _$RepoFromJson(json);
}

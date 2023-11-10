import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_repos_result.freezed.dart';
part 'search_repos_result.g.dart';

@freezed
class SearchReposResult with _$SearchReposResult {
  const factory SearchReposResult({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    required List<Repo> items,
  }) = _SearchReposResult;

  const SearchReposResult._();

  factory SearchReposResult.fromJson(Map<String, Object?> json) =>
      _$SearchReposResultFromJson(json);
}

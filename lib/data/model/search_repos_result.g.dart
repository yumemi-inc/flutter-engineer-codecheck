// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repos_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchReposResultImpl _$$SearchReposResultImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchReposResultImpl(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => Repo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SearchReposResultImplToJson(
        _$SearchReposResultImpl instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepoImpl _$$RepoImplFromJson(Map<String, dynamic> json) => _$RepoImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      updatedAt: json['updated_at'] as String,
      stargazersCount: json['stargazers_count'] as int,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$$RepoImplToJson(_$RepoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.fullName,
      'owner': instance.owner,
      'description': instance.description,
      'updated_at': instance.updatedAt,
      'stargazers_count': instance.stargazersCount,
      'language': instance.language,
    };

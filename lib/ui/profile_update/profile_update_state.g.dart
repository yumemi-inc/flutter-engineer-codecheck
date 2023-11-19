// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileUpdateStateImpl _$$ProfileUpdateStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileUpdateStateImpl(
      originalUser: json['originalUser'] == null
          ? null
          : User.fromJson(json['originalUser'] as Map<String, dynamic>),
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
    );

Map<String, dynamic> _$$ProfileUpdateStateImplToJson(
        _$ProfileUpdateStateImpl instance) =>
    <String, dynamic>{
      'originalUser': instance.originalUser,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repos_view_model_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReposViewModelStateImpl _$$ReposViewModelStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ReposViewModelStateImpl(
      repos: (json['repos'] as List<dynamic>?)
              ?.map((e) => Repo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status:
          $enumDecodeNullable(_$ReposViewModelStatusEnumMap, json['status']) ??
              ReposViewModelStatus.uninitialized,
    );

Map<String, dynamic> _$$ReposViewModelStateImplToJson(
        _$ReposViewModelStateImpl instance) =>
    <String, dynamic>{
      'repos': instance.repos,
      'status': _$ReposViewModelStatusEnumMap[instance.status]!,
    };

const _$ReposViewModelStatusEnumMap = {
  ReposViewModelStatus.uninitialized: 'uninitialized',
  ReposViewModelStatus.loading: 'loading',
  ReposViewModelStatus.error: 'error',
  ReposViewModelStatus.empty: 'empty',
  ReposViewModelStatus.contentAvailable: 'contentAvailable',
  ReposViewModelStatus.loadingAdditionalContent: 'loadingAdditionalContent',
  ReposViewModelStatus.contentAvailableWithError: 'contentAvailableWithError',
  ReposViewModelStatus.allContentLoaded: 'allContentLoaded',
};

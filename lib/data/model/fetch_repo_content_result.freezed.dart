// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fetch_repo_content_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FetchRepoContentResult _$FetchRepoContentResultFromJson(
    Map<String, dynamic> json) {
  return _FetchRepoContentResult.fromJson(json);
}

/// @nodoc
mixin _$FetchRepoContentResult {
  String get encoding => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FetchRepoContentResultCopyWith<FetchRepoContentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FetchRepoContentResultCopyWith<$Res> {
  factory $FetchRepoContentResultCopyWith(FetchRepoContentResult value,
          $Res Function(FetchRepoContentResult) then) =
      _$FetchRepoContentResultCopyWithImpl<$Res, FetchRepoContentResult>;
  @useResult
  $Res call({String encoding, String name, String content});
}

/// @nodoc
class _$FetchRepoContentResultCopyWithImpl<$Res,
        $Val extends FetchRepoContentResult>
    implements $FetchRepoContentResultCopyWith<$Res> {
  _$FetchRepoContentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encoding = null,
    Object? name = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      encoding: null == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchRepoContentResultImplCopyWith<$Res>
    implements $FetchRepoContentResultCopyWith<$Res> {
  factory _$$FetchRepoContentResultImplCopyWith(
          _$FetchRepoContentResultImpl value,
          $Res Function(_$FetchRepoContentResultImpl) then) =
      __$$FetchRepoContentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String encoding, String name, String content});
}

/// @nodoc
class __$$FetchRepoContentResultImplCopyWithImpl<$Res>
    extends _$FetchRepoContentResultCopyWithImpl<$Res,
        _$FetchRepoContentResultImpl>
    implements _$$FetchRepoContentResultImplCopyWith<$Res> {
  __$$FetchRepoContentResultImplCopyWithImpl(
      _$FetchRepoContentResultImpl _value,
      $Res Function(_$FetchRepoContentResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encoding = null,
    Object? name = null,
    Object? content = null,
  }) {
    return _then(_$FetchRepoContentResultImpl(
      encoding: null == encoding
          ? _value.encoding
          : encoding // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FetchRepoContentResultImpl extends _FetchRepoContentResult {
  const _$FetchRepoContentResultImpl(
      {required this.encoding, required this.name, required this.content})
      : super._();

  factory _$FetchRepoContentResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FetchRepoContentResultImplFromJson(json);

  @override
  final String encoding;
  @override
  final String name;
  @override
  final String content;

  @override
  String toString() {
    return 'FetchRepoContentResult(encoding: $encoding, name: $name, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchRepoContentResultImpl &&
            (identical(other.encoding, encoding) ||
                other.encoding == encoding) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, encoding, name, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchRepoContentResultImplCopyWith<_$FetchRepoContentResultImpl>
      get copyWith => __$$FetchRepoContentResultImplCopyWithImpl<
          _$FetchRepoContentResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FetchRepoContentResultImplToJson(
      this,
    );
  }
}

abstract class _FetchRepoContentResult extends FetchRepoContentResult {
  const factory _FetchRepoContentResult(
      {required final String encoding,
      required final String name,
      required final String content}) = _$FetchRepoContentResultImpl;
  const _FetchRepoContentResult._() : super._();

  factory _FetchRepoContentResult.fromJson(Map<String, dynamic> json) =
      _$FetchRepoContentResultImpl.fromJson;

  @override
  String get encoding;
  @override
  String get name;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$FetchRepoContentResultImplCopyWith<_$FetchRepoContentResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

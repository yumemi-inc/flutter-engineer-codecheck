// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileUpdateState _$ProfileUpdateStateFromJson(Map<String, dynamic> json) {
  return _ProfileUpdateState.fromJson(json);
}

/// @nodoc
mixin _$ProfileUpdateState {
  User? get originalUser => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileUpdateStateCopyWith<ProfileUpdateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUpdateStateCopyWith<$Res> {
  factory $ProfileUpdateStateCopyWith(
          ProfileUpdateState value, $Res Function(ProfileUpdateState) then) =
      _$ProfileUpdateStateCopyWithImpl<$Res, ProfileUpdateState>;
  @useResult
  $Res call({User? originalUser, String name, String avatarUrl});

  $UserCopyWith<$Res>? get originalUser;
}

/// @nodoc
class _$ProfileUpdateStateCopyWithImpl<$Res, $Val extends ProfileUpdateState>
    implements $ProfileUpdateStateCopyWith<$Res> {
  _$ProfileUpdateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalUser = freezed,
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      originalUser: freezed == originalUser
          ? _value.originalUser
          : originalUser // ignore: cast_nullable_to_non_nullable
              as User?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get originalUser {
    if (_value.originalUser == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.originalUser!, (value) {
      return _then(_value.copyWith(originalUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileUpdateStateImplCopyWith<$Res>
    implements $ProfileUpdateStateCopyWith<$Res> {
  factory _$$ProfileUpdateStateImplCopyWith(_$ProfileUpdateStateImpl value,
          $Res Function(_$ProfileUpdateStateImpl) then) =
      __$$ProfileUpdateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User? originalUser, String name, String avatarUrl});

  @override
  $UserCopyWith<$Res>? get originalUser;
}

/// @nodoc
class __$$ProfileUpdateStateImplCopyWithImpl<$Res>
    extends _$ProfileUpdateStateCopyWithImpl<$Res, _$ProfileUpdateStateImpl>
    implements _$$ProfileUpdateStateImplCopyWith<$Res> {
  __$$ProfileUpdateStateImplCopyWithImpl(_$ProfileUpdateStateImpl _value,
      $Res Function(_$ProfileUpdateStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalUser = freezed,
    Object? name = null,
    Object? avatarUrl = null,
  }) {
    return _then(_$ProfileUpdateStateImpl(
      originalUser: freezed == originalUser
          ? _value.originalUser
          : originalUser // ignore: cast_nullable_to_non_nullable
              as User?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileUpdateStateImpl extends _ProfileUpdateState {
  const _$ProfileUpdateStateImpl(
      {required this.originalUser, required this.name, required this.avatarUrl})
      : super._();

  factory _$ProfileUpdateStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileUpdateStateImplFromJson(json);

  @override
  final User? originalUser;
  @override
  final String name;
  @override
  final String avatarUrl;

  @override
  String toString() {
    return 'ProfileUpdateState(originalUser: $originalUser, name: $name, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileUpdateStateImpl &&
            (identical(other.originalUser, originalUser) ||
                other.originalUser == originalUser) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, originalUser, name, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileUpdateStateImplCopyWith<_$ProfileUpdateStateImpl> get copyWith =>
      __$$ProfileUpdateStateImplCopyWithImpl<_$ProfileUpdateStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileUpdateStateImplToJson(
      this,
    );
  }
}

abstract class _ProfileUpdateState extends ProfileUpdateState {
  const factory _ProfileUpdateState(
      {required final User? originalUser,
      required final String name,
      required final String avatarUrl}) = _$ProfileUpdateStateImpl;
  const _ProfileUpdateState._() : super._();

  factory _ProfileUpdateState.fromJson(Map<String, dynamic> json) =
      _$ProfileUpdateStateImpl.fromJson;

  @override
  User? get originalUser;
  @override
  String get name;
  @override
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$ProfileUpdateStateImplCopyWith<_$ProfileUpdateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

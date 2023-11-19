import 'package:flutter_engineer_codecheck/data/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_update_state.freezed.dart';
part 'profile_update_state.g.dart';

@freezed
class ProfileUpdateState with _$ProfileUpdateState {
  const factory ProfileUpdateState({
    required User? originalUser,
    required String name,
    required String avatarUrl,
  }) = _ProfileUpdateState;

  const ProfileUpdateState._();

  factory ProfileUpdateState.fromJson(Map<String, Object?> json) =>
      _$ProfileUpdateStateFromJson(json);
}

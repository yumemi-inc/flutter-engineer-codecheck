import 'package:flutter/foundation.dart';
import 'package:flutter_engineer_codecheck/data/repository/image_repository.dart';
import 'package:flutter_engineer_codecheck/data/repository/image_repository_impl.dart';
import 'package:flutter_engineer_codecheck/ui/profile_update/profile_update_state.dart';
import 'package:flutter_engineer_codecheck/view_model/user/user_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_update_view_model.g.dart';

@riverpod
class ProfileUpdateViewModel extends _$ProfileUpdateViewModel {
  @override
  ProfileUpdateState build() {
    final user = ref.read(userViewModelProvider);
    return ProfileUpdateState(
      originalUser: user,
      name: user?.name ?? '',
      avatarUrl: user?.avatarUrl ?? '',
    );
  }

  late final _userViewModel = ref.read(userViewModelProvider.notifier);

  late final ImageRepository _imageRepository =
      ref.read(imageRepositoryProvider);

  Future<void> pickImageFromGallery() async {
    final avatarUrl = await _imageRepository.pickImageFromGallery();
    if (avatarUrl == null) {
      return;
    }

    state = state.copyWith(avatarUrl: avatarUrl);
  }

  Future<void> updateDisplayName(String name) async {
    state = state.copyWith(name: name);
  }

  Future<void> updateProfile() async {
    final name = state.name;
    final avatarUrl = state.avatarUrl;

    String? uploadedPhotoUrl;

    debugPrint('avatarUrl: $avatarUrl');

    if (avatarUrl.startsWith('/private/')) {
      uploadedPhotoUrl = await _imageRepository.saveImage(
        avatarUrl,
        'users/${state.originalUser!.id}/avatar.jpg',
      );
    }

    await _userViewModel.saveProfile(
      name: name,
      avatarUrl: uploadedPhotoUrl,
    );
  }
}

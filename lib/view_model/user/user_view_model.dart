import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_engineer_codecheck/data/model/user.dart';
import 'package:flutter_engineer_codecheck/data/repository/user_repository.dart';
import 'package:flutter_engineer_codecheck/data/repository/user_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_view_model.g.dart';

// 変更を監視して更新するので直接stateを変更する必要はない
@riverpod
class UserViewModel extends _$UserViewModel {
  // TODO(kuwano): ここだけFirebaseAuthに依存しているので後で修正する
  @override
  User? build() {
    final subscription = FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        state = null;
        return;
      }

      if (state == null) {
        state = User(
          id: user.uid,
          name: user.displayName ?? '',
          avatarUrl: user.photoURL ?? '',
        );
      } else {
        state = state!.copyWith(
          name: user.displayName ?? '',
          avatarUrl: user.photoURL ?? '',
        );
      }
    });
    ref.onDispose(subscription.cancel);

    return _getUser();
  }

  late final UserRepository _userRepository = ref.read(userRepositoryProvider);

  User? _getUser() {
    return _userRepository.getUser();
  }

  Future<void> signInWithGithub() async {
    await _userRepository.signInWithGithub();
  }

  Future<void> saveProfile({
    String? name,
    String? avatarUrl,
  }) async {
    await _userRepository.saveProfile(name, avatarUrl);
  }
}

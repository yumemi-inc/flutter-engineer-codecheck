import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_engineer_codecheck/data/model/user.dart';
import 'package:flutter_engineer_codecheck/data/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepositoryImpl userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl();
}

class UserRepositoryImpl extends UserRepository {
  @override
  User? getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return User(
      id: user.uid,
      name: user.displayName ?? '',
      avatarUrl: user.photoURL ?? '',
    );
  }

  @override
  Future<void> signInWithGithub() async {
    final provider = GithubAuthProvider();

    await FirebaseAuth.instance.signInWithProvider(provider);
  }

  @override
  Future<void> saveProfile(String? name, String? avatarUrl) async {
    final oldUser = FirebaseAuth.instance.currentUser;
    if (oldUser == null) {
      return Future.value();
    }

    if (name != null && name.isNotEmpty) {
      if (name != oldUser.displayName) {
        await oldUser.updateDisplayName(name);
      }
    }
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      if (avatarUrl != oldUser.photoURL) {
        await oldUser.updatePhotoURL(avatarUrl);
      }
    }
  }
}

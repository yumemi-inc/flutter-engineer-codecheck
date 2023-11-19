import 'package:flutter_engineer_codecheck/data/model/user.dart';

abstract class UserRepository {
  User? getUser();

  Future<void> signInWithGithub();

  Future<void> saveProfile(
    String? name,
    String? avatarUrl,
  );
}

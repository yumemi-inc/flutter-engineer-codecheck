import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_engineer_codecheck/foundation/constants.dart';

// ignore: avoid_classes_with_only_static_members
/// 環境変数のラッパークラス
class Env {
  static Flavor get flavor {
    switch (const String.fromEnvironment('flavor')) {
      case 'dev':
        return Flavor.dev;
      case 'stg':
        return Flavor.stg;
      case 'prod':
        return Flavor.prod;
      default:
        throw Exception('環境変数にflavorが設定されていません');
    }
  }

  static String get githubUrl => const String.fromEnvironment('githubUrl');

  static String get githubToken => dotenv.env['GITHUB_TOKEN'] ?? '';
}

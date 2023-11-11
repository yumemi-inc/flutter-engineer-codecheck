import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
AppTheme appTheme(AppThemeRef ref) {
  return AppTheme();
}

class AppTheme {
  ThemeData light() => getThemeData(Brightness.light);
  ThemeData dark() => getThemeData(Brightness.dark);

  ThemeData getThemeData(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: brightness,
      ),
      useMaterial3: true,
      dividerTheme: const DividerThemeData(
        space: 0, // Dividerの上下のスペースを0にする
      ),
    );
  }
}

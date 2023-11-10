import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme.g.dart';

@riverpod
ThemeData appTheme(AppThemeRef ref) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    dividerTheme: const DividerThemeData(
      space: 0, // Dividerの上下のスペースを0にする
    ),
  );
}

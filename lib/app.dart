import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/home/home_page.dart';
import 'package:flutter_engineer_codecheck/ui/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}

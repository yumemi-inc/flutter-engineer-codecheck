import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:flutter_engineer_codecheck/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO(kuwano): バックグラウンドでのライト・ダークテーマ切り替えについて調べる
// Twitter, Line, Settingのようなアプリはバックグラウンドで切り替えられるが、
// Flutterでは解決策はないようだ。
// ref: https://github.com/flutter/flutter/issues/43806
class App extends ConsumerWidget {
  const App({
    this.home,
    super.key,
  });

  final Widget? home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: appTheme.light(),
      darkTheme: appTheme.dark(),
      home: home ?? const RepoSearchPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({
    this.home,
    super.key,
  });

  final Widget? home;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);
    final appRouter = ref.watch(appRouterProvider);

    // テストのために本番のコードをいじりたくないが、方法が思いつかないのでこのような実装になっている
    if (home == null) {
      // 本番MaterialApp
      return MaterialApp.router(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: appTheme.light(),
        darkTheme: appTheme.dark(),
        routerConfig: appRouter,
      );
    } else {
      // テスト用MaterialApp
      return MaterialApp(
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        theme: appTheme.light(),
        darkTheme: appTheme.dark(),
        home: home,
      );
    }
  }
}

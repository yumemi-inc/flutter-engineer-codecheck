import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/view_model/user/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitialPage extends ConsumerStatefulWidget {
  const InitialPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitialPageState();
}

class _InitialPageState extends ConsumerState<InitialPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = ref.read(userViewModelProvider);
      if (user == null) {
        if (!mounted) {
          return;
        }
        const SignInRoute().go(context);
      } else {
        if (!mounted) {
          return;
        }
        const HomeRoute().go(context);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

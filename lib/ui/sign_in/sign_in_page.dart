import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/view_model/user/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = ref.watch(userViewModelProvider.notifier);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await userViewModel.signInWithGithub();
              if (!mounted) {
                return;
              }
              const HomeRoute().go(context);
            },
            child: const Text('Sign in with GitHub'),
          ),
        ],
      ),
    );
  }
}

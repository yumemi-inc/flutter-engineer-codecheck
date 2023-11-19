import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/view_model/user/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          TextButton(
            onPressed: () {
              const ProfileUpdateRoute().go(context);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
      body: SafeArea(
        child: user == null
            ? const Center(child: Text('ログインしてください'))
            : Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        user.avatarUrl,
                        height: 100,
                      ),
                    ),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

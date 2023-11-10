import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/repos_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repos = ref.watch(reposViewModelProvider);
    final reposViewModel = ref.watch(reposViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: repos.when(
        data: (repos) => Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter keyword',
              ),
              onSubmitted: reposViewModel.searchRepos,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(repos[index].name),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: repos.length,
              ),
            ),
          ],
        ),
        error: (_, __) => Container(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/repos_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepoSearchPage extends ConsumerStatefulWidget {
  const RepoSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepoSearchPageState();
}

class _RepoSearchPageState extends ConsumerState<RepoSearchPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        final isBottom = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
        if (isBottom) {
          ref.read(reposViewModelProvider.notifier).searchReposNextPage();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reposAsyncValue = ref.watch(reposViewModelProvider);
    final hasNextPage = ref.watch(
      reposViewModelProvider.notifier.select((value) => value.hasNextPage),
    );
    final reposViewModel = ref.watch(reposViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repo Search'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Enter keyword',
            ),
            onSubmitted: reposViewModel.searchRepos,
          ),
          Expanded(
            child: reposAsyncValue.when(
              data: (repos) {
                if (repos == null) {
                  return const Center(
                    child: Text('上の検索バーから検索してね'),
                  );
                }
                if (repos.isEmpty) {
                  return const Center(
                    child: Text(
                      '見つからなかったよ\nキーワードを変えてみてね',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == repos.length) {
                      if (hasNextPage && reposAsyncValue.isRefreshing) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                    return ListTile(
                      title: Text(repos[index].name),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: repos.length + 1, // +1はロード中の表示用
                );
              },
              error: (_, __) => const SizedBox(),
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

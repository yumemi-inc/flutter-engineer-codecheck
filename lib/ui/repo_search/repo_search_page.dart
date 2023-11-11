import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/repos_view_model.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_list_tile.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/search_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepoSearchPage extends ConsumerStatefulWidget {
  const RepoSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepoSearchPageState();
}

class _RepoSearchPageState extends ConsumerState<RepoSearchPage> {
  late final TextEditingController _textEditingController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
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
    _textEditingController.dispose();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SearchAppBar(
          textEditingController: _textEditingController,
          onSubmitted: reposViewModel.searchRepos,
        ),
      ),
      // ここのswitch式はDartの新規機能も勉強しているアピールのために書いています。
      // AsyncValue.whenで書くこともできます。
      body: switch (reposAsyncValue) {
        AsyncData(value: final repos) => switch (repos) {
            null => const Center(
                child: Text('上の検索バーから検索してね'),
              ),
            [] => const Center(
                child: Text(
                  '見つからなかったよ\nキーワードを変えてみてね',
                  textAlign: TextAlign.center,
                ),
              ),
            _ => ListView.separated(
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
                  return RepoListTile(repo: repos[index]);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: repos.length + 1, // +1はロード中の表示用
              ),
          },
        AsyncError() => const Center(
            child: Text('エラーが発生しました'),
          ),
        _ => const Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}

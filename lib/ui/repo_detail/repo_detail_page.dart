import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_forks_count_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_language_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_open_issues_count_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_stargazers_count_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_watchers_count_label.dart';
import 'package:flutter_engineer_codecheck/view_model/repos/repos_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RepoDetailPage extends ConsumerStatefulWidget {
  const RepoDetailPage({
    required this.repoId,
    super.key,
  });

  final int repoId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepoDetailPageState();
}

class _RepoDetailPageState extends ConsumerState<RepoDetailPage> {
  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(repoProvider(widget.repoId));

    return Scaffold(
      appBar: AppBar(
        title: Text(repo.fullName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Image.network(repo.owner.avatarUrl),
            ),
            Text(repo.fullName),
            Text(repo.description ?? ''),
            if (repo.language != null)
              RepoLanguageLabel(language: repo.language!),
            Wrap(
              children: [
                RepoStargazersCountLabel(
                  stargazersCount: repo.stargazersCount,
                  labelVisible: true,
                ),
                RepoForksCountLabel(
                  forksCount: repo.forksCount,
                  labelVisible: true,
                ),
                RepoWatchersCountLabel(
                  watchersCount: repo.watchersCount,
                  labelVisible: true,
                ),
                RepoOpenIssuesCountLabel(
                  openIssuesCount: repo.openIssuesCount,
                  labelVisible: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

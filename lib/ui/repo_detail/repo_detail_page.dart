import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_language_label.dart';
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
              child: Hero(
                tag: 'repo_image_${repo.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.network(
                    repo.owner.avatarUrl,
                    height: 120,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(repo.fullName),
            const SizedBox(height: 8),
            Text(repo.description ?? ''),
            const SizedBox(height: 8),
            if (repo.language != null) ...[
              RepoLanguageLabel(language: repo.language!),
              const SizedBox(
                height: 8,
              ),
            ],
            Wrap(
              spacing: 8,
              children: [
                RepoLabel(
                  type: RepoLabelType.stargazersCount,
                  count: repo.stargazersCount,
                  labelVisible: true,
                ),
                RepoLabel(
                  type: RepoLabelType.forksCount,
                  count: repo.forksCount,
                  labelVisible: true,
                ),
                RepoLabel(
                  type: RepoLabelType.watchersCount,
                  count: repo.watchersCount,
                  labelVisible: true,
                ),
                RepoLabel(
                  type: RepoLabelType.openIssuesCount,
                  count: repo.openIssuesCount,
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

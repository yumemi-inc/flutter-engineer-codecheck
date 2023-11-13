import 'package:flutter/material.dart';
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
      appBar: AppBar(),
      body: Column(
        children: [
          Image.network(repo.owner.avatarUrl),
          Text(repo.fullName),
          Text(repo.description ?? ''),
          Text(repo.language ?? ''),
          Text(repo.stargazersCount.toString()),
          Text(repo.watchersCount.toString()),
          Text(repo.forksCount.toString()),
          Text(repo.openIssuesCount.toString()),
        ],
      ),
    );
  }
}

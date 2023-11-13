import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_language_label.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_stargazers_count_label.dart';

class RepoListTile extends StatelessWidget {
  const RepoListTile({
    required Repo repo,
    super.key,
  }) : _repo = repo;

  final Repo _repo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).listTileTheme.tileColor,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                _repo.owner.avatarUrl,
                height: 60,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _repo.fullName,
                    style: Theme.of(context).listTileTheme.titleTextStyle,
                  ),
                  Text(
                    _repo.description ?? '',
                    style: Theme.of(context).listTileTheme.subtitleTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      if (_repo.language != null) ...[
                        RepoLanguageLabel(language: _repo.language!),
                        const SizedBox(width: 4),
                        const Text('・'),
                      ],
                      RepoStargazersCountLabel(
                        stargazersCount: _repo.stargazersCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

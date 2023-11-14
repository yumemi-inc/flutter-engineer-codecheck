import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_engineer_codecheck/ui/app_router.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_label.dart';
import 'package:flutter_engineer_codecheck/ui/component/repo_language_label.dart';

// 色やフォントサイズはMaterialのListTileのデザインを元に少し拡張しています。
// ref: https://m3.material.io/components/lists/specs
class RepoListTile extends StatelessWidget {
  const RepoListTile({
    required Repo repo,
    super.key,
  }) : _repo = repo;

  final Repo _repo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RepoDetailRoute(repoId: _repo.id).go(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Theme.of(context).listTileTheme.tileColor,
        child: Row(
          children: [
            Hero(
              tag: 'repo_image_${_repo.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  _repo.owner.avatarUrl,
                  width: 60,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _repo.fullName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    _repo.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
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
                      RepoLabel(
                        type: RepoLabelType.stargazersCount,
                        count: _repo.stargazersCount,
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

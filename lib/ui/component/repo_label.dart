import 'package:flutter/material.dart';

enum RepoLabelType {
  stargazersCount,
  forksCount,
  watchersCount,
  openIssuesCount,
}

class RepoLabel extends StatelessWidget {
  const RepoLabel({
    required RepoLabelType type,
    required int count,
    bool labelVisible = false,
    super.key,
  })  : _type = type,
        _count = count,
        _labelVisible = labelVisible;

  final RepoLabelType _type;
  final int _count;
  final bool _labelVisible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _generateRepoIcon(_type),
        const SizedBox(width: 4),
        Text(_generateCountK(_count)),
        if (_labelVisible) ...[
          const SizedBox(width: 4),
          Text(_generateLabelName(_type)),
        ],
      ],
    );
  }
}

Icon _generateRepoIcon(RepoLabelType type) {
  switch (type) {
    case RepoLabelType.stargazersCount:
      return const Icon(Icons.star_border);
    case RepoLabelType.forksCount:
      return const Icon(Icons.fork_left);
    case RepoLabelType.watchersCount:
      return const Icon(Icons.remove_red_eye_outlined);
    case RepoLabelType.openIssuesCount:
      return const Icon(Icons.arrow_drop_down_circle_outlined);
  }
}

String _generateCountK(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (count < 100000) {
    final countK = count / 1000;
    return '${countK.toStringAsFixed(1)}k';
  }

  final countK = count / 1000;
  return '${countK.round()}k';
}

String _generateLabelName(RepoLabelType type) {
  switch (type) {
    case RepoLabelType.stargazersCount:
      return 'stars';
    case RepoLabelType.forksCount:
      return 'forks';
    case RepoLabelType.watchersCount:
      return 'watching';
    case RepoLabelType.openIssuesCount:
      return 'issues';
  }
}

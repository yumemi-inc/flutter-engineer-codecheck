import 'package:flutter/material.dart';

class RepoOpenIssuesCountLabel extends StatelessWidget {
  const RepoOpenIssuesCountLabel({
    required int openIssuesCount,
    bool labelVisible = false,
    super.key,
  })  : _openIssuesCount = openIssuesCount,
        _labelVisible = labelVisible;

  final int _openIssuesCount;
  final bool _labelVisible;

  String generateOpenIssuesCountK(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 100000) {
      final openIssuesCountK = count / 1000;
      return '${openIssuesCountK.toStringAsFixed(1)}k';
    }

    final openIssuesCountK = count / 1000;
    return '${openIssuesCountK.round()}k';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.arrow_drop_down_circle_outlined),
        Text(generateOpenIssuesCountK(_openIssuesCount)),
        if (_labelVisible) ...[
          const SizedBox(width: 4),
          const Text('issues'),
        ],
      ],
    );
  }
}

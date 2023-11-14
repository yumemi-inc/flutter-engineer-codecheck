import 'package:flutter/material.dart';

class RepoForksCountLabel extends StatelessWidget {
  const RepoForksCountLabel({
    required int forksCount,
    bool labelVisible = false,
    super.key,
  })  : _forksCount = forksCount,
        _labelVisible = labelVisible;

  final int _forksCount;
  final bool _labelVisible;

  String generateForksCountK(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 100000) {
      final forksCountK = count / 1000;
      return '${forksCountK.toStringAsFixed(1)}k';
    }

    final forksCountK = count / 1000;
    return '${forksCountK.round()}k';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.fork_left),
        Text(generateForksCountK(_forksCount)),
        if (_labelVisible) ...[
          const SizedBox(width: 4),
          const Text('forks'),
        ],
      ],
    );
  }
}

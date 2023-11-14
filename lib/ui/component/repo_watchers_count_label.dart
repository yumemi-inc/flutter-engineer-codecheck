import 'package:flutter/material.dart';

class RepoWatchersCountLabel extends StatelessWidget {
  const RepoWatchersCountLabel({
    required int watchersCount,
    bool labelVisible = false,
    super.key,
  })  : _watchersCount = watchersCount,
        _labelVisible = labelVisible;

  final int _watchersCount;
  final bool _labelVisible;

  String generateWatchersCountK(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 100000) {
      final watchersCountK = count / 1000;
      return '${watchersCountK.toStringAsFixed(1)}k';
    }

    final watchersCountK = count / 1000;
    return '${watchersCountK.round()}k';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.remove_red_eye_outlined),
        Text(generateWatchersCountK(_watchersCount)),
        if (_labelVisible) ...[
          const SizedBox(width: 4),
          const Text('watching'),
        ],
      ],
    );
  }
}

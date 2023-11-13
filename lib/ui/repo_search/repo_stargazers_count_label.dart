import 'package:flutter/material.dart';

class RepoStargazersCountLabel extends StatelessWidget {
  const RepoStargazersCountLabel({
    required int stargazersCount,
    super.key,
  }) : _stargazersCount = stargazersCount;

  final int _stargazersCount;

  String generateStargazersCountK(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 100000) {
      final stargazersCountK = count / 1000;
      return '${stargazersCountK.toStringAsFixed(1)}k';
    }

    final stargazersCountK = count / 1000;
    return '${stargazersCountK.round()}k';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_border),
        Text(generateStargazersCountK(_stargazersCount)),
      ],
    );
  }
}

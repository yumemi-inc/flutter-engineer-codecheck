import 'package:flutter/material.dart';

class RepoStargazersCountLabel extends StatelessWidget {
  const RepoStargazersCountLabel({
    required int stargazersCount,
    super.key,
  }) : _stargazersCount = stargazersCount;

  final int _stargazersCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star_border),
        Text(_stargazersCount.toString()),
      ],
    );
  }
}

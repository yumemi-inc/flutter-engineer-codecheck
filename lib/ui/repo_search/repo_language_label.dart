import 'package:flutter/material.dart';
import 'package:github_language_colors/github_language_colors.dart';

class RepoLanguageLabel extends StatelessWidget {
  const RepoLanguageLabel({
    required String language,
    super.key,
  }) : _language = language;

  final String _language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: Color(githubLanguageColors[_language] ?? 0x00000000),
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(_language),
      ],
    );
  }
}

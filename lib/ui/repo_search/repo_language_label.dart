import 'package:flutter/material.dart';

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
        // TODO(kuwano): 色をつける
        // ref: https://github.com/doda-zz/github-language-colors
        const Icon(Icons.circle),
        Text(_language),
      ],
    );
  }
}

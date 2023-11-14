import 'package:flutter_engineer_codecheck/data/model/owner.dart';
import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Repo dummyRepo(
  int id, {
  bool hasReadmeText = false,
}) =>
    Repo(
      id: id,
      name: 'flutter_engineer_codecheck',
      fullName: 'RYO1223/flutter_engineer_codecheck',
      owner: const Owner(
        id: 1,
        avatarUrl: 'https://example.com',
      ),
      htmlUrl: 'https://example.com',
      description: 'Flutter Engineer Codecheck',
      updatedAt: DateTime.now().toString(),
      stargazersCount: 100000,
      watchersCount: 100000,
      forksCount: 100000,
      openIssuesCount: 100000,
      language: 'Flutter',
      readmeText: hasReadmeText
          ? const AsyncData('hogehogehugahuga')
          : const AsyncLoading(),
    );

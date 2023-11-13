import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/repo_detail/repo_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(routes: $appRoutes);
}

@TypedGoRoute<RepoSearchRoute>(
  path: '/',
  routes: [
    TypedGoRoute<RepoDetailRoute>(
      path: 'repos/:repoId',
    ),
  ],
)
class RepoSearchRoute extends GoRouteData {
  const RepoSearchRoute();

  @override
  RepoSearchPage build(BuildContext context, GoRouterState state) =>
      const RepoSearchPage();
}

class RepoDetailRoute extends GoRouteData {
  const RepoDetailRoute({
    required this.repoId,
  });

  final int repoId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RepoDetailPage(repoId: repoId);
  }
}

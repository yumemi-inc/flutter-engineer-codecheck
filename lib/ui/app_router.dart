import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/home/home_page.dart';
import 'package:flutter_engineer_codecheck/ui/initial/initial_page.dart';
import 'package:flutter_engineer_codecheck/ui/profile/profile_page.dart';
import 'package:flutter_engineer_codecheck/ui/profile_update/profile_update_page.dart';
import 'package:flutter_engineer_codecheck/ui/repo_detail/repo_detail_page.dart';
import 'package:flutter_engineer_codecheck/ui/repo_search/repo_search_page.dart';
import 'package:flutter_engineer_codecheck/ui/sign_in/sign_in_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(routes: $appRoutes);
}

@TypedGoRoute<InitialRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SignInRoute>(
      path: 'sign-in',
    ),
  ],
)
class InitialRoute extends GoRouteData {
  const InitialRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const InitialPage();
  }
}

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInPage();
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<RepoDetailRoute>(
      path: 'repos/:repoId',
    ),
    TypedGoRoute<ProfileUpdateRoute>(
      path: 'profile/update',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

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

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfilePage();
  }
}

class ProfileUpdateRoute extends GoRouteData {
  const ProfileUpdateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileUpdatePage();
  }
}

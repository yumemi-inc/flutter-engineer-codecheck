// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $repoSearchRoute,
    ];

RouteBase get $repoSearchRoute => GoRouteData.$route(
      path: '/',
      factory: $RepoSearchRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'repos/:repoId',
          factory: $RepoDetailRouteExtension._fromState,
        ),
      ],
    );

extension $RepoSearchRouteExtension on RepoSearchRoute {
  static RepoSearchRoute _fromState(GoRouterState state) =>
      const RepoSearchRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RepoDetailRouteExtension on RepoDetailRoute {
  static RepoDetailRoute _fromState(GoRouterState state) => RepoDetailRoute(
        repoId: int.parse(state.pathParameters['repoId']!),
      );

  String get location => GoRouteData.$location(
        '/repos/${Uri.encodeComponent(repoId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appRouterHash() => r'80dda18aa8e3d6f44cb8a7c1112e45664131bb09';

/// See also [appRouter].
@ProviderFor(appRouter)
final appRouterProvider = AutoDisposeProvider<GoRouter>.internal(
  appRouter,
  name: r'appRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppRouterRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

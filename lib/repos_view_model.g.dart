// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repos_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reposViewModelHash() => r'f607e67715ddbb88c4ff3533446c47ead36510a6';

/// 7種類の状態がある
/// 1. null -> 初期状態
/// 2. AsyncLoading & 値が入っていない -> ロード中を表示
/// 3. AsyncLoading & 値か入っている -> データを表示しながらロード
/// 4. AsyncData & 値が入っていない -> データなしを表示
/// 5. AsyncData & 値が入っている -> データを表示
/// 6. AsyncError & 値が入っていない -> エラーを表示
/// 7. AsyncError & 値が入っている -> 前回のデータを表示 ＆ エラーを表示
///
/// Copied from [ReposViewModel].
@ProviderFor(ReposViewModel)
final reposViewModelProvider =
    AutoDisposeAsyncNotifierProvider<ReposViewModel, List<Repo>?>.internal(
  ReposViewModel.new,
  name: r'reposViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reposViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReposViewModel = AutoDisposeAsyncNotifier<List<Repo>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repos_view_model.g.dart';

/// 7種類の状態がある
/// 1. null -> 初期状態
/// 2. AsyncLoading & 値が入っていない -> ロード中を表示
/// 3. AsyncLoading & 値か入っている -> データを表示しながらロード
/// 4. AsyncData & 値が入っていない -> データなしを表示
/// 5. AsyncData & 値が入っている -> データを表示
/// 6. AsyncError & 値が入っていない -> エラーを表示
/// 7. AsyncError & 値が入っている -> 前回のデータを表示 ＆ エラーを表示
@riverpod
class ReposViewModel extends _$ReposViewModel {
  @override
  FutureOr<List<Repo>?> build() async {
    return null;
  }

  late final _repository = ref.read(githubRepositoryImplProvider);

  String _query = '';
  final _perPage = 30;
  int _page = 1;
  bool _hasNextPage = true;

  bool get hasNextPage => _hasNextPage;

  Future<void> searchRepos(String query) async {
    state = const AsyncLoading();

    _query = query;
    final result = await _repository.searchRepos(query);

    state = AsyncData(result.items);
  }

  Future<void> searchReposNextPage() async {
    if (!_hasNextPage) {
      return;
    }

    state = const AsyncLoading<List<Repo>?>().copyWithPrevious(state);

    _page++;
    final result = await _repository.searchRepos(
      _query,
      perPage: _perPage,
      page: _page,
    );
    if (result.items.isEmpty) {
      _hasNextPage = false;
    }
    final repos = result.items;

    state = AsyncData([...state.value!, ...repos]);
  }
}

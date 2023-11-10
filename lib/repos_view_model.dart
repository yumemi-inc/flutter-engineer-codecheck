import 'package:flutter_engineer_codecheck/data/model/repo.dart';
import 'package:flutter_engineer_codecheck/data/repository/github_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repos_view_model.g.dart';

@riverpod
class ReposViewModel extends _$ReposViewModel {
  @override
  FutureOr<List<Repo>> build() async {
    return [];
  }

  late final _repository = ref.read(githubRepositoryImplProvider);

  Future<void> searchRepos(String query) async {
    final result = await _repository.searchRepos(query);
    state = AsyncData(result.items);
  }
}

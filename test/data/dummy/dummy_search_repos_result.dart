import 'package:flutter_engineer_codecheck/data/model/search_repos_result.dart';

import 'dummy_repo.dart';

SearchReposResult dummySearchReposResult({int idStartWith = 1}) {
  return SearchReposResult(
    totalCount: 10,
    incompleteResults: false,
    items: [
      dummyRepo(idStartWith),
      dummyRepo(idStartWith + 1),
      dummyRepo(idStartWith + 2),
      dummyRepo(idStartWith + 3),
      dummyRepo(idStartWith + 4),
      dummyRepo(idStartWith + 5),
      dummyRepo(idStartWith + 6),
      dummyRepo(idStartWith + 7),
      dummyRepo(idStartWith + 8),
      dummyRepo(idStartWith + 9),
    ],
  );
}

import 'dart:convert';

import 'package:flutter_engineer_codecheck/data/app_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_repo_content_result.freezed.dart';
part 'fetch_repo_content_result.g.dart';

enum Encoding {
  base64,
}

@freezed
class FetchRepoContentResult with _$FetchRepoContentResult {
  const factory FetchRepoContentResult({
    required String encoding,
    required String name,
    required String content,
  }) = _FetchRepoContentResult;

  const FetchRepoContentResult._();

  factory FetchRepoContentResult.fromJson(Map<String, Object?> json) =>
      _$FetchRepoContentResultFromJson(json);

  String decodedContent() {
    if (encoding == Encoding.base64.name) {
      // github api は自動的に改行コードを含むので、base64Decode する前に改行コードを削除する
      // この改行コードは元ファイルに含まれていないものなので安全に消せる
      return String.fromCharCodes(base64Decode(content.replaceAll('\n', '')));
    }
    throw AppException(Exception('Unknown encoding: $encoding'));
  }
}

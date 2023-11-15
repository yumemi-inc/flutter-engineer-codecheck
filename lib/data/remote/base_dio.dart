import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_dio.g.dart';

@riverpod
Dio baseDio(BaseDioRef ref) {
  return BaseDio.getInstance();
}

// 全てのdioに共通する設定をここで行う
class BaseDio with DioMixin implements Dio {
  BaseDio._([BaseOptions? options]) {
    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    this.options = options;

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() => BaseDio._();
}

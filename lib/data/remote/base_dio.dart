import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

part 'base_dio.g.dart';

@riverpod
Dio baseDio(BaseDioRef ref) {
  return BaseDio.getInstance();
}

class BaseDio with DioMixin implements Dio {
  BaseDio._([BaseOptions? options]) {
    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    this.options = options;
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers.addAll(await userAgentClientHintsHeader());
          handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() => BaseDio._();
}

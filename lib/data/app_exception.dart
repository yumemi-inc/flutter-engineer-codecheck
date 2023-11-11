import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

enum AppExceptionType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}

// リポジトリ層で起こった外部エラーをアプリケーション層で扱えるようにするためのクラス
// プロジェクト毎にendpointで分けたり、エラーの種類を増やしたりする
class AppException implements Exception {
  AppException(Exception? error) {
    if (error is DioException) {
      debugPrint('AppException(DioException): '
          'type is ${error.type}, message is ${error.message}');
      message = error.message ?? 'no message';
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          type = AppExceptionType.timeout;
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
          type = AppExceptionType.network;
        case DioExceptionType.badCertificate:
          type = AppExceptionType.server;
        case DioExceptionType.badResponse:
          // TODO(api): need define more http status;
          switch (error.response?.statusCode) {
            case HttpStatus.badRequest: // 400
              type = AppExceptionType.badRequest;
            case HttpStatus.unauthorized: // 401
              type = AppExceptionType.unauthorized;
            case HttpStatus.internalServerError: // 500
            case HttpStatus.badGateway: // 502
            case HttpStatus.serviceUnavailable: // 503
            case HttpStatus.gatewayTimeout: // 504
              type = AppExceptionType.server;
            default:
              type = AppExceptionType.unknown;
              break;
          }
        case DioExceptionType.cancel:
          type = AppExceptionType.cancel;
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = AppExceptionType.network;
          } else {
            type = AppExceptionType.unknown;
          }
      }
    } else {
      debugPrint('AppException(UnKnown): $error');
      type = AppExceptionType.unknown;
      message = 'AppException: $error';
    }
  }
  late String message;
  late AppExceptionType type;
}

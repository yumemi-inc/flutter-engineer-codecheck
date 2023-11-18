import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_dio.g.dart';

@riverpod
Dio imageDio(ImageDioRef ref) {
  return ImageDio.getInstance();
}

// LogInterceptorで画像をログに出力すると、ログが巨大になるので、画像のリクエストにはLogInterceptorを適用しない
class ImageDio with DioMixin implements Dio {
  ImageDio._([BaseOptions? options]) {
    options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    this.options = options;

    httpClientAdapter = HttpClientAdapter();
  }

  static Dio getInstance() => ImageDio._();
}

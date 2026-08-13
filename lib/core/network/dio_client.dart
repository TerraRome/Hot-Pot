import 'package:dio/dio.dart';
import 'package:hot_pot/core/constants/app_constants.dart';
import 'package:hot_pot/core/errors/app_exception.dart';

/// Singleton Dio client dengan interceptor dan error handling.
class DioClient {
  DioClient._() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.connectTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        sendTimeout: AppConstants.sendTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    )
      ..interceptors.add(_LogInterceptor())
      ..interceptors.add(_ErrorInterceptor());
  }

  static final DioClient instance = DioClient._();

  late final Dio _dio;

  Dio get dio => _dio;
}

class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] --> ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] <-- ${response.statusCode} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[DIO] ERROR ${err.response?.statusCode} ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const NetworkException('Connection timed out.'),
      DioExceptionType.badResponse => NetworkException(
          err.response?.statusMessage ?? 'Server error.',
          statusCode: err.response?.statusCode,
        ),
      DioExceptionType.cancel => const NetworkException('Request cancelled.'),
      _ => const UnknownException(),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/session_storage.dart';
import 'api_constants.dart';
import 'dio_interceptor.dart';

/// Builds and configures the single Dio instance for the app.
///
/// Why this class exists:
/// - Project rule: create only ONE Dio client
/// - Central place for base URL, timeouts, headers, and interceptors
/// - Keeps setup out of widgets and feature code
class DioClient {
  DioClient({SessionStorage? sessionStorage}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // App logic interceptor (offline check + auth token).
    _dio.interceptors.add(AppInterceptor(sessionStorage: sessionStorage));

    // Pretty logger: prints clean request/response logs while debugging.
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }

  late final Dio _dio;

  /// The shared Dio instance used by [ApiService].
  Dio get dio => _dio;
}

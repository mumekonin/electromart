import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Custom Dio interceptor for ElectroMart.
///
/// Why this class exists:
/// - Runs before / after every HTTP call without repeating code
/// - Checks internet availability before sending a request
/// - Ready place to attach an auth token later (login session)
///
/// Flow:
/// 1. onRequest  → check connection (and later add token)
/// 2. onResponse → pass response through (no change for now)
/// 3. onError    → pass error through (ApiService maps it)
class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Fail early when the device is offline.
    final hasConnection = await InternetConnection().hasInternetAccess;

    if (!hasConnection) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: 'No internet connection',
        ),
      );
    }

    // Later (auth module):
    // final token = ... from SharedPreferences;
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Keep the original error. ApiService will turn it into NetworkException.
    handler.next(err);
  }
}

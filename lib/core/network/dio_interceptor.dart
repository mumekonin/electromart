import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../storage/session_storage.dart';

/// Custom Dio interceptor for ElectroMart.
///
/// Why this class exists:
/// - Runs before / after every HTTP call without repeating code
/// - Checks internet availability before sending a request
/// - Attaches the saved JWT token when the user is logged in
class AppInterceptor extends Interceptor {
  AppInterceptor({this._sessionStorage});

  /// Optional because Dio may be created before a session exists.
  final SessionStorage? _sessionStorage;

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

    // Attach JWT from local session when available.
    final token = _sessionStorage?.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Keep the original error. ApiService will turn it into NetworkException.
    handler.next(err);
  }
}

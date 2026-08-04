import 'package:dio/dio.dart';

/// App-friendly error type for networking failures.
///
/// Why this class exists:
/// - Dio errors are technical (`DioExceptionType.receiveTimeout`, status 500, ...)
/// - UI and repositories should see clear messages instead
/// - One place to map all network errors (timeout, offline, API error, unknown)
class NetworkException implements Exception {
  /// Message safe to show to the user.
  final String message;

  /// HTTP status code when the server replied with an error (e.g. 404, 500).
  final int? statusCode;

  const NetworkException(this.message, {this.statusCode});

  /// Converts a Dio error into a [NetworkException].
  factory NetworkException.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException(
          'The request timed out. Please try again.',
        );

      case DioExceptionType.connectionError:
        return const NetworkException(
          'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return NetworkException(
          _messageFromStatusCode(exception.response?.statusCode),
          statusCode: exception.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return const NetworkException('The request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkException(
          'Secure connection failed. Please try again later.',
        );

      case DioExceptionType.unknown:
        return const NetworkException(
          'Something went wrong. Please try again.',
        );
    }
  }

  /// Maps common HTTP status codes to friendly text.
  static String _messageFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Wrong username or password.';
      case 403:
        return 'You do not have permission to do that.';
      case 404:
        return 'The requested resource was not found.';
      case 500:
      case 502:
      case 503:
        return 'Server error. Please try again later.';
      default:
        return 'Unexpected server response. Please try again.';
    }
  }

  @override
  String toString() => 'NetworkException($statusCode): $message';
}

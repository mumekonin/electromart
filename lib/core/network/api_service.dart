import 'package:dio/dio.dart';

import 'api_response.dart';
import 'network_exception.dart';

/// Thin wrapper around Dio HTTP methods.
///
/// Why this class exists:
/// - Project rule: use ONE ApiService for all HTTP calls
/// - Feature data sources call this instead of Dio directly
/// - Converts Dio errors into [NetworkException] with friendly messages
///
/// Presentation / UI must NEVER call this class.
/// Repositories (via remote data sources) are the correct callers.
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// Sends a GET request.
  Future<ApiResponse<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      () => _dio.get(path, queryParameters: queryParameters),
    );
  }

  /// Sends a POST request.
  Future<ApiResponse<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  /// Sends a PUT request.
  Future<ApiResponse<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  /// Sends a DELETE request.
  Future<ApiResponse<dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _request(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  /// Shared try/catch so every method handles errors the same way.
  Future<ApiResponse<dynamic>> _request(
    Future<Response<dynamic>> Function() call,
  ) async {
    try {
      final response = await call();
      return ApiResponse.success(response.data);
    } on DioException catch (exception) {
      throw NetworkException.fromDioException(exception);
    } catch (_) {
      throw const NetworkException(
        'Something went wrong. Please try again.',
      );
    }
  }
}

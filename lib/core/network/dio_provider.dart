import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_service.dart';
import 'dio_client.dart';

/// Provides the single shared [Dio] instance.
///
/// Why this provider exists:
/// - Riverpod can inject Dio anywhere without creating new clients
/// - Guarantees we reuse one configured Dio (base URL, interceptors, logger)
///
/// Usage later:
/// ```dart
/// final dio = ref.watch(dioProvider);
/// ```
final dioProvider = Provider<Dio>((ref) {
  return DioClient().dio;
});

/// Provides the shared [ApiService].
///
/// Feature remote data sources will watch this provider.
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

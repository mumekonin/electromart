import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/network_exception.dart';
import '../../../../core/storage/storage_provider.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';

/// Provides the auth remote data source.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(apiServiceProvider));
});

/// Provides the auth repository implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    sessionStorage: ref.watch(sessionStorageProvider),
  );
});

/// Provides the login use case.
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

/// Manages authentication state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for auth (loading / success / error)
/// - Restores a saved session when the app starts
/// - Exposes a simple [login] method for the UI
class AuthNotifier extends AsyncNotifier<UserSession?> {
  @override
  Future<UserSession?> build() async {
    // Try to restore a previous login from SharedPreferences.
    return ref.read(authRepositoryProvider).restoreSession();
  }

  /// Attempts login and updates [state] to loading → data/error.
  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(loginUseCaseProvider)(
        username: username,
        password: password,
      );
    });
  }

  /// Friendly error text for SnackBars / UI.
  static String errorMessage(Object error) {
    if (error is NetworkException) {
      return error.message;
    }
    return 'Something went wrong. Please try again.';
  }
}

/// Global auth provider used by Login, Splash, and GoRouter.
final authProvider =
    AsyncNotifierProvider<AuthNotifier, UserSession?>(AuthNotifier.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/error_message.dart';
import '../../../../core/storage/storage_provider.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

/// Provides the auth remote data source.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(ref.watch(apiServiceProvider));
});

/// Provides the auth repository implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(sessionStorageProvider),
  );
});

/// Provides the login use case.
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

/// Provides the logout use case.
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

/// Manages authentication state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for auth (loading / success / error)
/// - Restores a saved session when the app starts
/// - [logout] is the single entry point used by Profile and Settings
class AuthNotifier extends AsyncNotifier<UserSession?> {
  @override
  Future<UserSession?> build() async {
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

  /// Clears the saved session and marks the user as logged out.
  ///
  /// Call this from Profile / Settings after the confirm dialog.
  Future<void> logout() async {
    await ref.read(logoutUseCaseProvider)();
    state = const AsyncData(null);
  }

  /// Friendly error text for SnackBars / UI.
  static String errorMessage(Object error) {
    return mapErrorMessage(error);
  }
}

/// Global auth provider used by Login, Splash, and GoRouter.
final authProvider =
    AsyncNotifierProvider<AuthNotifier, UserSession?>(AuthNotifier.new);

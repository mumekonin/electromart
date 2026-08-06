import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/network_exception.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../data/datasource/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

// ---------------------------------------------------------------------------
// Dependency injection (Riverpod providers)
// ---------------------------------------------------------------------------

/// Provides the remote profile data source (Fake Store GET /users/{id}).
final profileRemoteDataSourceProvider =
    Provider<ProfileRemoteDataSource>((ref) {
  return ProfileRemoteDataSource(ref.watch(apiServiceProvider));
});

/// Provides the profile repository implementation.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.watch(profileRemoteDataSourceProvider));
});

final getUserProfileUseCaseProvider = Provider<GetUserProfileUseCase>((ref) {
  return GetUserProfileUseCase(ref.watch(profileRepositoryProvider));
});

/// Logout reuses AuthRepository (clears SharedPreferences session).
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Profile state (AsyncNotifier)
// ---------------------------------------------------------------------------

/// Manages profile state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for profile (loading / success / error)
/// - UI calls [refresh] and [logout] — never Dio or SharedPreferences
///
/// Important Fake Store detail:
/// - Login only saves a token
/// - Profile always fetches GET /users/{demoProfileUserId}
class ProfileNotifier extends AsyncNotifier<UserProfile> {
  /// Loads the profile when [profileProvider] is first watched.
  @override
  Future<UserProfile> build() {
    return ref.read(getUserProfileUseCaseProvider)(
      ApiConstants.demoProfileUserId,
    );
  }

  /// Reloads the profile (used by the Retry / pull-to-refresh actions).
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getUserProfileUseCaseProvider)(
        ApiConstants.demoProfileUserId,
      );
    });
  }

  /// Clears the session and syncs [authProvider] so GoRouter redirects
  /// to Login and the back button cannot return to Profile.
  Future<void> logout() async {
    // 1) Clear token + login flag from SharedPreferences.
    await ref.read(logoutUseCaseProvider)();

    // 2) Sync in-memory auth state (GoRouter listens to authProvider).
    //    We invalidate instead of calling AuthNotifier.logout() again,
    //    so SharedPreferences is not cleared twice.
    ref.invalidate(authProvider);
  }

  /// Friendly error text for the Profile error UI.
  static String errorMessage(Object error) {
    if (error is NetworkException) {
      return error.message;
    }
    return 'Something went wrong while loading your profile. Please try again.';
  }
}

/// Main profile provider used by [ProfilePage].
final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserProfile>(ProfileNotifier.new);

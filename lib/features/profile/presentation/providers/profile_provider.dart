import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/error_message.dart';
import '../../data/datasource/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';

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

// ---------------------------------------------------------------------------
// Profile state (AsyncNotifier)
// ---------------------------------------------------------------------------

/// Manages profile state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for profile (loading / success / error)
/// - UI calls [refresh] — never Dio directly
///
/// Logout lives on [authProvider] (single session owner).
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

  /// Friendly error text for the Profile error UI.
  static String errorMessage(Object error) {
    return mapErrorMessage(
      error,
      fallback:
          'Something went wrong while loading your profile. Please try again.',
    );
  }
}

/// Main profile provider used by [ProfilePage].
final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserProfile>(ProfileNotifier.new);

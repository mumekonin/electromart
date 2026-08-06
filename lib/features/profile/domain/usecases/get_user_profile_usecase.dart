import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

/// Loads the user profile for the Profile screen.
///
/// Why a use case?
/// - Keeps the provider thin (UI → use case → repository)
/// - Easy to test later without Flutter widgets
class GetUserProfileUseCase {
  GetUserProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<UserProfile> call(int userId) {
    return _repository.getUserProfile(userId);
  }
}

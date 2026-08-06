import '../entities/user_profile.dart';

/// Abstract profile contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT profile can do
/// - Data layer defines HOW (Fake Store API via Dio)
/// - Use cases depend on this interface, not on ApiService
abstract class ProfileRepository {
  /// Loads one user profile by Fake Store user id.
  Future<UserProfile> getUserProfile(int userId);
}

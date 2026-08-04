import '../entities/user_session.dart';

/// Abstract auth contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT auth can do
/// - Data layer defines HOW it is done (API + SharedPreferences)
/// - Use cases and UI depend on this interface, not on Dio
abstract class AuthRepository {
  /// Logs in with username/password and returns a session.
  Future<UserSession> login({
    required String username,
    required String password,
  });

  /// Restores a previously saved session from local storage.
  Future<UserSession?> restoreSession();

  /// Clears the saved session (logout).
  Future<void> logout();
}

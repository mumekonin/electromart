/// Domain entity that represents a logged-in user session.
///
/// Why this class exists:
/// - The UI and use cases should not depend on API JSON models
/// - A session is simply "a token + logged-in flag" for this app
/// - Keeps domain logic independent from Dio / SharedPreferences
class UserSession {
  const UserSession({
    required this.token,
    required this.isLoggedIn,
  });

  /// JWT token returned by Fake Store API.
  final String token;

  /// Whether the user is considered logged in.
  final bool isLoggedIn;
}

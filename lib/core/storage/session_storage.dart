import 'package:shared_preferences/shared_preferences.dart';

/// Saves and reads the login session on the device.
///
/// Why this class exists:
/// - SharedPreferences is a low-level key/value API
/// - This wrapper gives clear methods: saveToken, getToken, etc.
/// - Auth repository talks to this instead of SharedPreferences directly
class SessionStorage {
  SessionStorage(this._prefs);

  final SharedPreferences _prefs;

  static const String _tokenKey = 'auth_token';
  static const String _loggedInKey = 'is_logged_in';

  /// Saves the JWT and marks the user as logged in.
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
    await _prefs.setBool(_loggedInKey, true);
  }

  /// Returns the saved JWT, or null if none exists.
  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  /// Removes the token and clears the login flag.
  Future<void> clearSession() async {
    await _prefs.remove(_tokenKey);
    await _prefs.setBool(_loggedInKey, false);
  }

  /// Returns true when a previous login was saved on this device.
  bool isLoggedIn() {
    final hasFlag = _prefs.getBool(_loggedInKey) ?? false;
    final token = getToken();
    return hasFlag && token != null && token.isNotEmpty;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'session_storage.dart';

/// Provides the app-wide [SharedPreferences] instance.
///
/// Why this provider exists:
/// - SharedPreferences must be created once (async) in [main]
/// - We override this provider with the real instance at startup
///
/// Do not read this before it is overridden in main.dart.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main()',
  );
});

/// Provides [SessionStorage] for saving / reading the login session.
final sessionStorageProvider = Provider<SessionStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SessionStorage(prefs);
});

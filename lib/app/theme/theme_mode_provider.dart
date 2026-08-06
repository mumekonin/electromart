import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/storage/storage_provider.dart';

/// Saves / restores light vs dark mode.
///
/// Why this provider exists:
/// - Settings Dark Mode switch needs one shared place for theme state
/// - [App] watches this and passes [themeMode] to MaterialApp
/// - Choice is saved in SharedPreferences so it survives app restarts
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const String _prefsKey = 'is_dark_mode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final isDark = prefs.getBool(_prefsKey) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Turns dark mode on or off and saves the choice.
  Future<void> setDarkMode(bool enabled) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_prefsKey, enabled);
    state = enabled ? ThemeMode.dark : ThemeMode.light;
  }

  /// Handy bool for Switch widgets.
  bool get isDarkMode => state == ThemeMode.dark;
}

/// Global theme mode used by [App] and Settings.
final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

import 'package:flutter/material.dart';

/// Central place for all colors used in ElectroMart.
///
/// Why a separate file?
/// - Keeps colors consistent across the whole app
/// - Makes it easy to update the brand look in one place
/// - Prevents hard-coding Color(...) values inside widgets
///
/// Light vs dark:
/// - Use the plain constants inside [AppTheme] (no BuildContext there)
/// - In widgets, prefer [backgroundOf], [surfaceOf], … so Dark Mode works
class AppColors {
  AppColors._();

  // --- Brand colors (same in light + dark) ---

  static const Color primary = Color(0xFF1D4ED8);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color primaryLight = Color(0xFFDBEAFE);
  static const Color secondary = Color(0xFF0F766E);

  // --- Light neutrals ---

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Dark neutrals ---

  static const Color backgroundDark = Color(0xFF0B1220);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color borderDark = Color(0xFF334155);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color primaryLightDark = Color(0xFF1E3A5F);

  // --- Feedback ---

  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFDC2626);
  static const Color warning = Color(0xFFD97706);

  /// True when the current theme is dark.
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color backgroundOf(BuildContext context) {
    return isDark(context) ? backgroundDark : background;
  }

  static Color surfaceOf(BuildContext context) {
    return isDark(context) ? surfaceDark : surface;
  }

  static Color borderOf(BuildContext context) {
    return isDark(context) ? borderDark : border;
  }

  static Color textPrimaryOf(BuildContext context) {
    return isDark(context) ? textPrimaryDark : textPrimary;
  }

  static Color textSecondaryOf(BuildContext context) {
    return isDark(context) ? textSecondaryDark : textSecondary;
  }

  /// Soft primary tint for chips / avatar circles.
  static Color primarySoftOf(BuildContext context) {
    return isDark(context) ? primaryLightDark : primaryLight;
  }
}

import 'package:flutter/material.dart';

/// Central place for all colors used in ElectroMart.
///
/// Why a separate file?
/// - Keeps colors consistent across the whole app
/// - Makes it easy to update the brand look in one place
/// - Prevents hard-coding Color(...) values inside widgets
class AppColors {
  // Private constructor — this class is only used for static values.
  // You never create an instance like: AppColors()
  AppColors._();

  // --- Brand colors ---

  /// Main brand color (buttons, highlights, selected items).
  static const Color primary = Color(0xFF1D4ED8);

  /// Slightly darker primary for pressed states.
  static const Color primaryDark = Color(0xFF1E3A8A);

  /// Lighter primary for soft backgrounds and chips.
  static const Color primaryLight = Color(0xFFDBEAFE);

  /// Secondary accent (ratings, badges, small highlights).
  static const Color secondary = Color(0xFF0F766E);

  // --- Neutral / surface colors ---

  /// Default screen background.
  static const Color background = Color(0xFFF8FAFC);

  /// Card and sheet surfaces.
  static const Color surface = Color(0xFFFFFFFF);

  /// Soft border / divider color.
  static const Color border = Color(0xFFE2E8F0);

  // --- Text colors ---

  /// Main body text.
  static const Color textPrimary = Color(0xFF0F172A);

  /// Secondary / helper text.
  static const Color textSecondary = Color(0xFF64748B);

  /// Text on top of primary-colored buttons.
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // --- Feedback colors ---

  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFDC2626);
  static const Color warning = Color(0xFFD97706);
}

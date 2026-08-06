import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Text styles used across ElectroMart.
///
/// We use Google Fonts (Inter) for a clean, modern look.
/// ScreenUtil (.sp) scales font sizes so they look good on
/// phones of different sizes.
class AppTextTheme {
  AppTextTheme._();

  /// Builds the Material [TextTheme] for light or dark mode.
  static TextTheme build({Brightness brightness = Brightness.light}) {
    final isDark = brightness == Brightness.dark;
    final primaryText =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final secondaryText =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    final base = GoogleFonts.inter(color: primaryText);

    return TextTheme(
      displayLarge: base.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      displayMedium: base.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      displaySmall: base.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      headlineLarge: base.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineMedium: base.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      headlineSmall: base.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleLarge: base.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleMedium: base.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleSmall: base.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      bodyLarge: base.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primaryText,
      ),
      bodyMedium: base.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: primaryText,
      ),
      bodySmall: base.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: secondaryText,
      ),
      labelLarge: base.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      labelMedium: base.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      labelSmall: base.copyWith(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: secondaryText,
      ),
    );
  }
}

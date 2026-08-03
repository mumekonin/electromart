import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Consistent spacing values used throughout the app.
///
/// Instead of writing magic numbers like `SizedBox(height: 16)`,
/// use these named values so spacing stays consistent.
///
/// Example:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(AppSpacing.md),
///   child: ...,
/// )
/// ```
class AppSpacing {
  AppSpacing._();

  /// 4 logical pixels (scaled).
  static double get xs => 4.w;

  /// 8 logical pixels (scaled).
  static double get sm => 8.w;

  /// 16 logical pixels (scaled) — most common padding.
  static double get md => 16.w;

  /// 24 logical pixels (scaled).
  static double get lg => 24.w;

  /// 32 logical pixels (scaled).
  static double get xl => 32.w;

  /// 48 logical pixels (scaled).
  static double get xxl => 48.w;

  /// Standard corner radius for cards and buttons.
  static double get radius => 12.r;

  /// Larger corner radius for dialogs and sheets.
  static double get radiusLarge => 16.r;
}

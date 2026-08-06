import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ElectroMart logo shown on the splash screen.
///
/// Why this widget exists:
/// - Keeps the image path in one place
/// - [SplashPage] stays shorter and easier to read
///
/// Asset used: `assets/images/logo.png`
/// (already registered under `assets/images/` in pubspec.yaml)
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  static const String assetPath = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: 220.w,
      fit: BoxFit.contain,
      // Helps beginners see a clear message if the asset path is wrong.
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.bolt_rounded,
          size: 72.sp,
          color: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}

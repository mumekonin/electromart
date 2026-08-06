import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// App name + tagline under the logo.
///
/// Why this widget exists:
/// - Separates text branding from the logo image
/// - Makes the splash layout easy to tweak later
class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ElectroMart',
          style: textTheme.displaySmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(AppSpacing.sm),
        Text(
          'Powering Your Digital Lifestyle',
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

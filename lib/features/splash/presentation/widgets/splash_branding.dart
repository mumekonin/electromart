import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

/// Tagline under the splash logo.
///
/// The logo image already includes the ElectroMart name,
/// so we do not repeat "ElectroMart" as text here.
class SplashBranding extends StatelessWidget {
  const SplashBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      'Powering Your Digital Lifestyle',
      style: textTheme.bodyLarge?.copyWith(
        color: AppColors.textSecondaryOf(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}

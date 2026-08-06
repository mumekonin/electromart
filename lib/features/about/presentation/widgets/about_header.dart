import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Top of the About page: logo, app name, and tagline.
///
/// Why this widget exists:
/// - Keeps the header layout out of [AboutPage]
/// - Reuses the same logo asset as Splash (`assets/images/logo.png`)
class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  static const String logoAsset = 'assets/images/logo.png';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Image.asset(
          logoAsset,
          width: 200.w,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.bolt_rounded,
              size: 72.sp,
              color: AppColors.primary,
            );
          },
        ),
        Gap(AppSpacing.md),
        Text(
          'ElectroMart',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(AppSpacing.xs),
        Text(
          'Powering Your Digital Lifestyle',
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondaryOf(context),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

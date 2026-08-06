import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Simple About screen for ElectroMart.
///
/// Why this page is small:
/// - Settings only needs a place to show app info
/// - No API / repository — static text is enough for beginners
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      appBar: AppBar(
        title: const Text('About ElectroMart'),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                color: AppColors.primarySoftOf(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bolt_rounded,
                size: 44.sp,
                color: AppColors.primary,
              ),
            ),
          ),
          Gap(AppSpacing.lg),
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
          Gap(AppSpacing.xl),
          Container(
            padding: EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceOf(context),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(color: AppColors.borderOf(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About this app', style: textTheme.titleMedium),
                Gap(AppSpacing.sm),
                Text(
                  'ElectroMart is a demo electronics store built with Flutter. '
                  'It uses the Fake Store API for products and login, and keeps '
                  'your cart and session on this device.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryOf(context),
                    height: 1.45,
                  ),
                ),
                Gap(AppSpacing.md),
                Text('Version', style: textTheme.titleSmall),
                Gap(AppSpacing.xs),
                Text(
                  '1.0.0',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryOf(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

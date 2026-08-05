import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Simple skeleton shown while product details load.
///
/// Why this widget exists:
/// - Feels more premium than a lone spinner
/// - No extra shimmer package required
class ProductDetailsLoadingView extends StatelessWidget {
  const ProductDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SkeletonBox(height: 320.h, radius: AppSpacing.radiusLarge),
          Gap(AppSpacing.lg),
          _SkeletonBox(height: 18.h, width: 100.w),
          Gap(AppSpacing.sm),
          _SkeletonBox(height: 24.h, width: double.infinity),
          Gap(AppSpacing.sm),
          _SkeletonBox(height: 24.h, width: 220.w),
          Gap(AppSpacing.md),
          _SkeletonBox(height: 28.h, width: 120.w),
          Gap(AppSpacing.md),
          _SkeletonBox(height: 18.h, width: 180.w),
          Gap(AppSpacing.lg),
          _SkeletonBox(height: 18.h, width: 140.w),
          Gap(AppSpacing.sm),
          _SkeletonBox(height: 80.h, width: double.infinity),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.height,
    this.width,
    this.radius,
  });

  final double height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.border.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(radius ?? AppSpacing.radius),
      ),
    );
  }
}

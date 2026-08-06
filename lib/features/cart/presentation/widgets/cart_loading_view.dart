import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Skeleton placeholders shown while the cart loads from storage.
///
/// Looks like a few cart rows so the page does not feel empty
/// during the short SharedPreferences read.
class CartLoadingView extends StatelessWidget {
  const CartLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      itemCount: 4,
      separatorBuilder: (_, _) => Gap(AppSpacing.sm),
      itemBuilder: (context, index) {
        return const _CartSkeletonTile();
      },
    );
  }
}

/// One fake cart row (grey boxes that suggest image + text).
class _CartSkeletonTile extends StatelessWidget {
  const _CartSkeletonTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderOf(context)),
      ),
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: AppColors.backgroundOf(context),
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
          ),
          Gap(AppSpacing.sm),
          // Text placeholders
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bar(context, width: double.infinity, height: 14.h),
                Gap(AppSpacing.xs),
                _bar(context, width: 80.w, height: 12.h),
                Gap(AppSpacing.sm),
                _bar(context, width: 100.w, height: 28.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundOf(context),
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}

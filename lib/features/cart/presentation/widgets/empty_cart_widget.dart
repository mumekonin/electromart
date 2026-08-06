import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Shown when the cart has zero items.
///
/// Friendly empty state with a clear next step: browse products.
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Soft circle behind the cart icon
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: AppColors.primarySoftOf(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 56.sp,
                color: AppColors.primary,
              ),
            ),
            Gap(AppSpacing.xl),
            Text(
              'Your cart is empty',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
            Text(
              'Browse electronics and tap “Add to Cart” '
              'on any product. Your items will show up here.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryOf(context),
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.xl),
            FilledButton.icon(
              // Switch to the Home tab inside the main shell.
              onPressed: () => context.go(AppRoutes.home),
              icon: const Icon(Icons.storefront_outlined),
              label: const Text('Browse products'),
            ),
            Gap(AppSpacing.sm),
            Text(
              'Tip: the cart badge on Home updates as you shop.',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondaryOf(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Shown when a product id does not exist.
///
/// Why this widget exists:
/// - Friendly empty/not-found state for details
/// - Lets the user go back to the product list
class ProductNotFoundView extends StatelessWidget {
  const ProductNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 72.sp,
              color: AppColors.textSecondaryOf(context),
            ),
            Gap(AppSpacing.md),
            Text(
              'Product not found',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
            Text(
              'This product may have been removed or the link is invalid.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryOf(context),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

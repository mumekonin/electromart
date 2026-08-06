import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Friendly full-page error when the cart cannot be loaded.
///
/// Shows a clear message and a Retry button so beginners can
/// recover without restarting the app.
class CartErrorWidget extends StatelessWidget {
  const CartErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  /// Human-readable explanation (already mapped from the exception).
  final String message;

  /// Called when the user taps Retry (usually refreshes cartProvider).
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 40.sp,
                color: AppColors.error,
              ),
            ),
            Gap(AppSpacing.lg),
            Text(
              'Could not load your cart',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryOf(context),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.xl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

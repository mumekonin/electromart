import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import 'primary_button.dart';

/// Shared error UI with icon, message, and Retry.
///
/// Why this widget exists:
/// - Home, Cart, Profile, and Details all need the same error pattern
/// - Feature pages only pass the message + retry callback
class AppError extends StatelessWidget {
  const AppError({
    required this.message,
    required this.onRetry,
    this.title = 'Something went wrong',
    this.icon = Icons.wifi_off_rounded,
    this.retryLabel = 'Retry',
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final String retryLabel;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64.sp, color: AppColors.error),
            Gap(AppSpacing.md),
            Text(
              title,
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
            Gap(AppSpacing.lg),
            PrimaryButton(
              label: retryLabel,
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

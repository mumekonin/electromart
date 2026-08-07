import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import 'primary_button.dart';

/// Shared empty-state UI (no products, no search results, empty cart, …).
///
/// Why this widget exists:
/// - Same friendly layout everywhere: icon → title → description → action
/// - Feature screens only change the copy and optional button
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    this.actionIcon,
    super.key,
  });

  final IconData icon;
  final String title;
  final String description;

  /// Optional CTA button (example: "Browse products").
  final String? actionLabel;
  final VoidCallback? onAction;
  final IconData? actionIcon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.w,
              height: 96.w,
              decoration: BoxDecoration(
                color: AppColors.primarySoftOf(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44.sp, color: AppColors.primary),
            ),
            Gap(AppSpacing.lg),
            Text(
              title,
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryOf(context),
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              Gap(AppSpacing.lg),
              PrimaryButton(
                label: actionLabel!,
                icon: actionIcon,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

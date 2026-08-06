import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Small category chip shown on Product Details.
///
/// Why this widget exists:
/// - Keeps badge styling consistent
/// - Makes the details page layout easier to read
class CategoryBadge extends StatelessWidget {
  const CategoryBadge({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoftOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Text(
        category.toUpperCase(),
        style: textTheme.labelSmall?.copyWith(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

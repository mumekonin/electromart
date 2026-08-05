import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/product.dart';

/// Star rating + review count for Product Details.
///
/// Why this widget exists:
/// - Encodes how we draw 0–5 stars from [ProductRating.rate]
/// - Keeps the details page free of star-drawing math
class RatingSection extends StatelessWidget {
  const RatingSection({
    super.key,
    required this.rating,
  });

  final ProductRating rating;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        ...List.generate(5, (index) {
          // Fill stars based on the average rate (example: 3.9 → 4 stars).
          final starIndex = index + 1;
          final icon = starIndex <= rating.rate.round()
              ? Icons.star_rounded
              : Icons.star_outline_rounded;

          return Icon(
            icon,
            size: 20.sp,
            color: AppColors.warning,
          );
        }),
        Gap(AppSpacing.sm),
        Text(
          rating.rate.toStringAsFixed(1),
          style: textTheme.titleSmall,
        ),
        Gap(AppSpacing.xs),
        Text(
          '(${rating.count} reviews)',
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

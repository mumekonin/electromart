import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Product description block for Product Details.
///
/// Why this widget exists:
/// - Separates the long text section from the page layout
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About this product',
          style: textTheme.titleLarge,
        ),
        Gap(AppSpacing.sm),
        Text(
          description,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondaryOf(context),
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

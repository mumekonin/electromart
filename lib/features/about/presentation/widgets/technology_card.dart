import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// One technology row used in the About → Technologies section.
///
/// Why this widget exists:
/// - Keeps icon + name + short description in one reusable place
/// - About page stays short and easy to read
class TechnologyCard extends StatelessWidget {
  const TechnologyCard({
    required this.icon,
    required this.name,
    required this.description,
    super.key,
  });

  final IconData icon;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: AppColors.borderOf(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySoftOf(context),
              borderRadius: BorderRadius.circular(AppSpacing.radius),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: textTheme.titleMedium),
                const Gap(2),
                Text(
                  description,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryOf(context),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Reusable list tile for Profile actions (Settings, Logout, …).
class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.isDestructive = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color =
        isDestructive ? AppColors.error : AppColors.textPrimaryOf(context);
    final iconColor = isDestructive ? AppColors.error : AppColors.primary;

    return Material(
      color: AppColors.surfaceOf(context),
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(color: AppColors.borderOf(context)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDestructive
                      ? AppColors.error.withValues(alpha: 0.08)
                      : AppColors.primarySoftOf(context),
                  borderRadius: BorderRadius.circular(AppSpacing.radius),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium?.copyWith(color: color),
                    ),
                    if (subtitle != null) ...[
                      Gap(AppSpacing.xs),
                      Text(
                        subtitle!,
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondaryOf(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondaryOf(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

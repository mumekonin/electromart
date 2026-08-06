import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';

/// Card that shows email, phone, and address from the API.
///
/// Values come from [UserProfile] — nothing is hardcoded in the UI.
class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderOf(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact details',
            style: textTheme.titleMedium,
          ),
          Gap(AppSpacing.md),
          _InfoRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: profile.email,
          ),
          Gap(AppSpacing.md),
          _InfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: profile.phone,
          ),
          Gap(AppSpacing.md),
          _InfoRow(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: profile.formattedAddress,
          ),
        ],
      ),
    );
  }
}

/// One labeled row inside [ProfileInfoCard].
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: AppColors.primary),
        Gap(AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondaryOf(context),
                ),
              ),
              Gap(2),
              Text(
                value,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';
import 'profile_avatar.dart';

/// Top section of the Profile page: soft banner + avatar + name.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primarySoftOf(context),
            AppColors.surfaceOf(context),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderOf(context)),
      ),
      child: Column(
        children: [
          ProfileAvatar(fullName: profile.fullName),
          Gap(AppSpacing.md),
          Text(
            profile.fullName,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(AppSpacing.xs),
          Text(
            '@${profile.username}',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryOf(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

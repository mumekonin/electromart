import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';
import 'profile_avatar.dart';

/// Top section of the Profile page: avatar + name + username.
///
/// Why a separate widget?
/// - Keeps [ProfilePage] shorter and easier to read
/// - One place to tweak the header look later
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.profile,
    super.key,
  });

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
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
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

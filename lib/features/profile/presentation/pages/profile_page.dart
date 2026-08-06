import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_action_tile.dart';
import '../widgets/profile_empty_view.dart';
import '../widgets/profile_error_view.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/profile_loading_view.dart';

/// User Profile screen.
///
/// Shows:
/// - Avatar (initials), full name, username
/// - Email, phone, address from Fake Store GET /users/1
/// - Action tiles (most are UI-only placeholders)
/// - Logout (clears session → Login)
///
/// Why login alone is not enough for this page:
/// - `POST /auth/login` only returns a JWT token
/// - Name / email / phone / address come from a second request
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: profileAsync.when(
        loading: () => const ProfileLoadingView(),
        error: (error, _) => ProfileErrorView(
          message: ProfileNotifier.errorMessage(error),
          onRetry: () => ref.read(profileProvider.notifier).refresh(),
        ),
        data: (profile) {
          if (profile.isUnavailable) {
            return ProfileEmptyView(
              onRetry: () => ref.read(profileProvider.notifier).refresh(),
            );
          }

          return _ProfileContent(profile: profile);
        },
      ),
    );
  }
}

/// Scrollable profile body after a successful API load.
class _ProfileContent extends ConsumerWidget {
  const _ProfileContent({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(profileProvider.notifier).refresh(),
      child: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Gap(AppSpacing.sm),
          ProfileHeader(profile: profile),
          Gap(AppSpacing.lg),
          ProfileInfoCard(profile: profile),
          Gap(AppSpacing.lg),
          Text(
            'Account',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Gap(AppSpacing.sm),

          // --- Placeholder actions (UI only) ---
          ProfileActionTile(
            icon: Icons.badge_outlined,
            title: 'Personal Information',
            subtitle: 'View your account details',
            onTap: () => _showComingSoon(context, 'Personal Information'),
          ),
          Gap(AppSpacing.sm),
          ProfileActionTile(
            icon: Icons.receipt_long_outlined,
            title: 'My Orders',
            subtitle: 'Track purchases (coming soon)',
            onTap: () => _showComingSoon(context, 'My Orders'),
          ),
          Gap(AppSpacing.sm),
          ProfileActionTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Preferences (coming soon)',
            onTap: () => _showComingSoon(context, 'Settings'),
          ),
          Gap(AppSpacing.sm),
          ProfileActionTile(
            icon: Icons.help_outline_rounded,
            title: 'Help',
            subtitle: 'Support (coming soon)',
            onTap: () => _showComingSoon(context, 'Help'),
          ),
          Gap(AppSpacing.md),

          // --- Real action: Logout ---
          ProfileActionTile(
            icon: Icons.logout_rounded,
            title: 'Logout',
            subtitle: 'Sign out of ElectroMart',
            isDestructive: true,
            onTap: () => _confirmLogout(context, ref),
          ),
          Gap(AppSpacing.xl),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$featureName is coming soon.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  /// Asks for confirmation, then clears the session and goes to Login.
  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'You will need to sign in again to continue shopping.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await ref.read(profileProvider.notifier).logout();

    if (!context.mounted) return;

    // Replace the stack with Login so the back button cannot return here.
    context.go(AppRoutes.login);
  }
}

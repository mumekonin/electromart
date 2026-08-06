import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/theme_mode_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

/// Settings screen for ElectroMart.
///
/// Why Settings has NO data / domain / repository layers:
/// - These options are local UI (switches + navigation)
/// - There is no Fake Store "settings" API to call
///
/// Dark Mode is real:
/// - Switch updates [themeModeProvider]
/// - [App] applies light / dark [ThemeData]
/// - Choice is saved in SharedPreferences
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  /// UI-only switch — no real notification system yet.
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                subtitle: 'Sign out of ElectroMart',
                isDestructive: true,
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.error,
                ),
                onTap: () => _confirmLogout(context),
              ),
            ],
          ),
          Gap(AppSpacing.lg),
          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Manage your notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
              ),
              SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                subtitle: 'Change application theme',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).setDarkMode(value);
                  },
                ),
              ),
            ],
          ),
          Gap(AppSpacing.lg),
          SettingsSection(
            title: 'Information',
            children: [
              SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'About ElectroMart',
                subtitle: 'Version and app information',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondaryOf(context),
                ),
                onTap: () => context.push(AppRoutes.about),
              ),
            ],
          ),
          Gap(AppSpacing.xl),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
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

    context.go(AppRoutes.login);
  }
}

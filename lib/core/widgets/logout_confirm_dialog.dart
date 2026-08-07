import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Shows the shared “Log out?” confirmation dialog.
///
/// Returns `true` when the user confirms, otherwise `false`.
/// Used by Profile and Settings so the dialog text stays identical.
Future<bool> showLogoutConfirmDialog(BuildContext context) async {
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

  return confirmed == true;
}

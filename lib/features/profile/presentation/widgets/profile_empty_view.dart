import 'package:flutter/material.dart';

import '../../../../core/widgets/app_empty_state.dart';

/// Shown when a profile response has no usable identity data.
class ProfileEmptyView extends StatelessWidget {
  const ProfileEmptyView({
    required this.onRetry,
    super.key,
  });

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.person_outline_rounded,
      title: 'Profile unavailable',
      description:
          'We could not find profile details for this account. '
          'Please try again in a moment.',
      actionLabel: 'Try again',
      actionIcon: Icons.refresh_rounded,
      onAction: () {
        onRetry();
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/widgets/app_error.dart';

/// Friendly error UI when the profile API call fails.
class ProfileErrorView extends StatelessWidget {
  const ProfileErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return AppError(
      title: 'Could not load profile',
      message: message,
      icon: Icons.person_off_outlined,
      onRetry: () {
        onRetry();
      },
    );
  }
}

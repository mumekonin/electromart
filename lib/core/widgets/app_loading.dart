import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

/// Shared loading indicator for ElectroMart screens.
///
/// Why this widget exists:
/// - Avoids copy-pasting CircularProgressIndicator on every page
/// - Optional [message] keeps beginners informed while data loads
class AppLoading extends StatelessWidget {
  const AppLoading({
    this.message,
    super.key,
  });

  /// Optional text under the spinner (example: "Loading products…").
  final String? message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              Gap(AppSpacing.md),
              Text(
                message!,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryOf(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

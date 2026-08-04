import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Primary login action button.
///
/// Why this widget exists:
/// - Handles enabled / disabled / loading visuals in one place
/// - Login form stays focused on wiring controllers and validation
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.isEnabled,
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final canPress = isEnabled && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: canPress ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.textOnPrimary,
                ),
              )
            : const Text('Log In'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/user_session.dart';
import '../providers/auth_provider.dart';
import '../widgets/login_form.dart';

/// Professional login screen for ElectroMart.
///
/// Why this page exists:
/// - Entry point for authentication UI
/// - Listens to [authProvider] for success / error side-effects
/// - Navigates to Home with GoRouter after a successful login
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  void _showMessage(
    BuildContext context,
    String message, {
    bool isError = true,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.error : AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    // React to auth state changes (success → Home, error → SnackBar).
    ref.listen<AsyncValue<UserSession?>>(authProvider, (previous, next) {
      next.whenOrNull(
        data: (session) {
          final wasLoading = previous?.isLoading ?? false;
          if (wasLoading && session != null && session.isLoggedIn) {
            _showMessage(
              context,
              'Welcome back!',
              isError: false,
            );
            context.go(AppRoutes.home);
          }
        },
        error: (error, _) {
          _showMessage(context, AuthNotifier.errorMessage(error));
        },
      );
    });

    final authState = ref.watch(authProvider);
    final errorText = authState.hasError
        ? AuthNotifier.errorMessage(authState.error!)
        : null;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App logo placeholder
                  Align(
                    child: Container(
                      width: 88.w,
                      height: 88.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusLarge),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 44.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Gap(AppSpacing.lg),
                  Text(
                    'Welcome to ElectroMart',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium,
                  ),
                  Gap(AppSpacing.sm),
                  Text(
                    'Sign in to continue shopping',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Gap(AppSpacing.xl),
                  const LoginForm(),
                  if (errorText != null) ...[
                    Gap(AppSpacing.md),
                    Text(
                      errorText,
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                  Gap(AppSpacing.lg),
                  Text(
                    'Demo: mor_2314 / 83r5^_',
                    textAlign: TextAlign.center,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

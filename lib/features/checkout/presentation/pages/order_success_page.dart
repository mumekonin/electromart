import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';

/// Shown after a successful demo checkout.
///
/// Why a separate page:
/// - Clear “you’re done” moment after Pay
/// - Cart is already empty, so Checkout should not reopen
class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.check_circle_rounded,
                size: 88,
                color: AppColors.primary,
              ),
              Gap(AppSpacing.lg),
              Text(
                'Order placed!',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(AppSpacing.sm),
              Text(
                'This was a demo payment. Your cart has been cleared '
                'and nothing was charged.',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryOf(context),
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Continue shopping',
                icon: Icons.storefront_outlined,
                isExpanded: true,
                onPressed: () => context.go(AppRoutes.home),
              ),
              Gap(AppSpacing.sm),
              TextButton(
                onPressed: () => context.go(AppRoutes.cart),
                child: const Text('View cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

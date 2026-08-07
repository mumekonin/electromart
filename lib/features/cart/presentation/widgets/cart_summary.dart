import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../domain/entities/cart.dart';

/// Bottom panel: item count, subtotal, and a demo checkout button.
class CartSummary extends StatelessWidget {
  const CartSummary({
    required this.cart,
    this.isBusy = false,
    super.key,
  });

  final Cart cart;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final itemLabel = cart.totalQuantity == 1
        ? '1 item'
        : '${cart.totalQuantity} items';

    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        border: Border(top: BorderSide(color: AppColors.borderOf(context))),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimaryOf(context).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Subtotal ($itemLabel)',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryOf(context),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${cart.subtotal.toStringAsFixed(2)}',
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Gap(AppSpacing.xs),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shipping & tax calculated at checkout (demo).',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondaryOf(context),
                ),
              ),
            ),
            Gap(AppSpacing.md),
            PrimaryButton(
              label: 'Checkout',
              icon: Icons.lock_outline_rounded,
              isExpanded: true,
              onPressed: isBusy || cart.isEmpty
                  ? null
                  : () => context.push(AppRoutes.checkout),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/cart.dart';

/// Bottom panel: item count, subtotal, and a demo checkout button.
///
/// Checkout is not wired to a real payment API — it only shows a SnackBar.
class CartSummary extends StatelessWidget {
  const CartSummary({
    required this.cart,
    this.isBusy = false,
    super.key,
  });

  final Cart cart;

  /// Dims the checkout button while a cart write is in progress.
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
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.06),
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
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${cart.subtotal.toStringAsFixed(2)}',
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Gap(4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Shipping & tax calculated at checkout (demo).',
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Gap(AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isBusy || cart.isEmpty
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Checkout is a demo — no payment is charged.',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

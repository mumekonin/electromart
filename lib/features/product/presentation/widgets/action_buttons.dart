import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/primary_button.dart';

/// Bottom actions for Product Details.
///
/// Add to Cart is the main shopping action (filled primary).
/// Buy Now stays secondary (outlined) as a demo placeholder.
class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceOf(context),
          border: Border(
            top: BorderSide(color: AppColors.borderOf(context)),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimaryOf(context).withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onBuyNow,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radius),
                  ),
                ),
                child: const Text('Buy Now'),
              ),
            ),
            Gap(AppSpacing.sm),
            Expanded(
              flex: 2,
              child: PrimaryButton(
                label: 'Add to Cart',
                icon: Icons.shopping_cart_rounded,
                onPressed: onAddToCart,
                isExpanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

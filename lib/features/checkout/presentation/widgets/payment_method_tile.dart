import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/payment_method.dart';

/// One selectable payment row on Checkout.
class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    required this.method,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderColor = isSelected
        ? AppColors.primary
        : AppColors.borderOf(context);

    return Material(
      color: AppColors.surfaceOf(context),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _iconFor(method),
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondaryOf(context),
              ),
              Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _titleFor(method),
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(AppSpacing.xs),
                    Text(
                      _subtitleFor(method),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryOf(context),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.check_circle_rounded
                    : Icons.circle_outlined,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondaryOf(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconFor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return Icons.credit_card_rounded;
      case PaymentMethod.cashOnDelivery:
        return Icons.payments_outlined;
      case PaymentMethod.mobileMoney:
        return Icons.phone_android_rounded;
    }
  }

  static String _titleFor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Credit / Debit Card';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentMethod.mobileMoney:
        return 'Mobile Money';
    }
  }

  static String _subtitleFor(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.card:
        return 'Demo card payment — nothing is charged';
      case PaymentMethod.cashOnDelivery:
        return 'Pay with cash when your order arrives';
      case PaymentMethod.mobileMoney:
        return 'Demo mobile wallet — nothing is charged';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Reusable − / quantity / + control.
///
/// Used by cart tiles. The parent decides what happens when
/// plus or minus is tapped — this widget only draws the UI.
///
/// Rules enforced by the parent (not here):
/// - Quantity can never go below 1 (minus is disabled at 1).
/// - Quantity can never go above [maxQuantity].
class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    this.maxQuantity = 99,
    this.enabled = true,
    super.key,
  });

  /// Current quantity shown in the middle.
  final int quantity;

  /// Called when the + button is tapped.
  final VoidCallback onIncrease;

  /// Called when the − button is tapped.
  final VoidCallback onDecrease;

  /// Upper limit (Fake Store does not track stock, so we use a soft max).
  final int maxQuantity;

  /// When false, both buttons look disabled and do nothing.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Clamp display value so we never show a negative number.
    final safeQuantity = quantity < 1 ? 1 : quantity;
    final canDecrease = enabled && safeQuantity > 1;
    final canIncrease = enabled && safeQuantity < maxQuantity;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(
            icon: Icons.remove_rounded,
            onTap: canDecrease ? onDecrease : null,
            tooltip: 'Decrease quantity',
          ),
          SizedBox(
            width: 28.w,
            child: Text(
              '$safeQuantity',
              textAlign: TextAlign.center,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          _QuantityButton(
            icon: Icons.add_rounded,
            onTap: canIncrease ? onIncrease : null,
            tooltip: 'Increase quantity',
          ),
        ],
      ),
    );
  }
}

/// Small square button used inside [QuantitySelector].
class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          child: SizedBox(
            width: 36.w,
            height: 36.w,
            child: Icon(
              icon,
              size: 18.sp,
              color: isEnabled
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/cart_item.dart';
import 'quantity_selector.dart';

/// One product row inside the cart list.
///
/// Shows image, title, unit price, line total, quantity controls,
/// and a remove action. Tapping the row opens product details.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    this.isBusy = false,
    super.key,
  });

  final CartItem item;

  /// +1 quantity (repository merges duplicates; never creates a second row).
  final VoidCallback onIncrease;

  /// −1 quantity (disabled visually when quantity is 1).
  final VoidCallback onDecrease;

  /// Remove this product from the cart entirely.
  final VoidCallback onRemove;

  /// When true, quantity buttons are disabled (optional mutation lock).
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dismissible(
      // Unique key so Flutter can animate the correct row away.
      key: ValueKey('cart-${item.productId}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: AppColors.error,
          size: 28.sp,
        ),
      ),
      child: Material(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: InkWell(
          onTap: () =>
              context.push(AppRoutes.productDetailsPath(item.productId)),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(color: AppColors.borderOf(context)),
              boxShadow: [
                BoxShadow(
                  color:
                      AppColors.textPrimaryOf(context).withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ProductThumb(imageUrl: item.image),
                Gap(AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleSmall,
                      ),
                      Gap(AppSpacing.xs),
                      Text(
                        '\$${item.price.toStringAsFixed(2)} each',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondaryOf(context),
                        ),
                      ),
                      Gap(AppSpacing.sm),
                      Row(
                        children: [
                          QuantitySelector(
                            quantity: item.quantity,
                            enabled: !isBusy,
                            onIncrease: onIncrease,
                            onDecrease: onDecrease,
                          ),
                          const Spacer(),
                          Text(
                            '\$${item.lineTotal.toStringAsFixed(2)}',
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Explicit remove (swipe also works).
                IconButton(
                  onPressed: isBusy ? null : onRemove,
                  tooltip: 'Remove from cart',
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20.sp,
                    color: AppColors.textSecondaryOf(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small product image with loading / error fallbacks.
class _ProductThumb extends StatelessWidget {
  const _ProductThumb({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: ColoredBox(
        color: AppColors.backgroundOf(context),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 72.w,
          height: 72.w,
          fit: BoxFit.contain,
          placeholder: (_, _) => SizedBox(
            width: 72.w,
            height: 72.w,
            child: Center(
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (_, _, _) => SizedBox(
            width: 72.w,
            height: 72.w,
            child: Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.textSecondaryOf(context),
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}

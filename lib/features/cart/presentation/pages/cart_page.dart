import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/cart.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_error_widget.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_loading_view.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart_widget.dart';

/// Shopping cart screen.
///
/// States this page handles:
/// 1. First load → [CartLoadingView] skeleton
/// 2. Load failed → [CartErrorWidget] with retry
/// 3. Loaded + empty → [EmptyCartWidget]
/// 4. Loaded + items → list + [CartSummary]
///
/// Quantity changes keep showing the previous cart (no full-page spinner)
/// thanks to [skipLoadingOnReload] and the provider's mutate helpers.
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          // Clear all — only useful when we have items.
          if (cartAsync.value?.isNotEmpty ?? false)
            TextButton(
              onPressed: () => _confirmClearCart(context, ref),
              child: Text(
                'Clear',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.error,
                    ),
              ),
            ),
        ],
      ),
      body: cartAsync.when(
        // Keep showing the last good cart while a mutation reloads.
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        loading: () => const CartLoadingView(),
        error: (error, _) => CartErrorWidget(
          message: cartErrorMessage(error),
          onRetry: () => ref.read(cartProvider.notifier).loadCart(),
        ),
        data: (cart) {
          if (cart.isEmpty) {
            return const EmptyCartWidget();
          }
          return _CartContent(cart: cart);
        },
      ),
    );
  }

  Future<void> _confirmClearCart(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear cart?'),
          content: const Text(
            'This removes every item from your cart. '
            'You can add products again anytime.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('Clear all'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await _runCartAction(
        context,
        () => ref.read(cartProvider.notifier).clearCart(),
      );
    }
  }
}

/// List of items + sticky summary at the bottom.
class _CartContent extends ConsumerWidget {
  const _CartContent({required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(AppSpacing.md),
            itemCount: cart.items.length,
            separatorBuilder: (_, _) => Gap(AppSpacing.sm),
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return CartItemTile(
                item: item,
                onIncrease: () => _runCartAction(
                  context,
                  () => notifier.increaseQuantity(item.productId),
                ),
                onDecrease: () => _runCartAction(
                  context,
                  () => notifier.decreaseQuantity(item.productId),
                ),
                onRemove: () => _runCartAction(
                  context,
                  () => notifier.removeFromCart(item.productId),
                ),
              );
            },
          ),
        ),
        CartSummary(cart: cart),
      ],
    );
  }
}

/// Runs a cart write and shows a friendly SnackBar on failure.
///
/// Why a shared helper?
/// - Avoids repeating try/catch in every button
/// - Keeps error wording consistent via [cartErrorMessage]
Future<void> _runCartAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
  } catch (error) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(cartErrorMessage(error)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
  }
}

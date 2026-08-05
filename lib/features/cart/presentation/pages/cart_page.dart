import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/cart.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart_widget.dart';

/// Shopping cart screen for ElectroMart.
///
/// Why this page exists:
/// - Shows saved cart items from [cartProvider]
/// - Lets the user change quantities or remove items
/// - Checkout button is UI-only (no payment yet)
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Checkout coming soon'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          // Show clear only when the cart has items.
          if (cartState.value?.isEmpty == false)
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
              },
              child: const Text('Clear'),
            ),
        ],
      ),
      body: cartState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Could not load your cart.',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Gap(AppSpacing.md),
                  FilledButton.icon(
                    onPressed: () {
                      ref.read(cartProvider.notifier).loadCart();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (cart) {
          if (cart.isEmpty) {
            return const EmptyCartWidget();
          }

          return _CartContent(
            cart: cart,
            onCheckout: () => _showComingSoon(context),
          );
        },
      ),
    );
  }
}

/// List of cart tiles + bottom summary.
class _CartContent extends ConsumerWidget {
  const _CartContent({
    required this.cart,
    required this.onCheckout,
  });

  final Cart cart;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(AppSpacing.md),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];

              return CartItemTile(
                item: item,
                onIncrease: () {
                  notifier.increaseQuantity(item.productId);
                },
                onDecrease: () {
                  notifier.decreaseQuantity(item.productId);
                },
                onRemove: () {
                  notifier.removeFromCart(item.productId);
                },
              );
            },
          ),
        ),
        CartSummary(
          totalItems: cart.totalQuantity,
          subtotal: cart.subtotal,
          onCheckout: onCheckout,
        ),
      ],
    );
  }
}

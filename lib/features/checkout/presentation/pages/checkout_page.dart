import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/payment_method.dart';
import '../providers/checkout_provider.dart';
import '../widgets/checkout_order_summary.dart';
import '../widgets/payment_method_tile.dart';

/// Simple Buy / Payment screen (demo only).
///
/// Flow:
/// 1. User opens Checkout from the Cart summary
/// 2. Reviews order + picks a payment method
/// 3. Taps Pay → short demo delay → cart clears → success page
///
/// Why there is no payment API:
/// - Fake Store has no checkout endpoint
/// - This page teaches the UI flow without real money
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  bool _isPaying = false;

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    final selectedMethod = ref.watch(selectedPaymentMethodProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      appBar: const CustomAppBar(title: 'Checkout'),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Text(
              cartErrorMessage(error),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (cart) {
          // Empty cart → go back (nothing to buy).
          if (cart.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) context.go(AppRoutes.cart);
            });
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(AppSpacing.md),
                  children: [
                    Text(
                      'This is a demo checkout. No real payment is taken.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondaryOf(context),
                      ),
                    ),
                    Gap(AppSpacing.lg),
                    CheckoutOrderSummary(cart: cart),
                    Gap(AppSpacing.lg),
                    Text(
                      'Payment method',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(AppSpacing.sm),
                    ...PaymentMethod.values.map((method) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: AppSpacing.sm),
                        child: PaymentMethodTile(
                          method: method,
                          isSelected: selectedMethod == method,
                          onTap: () {
                            ref
                                .read(selectedPaymentMethodProvider.notifier)
                                .select(method);
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
              _CheckoutPayBar(
                total: cart.subtotal,
                isPaying: _isPaying,
                onPay: () => _placeOrder(context),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Demo “payment”: wait briefly, clear cart, open success.
  Future<void> _placeOrder(BuildContext context) async {
    if (_isPaying) return;

    setState(() => _isPaying = true);

    try {
      // Fake processing time so the loading button feels real.
      await Future<void>.delayed(const Duration(milliseconds: 900));

      await ref.read(cartProvider.notifier).clearCart();

      if (!context.mounted) return;

      context.go(AppRoutes.orderSuccess);
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
    } finally {
      if (mounted) {
        setState(() => _isPaying = false);
      }
    }
  }
}

/// Sticky bottom bar with total + Pay button.
class _CheckoutPayBar extends StatelessWidget {
  const _CheckoutPayBar({
    required this.total,
    required this.isPaying,
    required this.onPay,
  });

  final double total;
  final bool isPaying;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'Amount due',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondaryOf(context),
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Gap(AppSpacing.md),
            PrimaryButton(
              label: 'Pay now',
              icon: Icons.lock_outline_rounded,
              isExpanded: true,
              isLoading: isPaying,
              onPressed: isPaying ? null : onPay,
            ),
          ],
        ),
      ),
    );
  }
}

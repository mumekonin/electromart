import 'package:flutter/material.dart';

import '../../../../core/widgets/app_error.dart';

/// Friendly full-page error when the cart cannot be loaded.
///
/// Naming note: `*View` matches other feature error/empty wrappers
/// (example: [ProductsErrorView], [ProfileErrorView]).
class CartErrorView extends StatelessWidget {
  const CartErrorView({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return AppError(
      title: 'Could not load your cart',
      message: message,
      icon: Icons.shopping_cart_outlined,
      retryLabel: 'Try again',
      onRetry: () {
        onRetry();
      },
    );
  }
}

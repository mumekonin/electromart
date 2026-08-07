import 'package:flutter/material.dart';

import '../../../../core/widgets/app_empty_state.dart';

/// Shown when a category / product list has no items.
class ProductsEmptyView extends StatelessWidget {
  const ProductsEmptyView({
    super.key,
    required this.onRefresh,
    this.message = 'There are no products to show right now.',
  });

  final Future<void> Function() onRefresh;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.inventory_2_outlined,
      title: 'No products',
      description: message,
      actionLabel: 'Refresh',
      actionIcon: Icons.refresh_rounded,
      onAction: () {
        onRefresh();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_empty_state.dart';

/// Shown when a product id does not exist.
class ProductNotFoundView extends StatelessWidget {
  const ProductNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.search_off_rounded,
      title: 'Product not found',
      description:
          'This product may have been removed or the link is invalid.',
      actionLabel: 'Go Back',
      actionIcon: Icons.arrow_back_rounded,
      onAction: () => context.pop(),
    );
  }
}

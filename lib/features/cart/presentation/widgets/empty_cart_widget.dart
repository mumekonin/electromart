import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/fade_scale_in.dart';

/// Shown when the cart has zero items.
class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeScaleIn(
      child: AppEmptyState(
        icon: Icons.shopping_bag_outlined,
        title: 'Your cart is empty',
        description:
            'Browse electronics and tap “Add to Cart” on any product. '
            'Your items will show up here.',
        actionLabel: 'Browse products',
        actionIcon: Icons.storefront_outlined,
        onAction: () => context.go(AppRoutes.home),
      ),
    );
  }
}

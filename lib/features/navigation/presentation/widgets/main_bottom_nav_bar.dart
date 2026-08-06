import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

/// Material 3 bottom navigation for ElectroMart.
///
/// Why this widget exists:
/// - Home / Cart / Profile share one persistent bar
/// - Cart badge reads [cartTotalItemsProvider] (same Cart feature)
/// - Keeps tab UI out of [MainShellPage] so the shell stays simple
///
/// How the badge works:
/// - Riverpod watches the cart total
/// - If total > 0 → show a Badge with the number
/// - If total == 0 → hide the badge
class MainBottomNavBar extends ConsumerWidget {
  const MainBottomNavBar({
    required this.navigationShell,
    super.key,
  });

  /// GoRouter shell that knows which tab is active.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartTotalItems = ref.watch(cartTotalItemsProvider);

    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: _onDestinationSelected,
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight,
      surfaceTintColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: _CartNavIcon(
            totalItems: cartTotalItems,
            selected: false,
          ),
          selectedIcon: _CartNavIcon(
            totalItems: cartTotalItems,
            selected: true,
          ),
          label: 'Cart',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }

  /// Switches tabs. Tapping the same tab again jumps to that tab's root.
  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      // If the user taps the already-selected tab, reset that tab's stack.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

/// Cart tab icon with an optional item-count badge.
class _CartNavIcon extends StatelessWidget {
  const _CartNavIcon({
    required this.totalItems,
    required this.selected,
  });

  final int totalItems;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      selected ? Icons.shopping_cart_rounded : Icons.shopping_cart_outlined,
    );

    // Empty cart → plain icon (no badge).
    if (totalItems <= 0) {
      return icon;
    }

    return Badge(
      isLabelVisible: true,
      backgroundColor: AppColors.error,
      label: Text(
        totalItems > 99 ? '99+' : '$totalItems',
      ),
      child: icon,
    );
  }
}

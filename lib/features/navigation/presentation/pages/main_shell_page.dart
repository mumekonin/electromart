import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/main_bottom_nav_bar.dart';

/// Main app shell after login.
///
/// Why this page exists:
/// - Holds the bottom navigation bar once
/// - Shows Home, Cart, or Profile inside the same scaffold
/// - The bar stays visible while switching tabs
///
/// How GoRouter shell works (beginner version):
/// - [StatefulNavigationShell] is built by GoRouter
/// - Each tab is a "branch" with its own navigation stack
/// - [IndexedStack] (used by `StatefulShellRoute.indexedStack`)
///   keeps each tab alive, so scroll position / form state is preserved
///
/// Visual layout:
/// ```
/// ┌─────────────────────┐
/// │  Home / Cart / ...  │  ← navigationShell (current tab page)
/// │                     │
/// ├─────────────────────┤
/// │  Home  Cart Profile │  ← bottom navigation bar
/// └─────────────────────┘
/// ```
class MainShellPage extends StatelessWidget {
  const MainShellPage({
    required this.navigationShell,
    super.key,
  });

  /// Provided by GoRouter's StatefulShellRoute.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The active tab page (Home, Cart, or Profile).
      body: navigationShell,
      bottomNavigationBar: MainBottomNavBar(
        navigationShell: navigationShell,
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/storage_provider.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/navigation/presentation/pages/main_shell_page.dart';
import '../../features/product/presentation/pages/home_page.dart';
import '../../features/product/presentation/pages/product_details_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/about_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

/// Route path constants.
///
/// Using constants (instead of typing '/home' as a string everywhere)
/// prevents typos and makes renaming routes easier.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';

  /// Home tab inside the main bottom-navigation shell.
  static const String home = '/home';

  /// Cart tab inside the main bottom-navigation shell.
  static const String cart = '/cart';

  /// Profile tab inside the main bottom-navigation shell.
  static const String profile = '/profile';

  /// Path pattern used by GoRouter for product details.
  /// Lives outside the shell so the bottom bar hides on details.
  static const String productDetails = '/product/:id';

  /// Settings page (opened from Profile).
  static const String settings = '/settings';

  /// About page (opened from Settings).
  static const String about = '/about';

  /// Builds a concrete details path for a product id.
  static String productDetailsPath(int id) => '/product/$id';
}

/// Listens to auth changes so GoRouter can re-run [redirect].
class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(this._ref) {
    _ref.listen(authProvider, (previous, next) => notifyListeners());
  }

  final Ref _ref;
}

/// Provides the app [GoRouter].
///
/// Why a provider?
/// - Router needs Riverpod to read login status
/// - After login success, redirect can send the user to Home
/// - If already logged in, Login is skipped
///
/// Main shell (beginner note):
/// - [StatefulShellRoute.indexedStack] wraps Home / Cart / Profile
/// - Bottom navigation stays visible on those three tabs
/// - Each tab keeps its own state when you switch away and back
final goRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _AuthRefreshListenable(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    // App always starts on Splash → session check → Home shell or Login.
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final onSplash = location == AppRoutes.splash;
      final onLogin = location == AppRoutes.login;

      // Let Splash finish its animation + session check itself.
      if (onSplash) return null;

      final authState = ref.read(authProvider);

      // Wait until session restore finishes.
      if (authState.isLoading) return null;

      final isLoggedIn =
          authState.value?.isLoggedIn ??
          ref.read(sessionStorageProvider).isLoggedIn();

      // Not logged in → force Login (except when already there).
      if (!isLoggedIn && !onLogin) {
        return AppRoutes.login;
      }

      // Already logged in → open the main shell on the Home tab.
      if (isLoggedIn && onLogin) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),

      // ----------------------------------------------------------
      // Main bottom navigation shell
      // ----------------------------------------------------------
      //
      // indexedStack = keep all three tabs alive (preserves state).
      // Each branch is one tab with its own back stack.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellPage(navigationShell: navigationShell);
        },
        branches: [
          // Tab 0 — Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),

          // Tab 1 — Cart
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cart,
                name: 'cart',
                builder: (context, state) => const CartPage(),
              ),
            ],
          ),

          // Tab 2 — Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),

      // Product details stays outside the shell (no bottom bar).
      GoRoute(
        path: AppRoutes.productDetails,
        name: 'productDetails',
        builder: (context, state) {
          final idParam = state.pathParameters['id'];
          final productId = int.tryParse(idParam ?? '') ?? 0;
          return ProductDetailsPage(productId: productId);
        },
      ),

      // Settings + About (opened from Profile; no bottom bar).
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutPage(),
      ),
    ],
  );
});

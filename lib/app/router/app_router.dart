import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/pages/splash_page.dart';

/// Route path constants.
///
/// Using constants (instead of typing '/home' as a string everywhere)
/// prevents typos and makes renaming routes easier.
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
}

/// App-wide navigation configuration using GoRouter.
///
/// Rules reminder:
/// - Always navigate with GoRouter (context.go / context.push)
/// - Do NOT use Navigator.push directly
///
/// We add more routes (login, home, cart, ...) as we build each screen.
final GoRouter appRouter = GoRouter(
  // First route opened when the app starts.
  initialLocation: AppRoutes.splash,

  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
  ],
);

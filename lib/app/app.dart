import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/cart/presentation/providers/cart_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_mode_provider.dart';

/// Root widget of the ElectroMart application.
///
/// Responsibilities:
/// 1. Set up ScreenUtil for responsive sizing
/// 2. Apply our Material 3 light / dark theme
/// 3. Connect GoRouter for navigation (from Riverpod)
/// 4. Restore the shopping cart from SharedPreferences on startup
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    // Listen (do not watch) so cart restore runs without rebuilding [App]
    // on every add / remove / quantity change.
    ref.listen(cartProvider, (previous, next) {});

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ElectroMart',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: router,
        );
      },
    );
  }
}

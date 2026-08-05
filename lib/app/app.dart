import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/cart/presentation/providers/cart_provider.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget of the ElectroMart application.
///
/// Responsibilities:
/// 1. Set up ScreenUtil for responsive sizing
/// 2. Apply our Material 3 theme
/// 3. Connect GoRouter for navigation (from Riverpod)
/// 4. Restore the shopping cart from SharedPreferences on startup
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    // Integration: cart restore
    // Watching cartProvider here runs CartNotifier.build() as soon as
    // the app starts, so saved cart JSON is loaded before Home opens.
    ref.watch(cartProvider);

    // ScreenUtilInit makes .w / .h / .sp / .r helpers work.
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ElectroMart',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routerConfig: router,
        );
      },
    );
  }
}

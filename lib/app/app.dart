import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget of the ElectroMart application.
///
/// Responsibilities:
/// 1. Set up ScreenUtil for responsive sizing
/// 2. Apply our Material 3 theme
/// 3. Connect GoRouter for navigation
///
/// State management (Riverpod) is wired in [main.dart]
/// via [ProviderScope], which wraps this widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit makes .w / .h / .sp / .r helpers work.
    // designSize is the "reference" phone size we design against.
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ElectroMart',
          debugShowCheckedModeBanner: false,

          // Material 3 theme (colors, typography, buttons, inputs)
          theme: AppTheme.light,

          // GoRouter handles all navigation
          routerConfig: appRouter,
        );
      },
    );
  }
}

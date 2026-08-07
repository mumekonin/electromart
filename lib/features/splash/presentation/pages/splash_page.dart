import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/splash_branding.dart';
import '../widgets/splash_loading_indicator.dart';
import '../widgets/splash_logo.dart';

/// First screen shown when ElectroMart starts.
///
/// Why a splash screen exists:
/// - Gives the brand a short, polished first impression
/// - Waits for [authProvider] to finish restoring the session
/// - Decides the first real screen: Home (logged in) or Login
///
/// Session check:
/// 1. Play the logo animation for a short time
/// 2. Await [authProvider.future] (same source as GoRouter)
/// 3. Navigate with `context.go(...)` so Back cannot return here
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
    Future<void>.microtask(_openNextScreen);
  }

  /// Waits for session restore, then navigates away from Splash.
  Future<void> _openNextScreen() async {
    await Future<void>.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;

    // Same auth source as GoRouter — avoids a second SharedPreferences path.
    final session = await ref.read(authProvider.future);
    if (!mounted) return;

    final isLoggedIn = session?.isLoggedIn ?? false;

    if (isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primarySoftOf(context),
              AppColors.backgroundOf(context),
              AppColors.surfaceOf(context),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SplashLogo(),
                      Gap(AppSpacing.lg),
                      const SplashBranding(),
                      Gap(AppSpacing.xxl),
                      const SplashLoadingIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

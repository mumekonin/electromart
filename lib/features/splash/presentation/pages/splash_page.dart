import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/storage/storage_provider.dart';
import '../widgets/splash_branding.dart';
import '../widgets/splash_loading_indicator.dart';
import '../widgets/splash_logo.dart';

/// First screen shown when ElectroMart starts.
///
/// Why a splash screen exists:
/// - Gives the brand a short, polished first impression
/// - Hides the short wait while we read the saved login session
/// - Decides the first real screen: Home (logged in) or Login
///
/// Session check (simple version for beginners):
/// 1. Wait briefly so the animation can play
/// 2. Ask [sessionStorageProvider] if a token is saved
/// 3. Navigate with `context.go(...)` so the user cannot press Back to Splash
///
/// Navigation decision:
/// - Logged in  → [AppRoutes.home]  (main shell, Home tab)
/// - Logged out → [AppRoutes.login]
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  /// Drives the fade + scale animations (Flutter built-in — no extra package).
  late final AnimationController _controller;

  /// 0 → invisible, 1 → fully visible.
  late final Animation<double> _fadeAnimation;

  /// Starts slightly small, then grows to normal size.
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

    // Start the logo / text animation.
    _controller.forward();

    // After branding + a short delay, check session and leave Splash.
    Future<void>.microtask(_openNextScreen);
  }

  /// Reads the saved session, then navigates away from Splash.
  Future<void> _openNextScreen() async {
    // Keep Splash visible long enough to see the animation + brand.
    await Future<void>.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;

    // Uses existing Authentication storage — no new login system here.
    final isLoggedIn = ref.read(sessionStorageProvider).isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      // Main app entry for signed-in users (Home product listing).
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
        decoration: const BoxDecoration(
          // Soft electronics-store atmosphere (not a flat blank screen).
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryLight,
              AppColors.background,
              AppColors.surface,
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

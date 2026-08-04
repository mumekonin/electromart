import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/storage/storage_provider.dart';

/// First screen shown while we decide where the user should go.
///
/// Why this page exists:
/// - Shows the brand briefly on app start
/// - If already logged in → Home
/// - If not logged in → Login
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Wait one frame so context / providers are ready.
    Future<void>.microtask(_openNextScreen);
  }

  Future<void> _openNextScreen() async {
    // Short splash delay for branding.
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    final isLoggedIn = ref.read(sessionStorageProvider).isLoggedIn();

    if (isLoggedIn) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ElectroMart',
              style: textTheme.displayMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

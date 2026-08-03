import 'package:flutter/material.dart';

/// First screen the user sees when the app opens.
///
/// For now this is a simple branded screen.
/// Later we will add logic to check login status and
/// navigate to Home or Login automatically.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Text(
          'ElectroMart',
          style: textTheme.displayMedium,
        ),
      ),
    );
  }
}

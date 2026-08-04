import 'package:flutter/material.dart';

/// Minimal Home screen used as the post-login destination.
///
/// Why this page exists:
/// - Auth flow must navigate somewhere after a successful login
/// - Full Home / Products UI will be built in a later module
/// - Keep this intentionally simple for now
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to ElectroMart'),
      ),
    );
  }
}

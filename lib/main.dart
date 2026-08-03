import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// Entry point of the ElectroMart app.
///
/// Important setup steps (in order):
/// 1. Ensure Flutter bindings are ready before any plugin work
/// 2. Wrap the app in [ProviderScope] so Riverpod providers work
/// 3. Run our root [App] widget
void main() {
  // Required before using plugins or async setup in main().
  WidgetsFlutterBinding.ensureInitialized();

  // ProviderScope is the root of Riverpod.
  // Every provider in the app lives under this widget.
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/storage/storage_provider.dart';

/// Entry point of the ElectroMart app.
///
/// Important setup steps (in order):
/// 1. Ensure Flutter bindings are ready
/// 2. Load SharedPreferences (needed for login session)
/// 3. Wrap the app in [ProviderScope] so Riverpod providers work
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load local storage before the UI starts.
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Inject the real SharedPreferences instance.
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const App(),
    ),
  );
}

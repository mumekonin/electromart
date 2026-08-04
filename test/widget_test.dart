import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:electromart/app/app.dart';
import 'package:electromart/core/storage/storage_provider.dart';

void main() {
  testWidgets('App starts on splash screen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const App(),
      ),
    );

    // First frame shows splash branding.
    await tester.pump();
    expect(find.text('ElectroMart'), findsOneWidget);
  });
}

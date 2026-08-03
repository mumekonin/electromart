import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:electromart/app/app.dart';

void main() {
  testWidgets('App starts on splash screen', (WidgetTester tester) async {
    // Pump the real app root (Riverpod + ScreenUtil + GoRouter).
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Allow ScreenUtil / first frame to settle.
    await tester.pumpAndSettle();

    // Splash page should show the brand name.
    expect(find.text('ElectroMart'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/features/splash/splash_screen.dart';

void main() {
  testWidgets('SplashScreen displays branding and progress indicator', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    expect(find.text('AviationMap'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byIcon(Icons.flight_takeoff), findsOneWidget);
  });

  testWidgets('SplashScreen runs setup logic', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
    // Wait for setup duration
    await tester.pump(const Duration(seconds: 2));
    // No navigation here, handled by parent
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}

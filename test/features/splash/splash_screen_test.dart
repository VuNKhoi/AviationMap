import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/features/splash/widgets/splash_screen.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('displays branding and progress indicator', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      expect(find.text('AviationMap'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.flight_takeoff), findsOneWidget);
    });

    testWidgets('supports dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          home: const SplashScreen(),
        ),
      );
      // Should still show branding and progress indicator
      expect(find.text('AviationMap'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('runs setup logic and remains visible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pump(const Duration(seconds: 2));
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    testWidgets('disposes timer on widget removal', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpWidget(const MaterialApp(home: SizedBox()));
      await tester.pump(const Duration(seconds: 2));
      // No exceptions should be thrown
      expect(tester.takeException(), isNull);
    });
  });

  // Example extensibility: error UI (if implemented in the future)
  // testWidgets('SplashScreen displays error UI if setup fails', (WidgetTester tester) async {
  //   // This would require a SplashScreen with error state
  //   // expect(find.text('Setup failed'), findsOneWidget);
  // });
}

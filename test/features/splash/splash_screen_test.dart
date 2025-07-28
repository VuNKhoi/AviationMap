import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/features/splash/widgets/splash_screen.dart';

/// Tests for SplashScreen widget.
///
/// Ensures splash UI renders and timer logic works as expected.
void main() {
  group('SplashScreen', () {
    testWidgets('renders branding and progress indicator', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      expect(find.text('AviationMap'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.flight_takeoff), findsOneWidget);
    });

    testWidgets('timer completes after 2 seconds', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      await tester.pump(const Duration(seconds: 2));
      // No navigation here; parent handles it. Just ensure timer completes.
      expect(find.text('AviationMap'), findsOneWidget);
    });
  });
}

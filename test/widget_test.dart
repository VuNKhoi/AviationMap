// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:aviationmap/main.dart';
import 'package:aviationmap/features/splash/splash_screen.dart';
import 'package:aviationmap/features/map/map_screen.dart';

void main() {
  testWidgets('Splash screen displays and transitions to map', (WidgetTester tester) async {
    // Build the AviationMap app and trigger a frame.
    await tester.pumpWidget(const AviationMapApp());

    // Verify that the splash screen is shown.
    expect(find.byType(SplashScreen), findsOneWidget);

    // Wait for the splash duration and transition.
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Verify that the map screen is shown after splash.
    expect(find.byType(MapScreen), findsOneWidget);
  });
}

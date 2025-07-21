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
  testWidgets('Splash screen displays, runs setup, and transitions to map', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AviationMapApp());

    // Splash screen should be visible initially
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('AviationMap'), findsOneWidget);

    // Wait for setup and navigation
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // Map screen should be visible after splash
    expect(find.byType(MapScreen), findsOneWidget);
  });
}

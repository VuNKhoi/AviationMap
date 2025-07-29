import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:aviationmap/main.dart';
import 'package:aviationmap/features/splash/widgets/splash_screen.dart';

void main() {
  testWidgets('App starts and shows splash screen', (tester) async {
    await tester.pumpWidget(const AviationMapApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('ErrorBoundary displays error UI', (tester) async {
    final errorKey = UniqueKey();
    await tester.pumpWidget(
      ErrorBoundary(
        child: Builder(
          builder: (context) {
            // Trigger an error after build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              FlutterError.reportError(
                FlutterErrorDetails(exception: Exception('Test error')),
              );
            });
            return Container(key: errorKey);
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('unexpected error'), findsOneWidget);
    expect(find.byIcon(Icons.error), findsOneWidget);
  });
}

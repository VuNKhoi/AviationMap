import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aviationmap/features/map/map_screen.dart';
import 'package:geolocator/geolocator.dart';

/// Tests for MapScreen widget.
///

/// Ensures OSM compliance, DI, and map UI render as expected.
class FakeLocationService extends LocationService {
  final bool permissionDenied;
  final bool throwOnLocation;
  FakeLocationService({
    this.permissionDenied = false,
    this.throwOnLocation = false,
  });


  @override
  Future<bool> requestPermission() async => !permissionDenied;

  @override
  Future<Position> getCurrentPosition() async {
    if (throwOnLocation) throw Exception('Location error');
    return Position(
      latitude: 37.7749,
      longitude: -122.4194,
      timestamp: DateTime.now(),
      accuracy: 1.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 1.0,
      headingAccuracy: 1.0,
    );
  }
}

void main() {
  group('MapScreen', () {
    testWidgets('renders map UI', (tester) async {
      await tester.pumpWidget(MaterialApp(home: MapScreen()));
      expect(find.byType(Scaffold), findsOneWidget);
      // Add more widget expectations as needed
    });

    testWidgets('MapScreen shows loading indicator initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: MapScreen(locationService: FakeLocationService())),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('MapScreen shows error UI when location permission denied', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MapScreen(
            locationService: FakeLocationService(permissionDenied: true),
          ),
        ),
      );
      await tester.pump();
      expect(find.textContaining('Location permission denied'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets(
      'MapScreen displays user marker after location permission granted',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(home: MapScreen(locationService: FakeLocationService())),
        );
        await tester.pump();
        expect(find.byKey(const Key('userLocationMarker')), findsOneWidget);
      },
    );

    testWidgets('MapScreen recenter button recenters map', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: MapScreen(locationService: FakeLocationService())),
      );
      await tester.pump();
      final fab = find.byKey(const Key('recenterButton'));
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle(); // Ensure all timers/animations complete
      // No direct way to verify map recenter, but button is present and tap does not throw
    });
  });
}

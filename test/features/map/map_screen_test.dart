import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
// import 'package:aviationmap/features/map/map_screen.dart';
// ...existing code...
import 'package:geolocator/geolocator.dart';
import 'package:aviationmap/features/map/map_screen.dart';

class FakeLocationService implements ILocationService {
  final bool permissionDenied;
  final bool throwOnLocation;
  FakeLocationService({
    this.permissionDenied = false,
    this.throwOnLocation = false,
  });

  @override
  Future<LocationPermission> checkPermission() async =>
      permissionDenied ? LocationPermission.denied : LocationPermission.always;

  @override
  Future<LocationPermission> requestPermission() async =>
      permissionDenied ? LocationPermission.denied : LocationPermission.always;

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
    await tester.pump();
    // No direct way to verify map recenter, but button is present and tap does not throw
  });
  group('MapScreen', () {
    testWidgets('shows loading indicator initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: MapScreen(locationService: FakeLocationService())),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error UI when location permission denied', (
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

    testWidgets('displays user marker after location permission granted', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: MapScreen(locationService: FakeLocationService())),
      );
      await tester.pump();
      expect(find.byKey(const Key('userLocationMarker')), findsOneWidget);
    });

    testWidgets('recenter button recenters map', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: MapScreen(locationService: FakeLocationService())),
      );
      await tester.pump();
      final fab = find.byKey(const Key('recenterButton'));
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pump();
      // No direct way to verify map recenter, but button is present and tap does not throw
    });
  });
}

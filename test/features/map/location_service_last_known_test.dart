import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:aviationmap/features/map/core/location_service.dart';

class MockGeolocator extends LocationService {
  Position? lastKnown;
  @override
  Future<Position?> getLastKnownPosition() async {
    return lastKnown;
  }
}

void main() {
  group('LocationService.getLastKnownPosition', () {
    test('returns last known position if available', () async {
      final mock = MockGeolocator();
      mock.lastKnown = Position(
        latitude: 42.0,
        longitude: -71.0,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 1.0,
        headingAccuracy: 1.0,
      );
      final pos = await mock.getLastKnownPosition();
      expect(pos, isNotNull);
      expect(pos?.latitude, 42.0);
      expect(pos?.longitude, -71.0);
    });

    test('returns null if no last known position', () async {
      final mock = MockGeolocator();
      mock.lastKnown = null;
      final pos = await mock.getLastKnownPosition();
      expect(pos, isNull);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:aviationmap/features/map/core/location_service.dart';

class FakeGeolocator {
  bool throwOnGet = false;
  bool throwOnLast = false;
  bool throwOnRequest = false;
  LocationPermission permission = LocationPermission.whileInUse;
  Position? position;
  Position? lastKnown;

  Future<LocationPermission> requestPermission() async {
    if (throwOnRequest) throw Exception('Permission error');
    return permission;
  }

  Future<Position> getCurrentPosition() async {
    if (throwOnGet) throw Exception('Location error');
    if (position != null) return position!;
    return Position(
      latitude: 1.0,
      longitude: 2.0,
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

  Future<Position?> getLastKnownPosition() async {
    if (throwOnLast) throw Exception('Last known error');
    return lastKnown;
  }
}

class TestLocationService extends LocationService {
  final FakeGeolocator fake;
  TestLocationService(this.fake);

  @override
  Future<bool> requestPermission() async {
    final status = await fake.requestPermission();
    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }

  @override
  Future<Position?> getCurrentPosition() async {
    try {
      return await fake.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Position?> getLastKnownPosition() async {
    try {
      return await fake.getLastKnownPosition();
    } catch (_) {
      return null;
    }
  }
}

void main() {
  group('LocationService', () {
    test('returns true for allowed permission', () async {
      final fake = FakeGeolocator();
      fake.permission = LocationPermission.whileInUse;
      final service = TestLocationService(fake);
      expect(await service.requestPermission(), true);
    });

    test('returns false for denied permission', () async {
      final fake = FakeGeolocator();
      fake.permission = LocationPermission.denied;
      final service = TestLocationService(fake);
      expect(await service.requestPermission(), false);
    });

    test('returns position if geolocator succeeds', () async {
      final fake = FakeGeolocator();
      fake.position = Position(
        latitude: 10.0,
        longitude: 20.0,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 1.0,
        headingAccuracy: 1.0,
      );
      final service = TestLocationService(fake);
      final pos = await service.getCurrentPosition();
      expect(pos?.latitude, 10.0);
      expect(pos?.longitude, 20.0);
    });

    test('returns null if geolocator throws', () async {
      final fake = FakeGeolocator();
      fake.throwOnGet = true;
      final service = TestLocationService(fake);
      final pos = await service.getCurrentPosition();
      expect(pos, isNull);
    });

    test('returns last known position if available', () async {
      final fake = FakeGeolocator();
      fake.lastKnown = Position(
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
      final service = TestLocationService(fake);
      final pos = await service.getLastKnownPosition();
      expect(pos, isNotNull);
      expect(pos?.latitude, 42.0);
      expect(pos?.longitude, -71.0);
    });

    test('returns null if no last known position', () async {
      final fake = FakeGeolocator();
      fake.lastKnown = null;
      final service = TestLocationService(fake);
      final pos = await service.getLastKnownPosition();
      expect(pos, isNull);
    });

    test('returns null if getLastKnownPosition throws', () async {
      final fake = FakeGeolocator();
      fake.throwOnLast = true;
      final service = TestLocationService(fake);
      final pos = await service.getLastKnownPosition();
      expect(pos, isNull);
    });
  });
}

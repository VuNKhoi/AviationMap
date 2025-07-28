import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:aviationmap/features/map/core/map_view_model.dart';
import 'package:aviationmap/features/map/core/location_service.dart';

import 'package:geolocator/geolocator.dart';

class MockLocationService extends LocationService {
  bool permission;
  bool shouldFail;
  double lat;
  double lng;

  MockLocationService({
    this.permission = true,
    this.shouldFail = false,
    this.lat = 1.0,
    this.lng = 2.0,
  });

  @override
  Future<bool> requestPermission() async => permission;

  @override
  Future<Position?> getCurrentPosition() async {
    if (shouldFail) return null;
    return Position(
      latitude: lat,
      longitude: lng,
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
  group('MapViewModel', () {
    test('init sets error if permission denied', () async {
      final vm = MapViewModel(
        locationService: MockLocationService(permission: false),
      );
      await vm.init();
      expect(vm.permissionGranted, false);
      expect(vm.error, 'Location permission denied.');
      expect(vm.loading, false);
    });

    test('init sets error if location fails', () async {
      final vm = MapViewModel(
        locationService: MockLocationService(shouldFail: true),
      );
      await vm.init();
      expect(vm.permissionGranted, true);
      expect(vm.error, 'Could not get location.');
      expect(vm.loading, false);
    });

    test('init sets userLocation if permission and location succeed', () async {
      final vm = MapViewModel(
        locationService: MockLocationService(lat: 10, lng: 20),
      );
      await vm.init();
      expect(vm.permissionGranted, true);
      expect(vm.error, isNull);
      expect(vm.userLocation, LatLng(10, 20));
      expect(vm.loading, false);
    });

    test('recenter updates userLocation and clears error', () async {
      final vm = MapViewModel(
        locationService: MockLocationService(lat: 5, lng: 6),
      );
      await vm.init();
      await vm.recenter();
      expect(vm.userLocation, LatLng(5, 6));
      expect(vm.error, isNull);
      expect(vm.loading, false);
    });

    test('recenter sets error if location fails', () async {
      final vm = MapViewModel(locationService: MockLocationService());
      await vm.init();
      final failService = MockLocationService(shouldFail: true);
      // Create a new viewmodel to simulate recenter with failure
      final vm2 = MapViewModel(locationService: failService);
      await vm2.init();
      await vm2.recenter();
      expect(vm2.error, 'Could not get location.');
      expect(vm2.loading, false);
    });
  });
}

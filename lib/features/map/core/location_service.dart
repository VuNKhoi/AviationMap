import 'package:geolocator/geolocator.dart';

/// Service to handle location and permission logic.
class LocationService {
  Future<Position?> getLastKnownPosition() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (_) {
      return null;
    }
  }

  Future<bool> requestPermission() async {
    final status = await Geolocator.requestPermission();
    return status == LocationPermission.always ||
        status == LocationPermission.whileInUse;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }
}

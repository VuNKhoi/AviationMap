import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../core/location_service.dart';

/// ViewModel for map state (location, errors, permission).
class MapViewModel extends ChangeNotifier {
  final LocationService locationService;
  LatLng? userLocation;
  String? error;
  bool permissionGranted = false;
  bool loading = true;

  MapViewModel({LocationService? locationService})
      : locationService = locationService ?? LocationService();

  Future<void> init() async {
    loading = true;
    notifyListeners();
    permissionGranted = await locationService.requestPermission();
    if (!permissionGranted) {
      error = 'Location permission denied.';
      loading = false;
      notifyListeners();
      return;
    }
    final pos = await locationService.getCurrentPosition();
    if (pos == null) {
      error = 'Could not get location.';
      loading = false;
      notifyListeners();
      return;
    }
    userLocation = LatLng(pos.latitude, pos.longitude);
    error = null;
    loading = false;
    notifyListeners();
  }

  Future<void> recenter() async {
    if (!permissionGranted) return;
    loading = true;
    notifyListeners();
    final pos = await locationService.getCurrentPosition();
    if (pos != null) {
      userLocation = LatLng(pos.latitude, pos.longitude);
      error = null;
    } else {
      error = 'Could not get location.';
    }
    loading = false;
    notifyListeners();
  }
}

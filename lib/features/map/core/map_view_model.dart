import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../core/location_service.dart';

/// ViewModel for map state (location, errors, permission).
class MapViewModel extends ChangeNotifier {
  bool _disposed = false;
  final LocationService locationService;
  LatLng? userLocation;
  String? error;
  bool permissionGranted = false;
  bool loading = true;

  MapViewModel({LocationService? locationService})
    : locationService = locationService ?? LocationService();

  Future<void> init() async {
    loading = true;
    _safeNotifyListeners();
    permissionGranted = await locationService.requestPermission();
    if (!permissionGranted) {
      error = 'Location permission denied.';
      loading = false;
      _safeNotifyListeners();
      return;
    }
    final pos = await locationService.getCurrentPosition();
    if (pos == null) {
      error = 'Could not get location.';
      loading = false;
      _safeNotifyListeners();
      return;
    }
    userLocation = LatLng(pos.latitude, pos.longitude);
    error = null;
    loading = false;
    _safeNotifyListeners();
  }

  Future<void> recenter() async {
    if (!permissionGranted) return;
    // 1. Use last known location for instant feedback
    final lastKnown = await locationService.getLastKnownPosition();
    if (lastKnown != null) {
      userLocation = LatLng(lastKnown.latitude, lastKnown.longitude);
      error = null;
      _safeNotifyListeners();
    }
    // 2. Show spinner only if fresh location takes >300ms
    bool spinnerShown = false;
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!spinnerShown && !_disposed) {
        loading = true;
        spinnerShown = true;
        _safeNotifyListeners();
      }
    });
    // 3. Get fresh GPS location
    final pos = await locationService.getCurrentPosition();
    if (pos != null) {
      userLocation = LatLng(pos.latitude, pos.longitude);
      error = null;
    } else {
      error = 'Could not get location.';
    }
    loading = false;
    _safeNotifyListeners();
  }

  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _safeNotifyListeners() {
    if (!_disposed) {
      notifyListeners();
    }
  }
}

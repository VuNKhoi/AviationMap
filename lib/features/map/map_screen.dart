import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// Abstracts all location and permission logic for testability.
abstract class ILocationService {
  Future<LocationPermission> checkPermission();
  Future<LocationPermission> requestPermission();
  Future<Position> getCurrentPosition();
}

class GeolocatorLocationService implements ILocationService {
  @override
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();
  @override
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();
  @override
  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();
}

typedef GeolocatorService = Future<Position> Function();

class MapScreen extends StatefulWidget {
  final ILocationService locationService;
  MapScreen({super.key, ILocationService? locationService})
    : locationService = locationService ?? GeolocatorLocationService();

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _recenterMap() {
    if (_position != null) {
      _mapController.move(
        LatLng(_position!.latitude, _position!.longitude),
        13,
      );
    }
  }

  Position? _position;
  String? _error;
  bool _loading = true;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    setState(() => _loading = true);
    LocationPermission permission = await widget.locationService
        .checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await widget.locationService.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      setState(() {
        _error = 'Location permission denied.';
        _loading = false;
      });
      return;
    }
    try {
      final pos = await widget.locationService.getCurrentPosition();
      setState(() {
        _position = pos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to get location: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'MapScreen build: loading=$_loading, error=$_error, position=$_position',
    );
    if (_loading) {
      debugPrint('MapScreen: showing loading indicator');
      return Scaffold(
        appBar: AppBar(title: const Text('AviationMap')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      debugPrint('MapScreen: showing error UI: $_error');
      return Scaffold(
        appBar: AppBar(title: const Text('AviationMap')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _requestLocationPermission,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    final latLng = LatLng(_position!.latitude, _position!.longitude);
    debugPrint('MapScreen: showing map at $latLng');
    return Scaffold(
      appBar: AppBar(title: const Text('AviationMap')),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: latLng, initialZoom: 13),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.aviationmap', // Set your app's package name
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 32,
                      key: Key('userLocationMarker'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Ensure the FAB is always visible and not obscured by the map
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              key: const Key('recenterButton'),
              onPressed: _recenterMap,
              tooltip: 'Recenter map',
              child: const Icon(Icons.center_focus_strong),
            ),
          ),
        ],
      ),
    );
  }
}

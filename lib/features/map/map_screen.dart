import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// Service to handle location and permission logic.
class LocationService {
  Future<bool> requestPermission() async {
    final status = await Geolocator.requestPermission();
    return status == LocationPermission.always || status == LocationPermission.whileInUse;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (_) {
      return null;
    }
  }
}

/// ViewModel for map state (location, errors, permission).
class MapViewModel extends ChangeNotifier {
  final LocationService locationService;
  LatLng? userLocation;
  String? error;
  bool permissionGranted = false;
  bool loading = true;

  MapViewModel({LocationService? locationService}) : locationService = locationService ?? LocationService();

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

/// MapScreen displays the main map UI, handles permission, user marker, and recenter FAB.

class MapScreen extends StatefulWidget {
  final LocationService? locationService;
  const MapScreen({Key? key, this.locationService}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late final MapViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MapViewModel(locationService: widget.locationService);
    viewModel.init();
    viewModel.addListener(_onModelChanged);
  }

  @override
  void dispose() {
    viewModel.removeListener(_onModelChanged);
    viewModel.dispose();
    super.dispose();
  }

  void _onModelChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (viewModel.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (viewModel.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(viewModel.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: viewModel.init,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: viewModel.userLocation,
          zoom: 13,
          interactiveFlags: InteractiveFlag.all,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.aviationmap',
          ),
          if (viewModel.userLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: viewModel.userLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 36,
                    semanticLabel: 'Your location',
                    key: Key('userLocationMarker'),
                  ),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: viewModel.permissionGranted
          ? FloatingActionButton(
              key: const Key('recenterButton'),
              onPressed: viewModel.recenter,
              tooltip: 'Re-center map',
              child: const Icon(Icons.my_location),
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../core/location_service.dart';
import '../core/map_view_model.dart';

/// MapScreen displays the main map UI, handles permission, user marker, and recenter FAB.

class MapScreen extends StatefulWidget {
  final LocationService? locationService;
  const MapScreen({super.key, this.locationService});

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
    // Show full-screen spinner only on initial load (no userLocation yet)
    if (viewModel.loading && viewModel.userLocation == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: viewModel.userLocation ?? const LatLng(0, 0),
              initialZoom: 13,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
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
          // Show a small loading overlay if recentering (not initial load)
          if (viewModel.loading && viewModel.userLocation != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: viewModel.permissionGranted
          ? FloatingActionButton(
              key: const Key('recenterButton'),
              onPressed: viewModel.recenter,
              tooltip: 'Re-center map',
              child: viewModel.loading && viewModel.userLocation != null
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Icon(Icons.my_location),
            )
          : null,
    );
  }
}

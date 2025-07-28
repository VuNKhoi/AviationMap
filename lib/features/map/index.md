
# Map Feature

## MapScreen Implementation (MVP)

### Behavior
- On startup, requests location permission using `geolocator`.
- Shows a loading indicator while waiting for permission and location.
- If permission is denied, displays an error message and disables map features.
- If permission is granted, centers the map on the user's location and displays a marker.
- Uses OpenStreetMap tiles via `flutter_map` for the base map.

### Components
- `MapScreen`: Stateful widget handling permission, location, and map display.
- Location permission logic is handled in `initState` and a helper method.
- User marker is shown using a blue location icon.
- Error UI is shown for denied permission or location errors.

### Rationale
- Keeping all map logic in `map_screen.dart` simplifies migration, testing, and onboarding.
- Error handling and permission flow are explicit for reliability and user experience.
- Modular design allows easy extension for overlays, options, and migration to MapLibre.

### Testing
- Widget tests cover loading, permission denied, and marker display states.
- Further tests can mock location and permission flows for full coverage.

### Extending
- Add overlays and quick actions via Option Grid.
- Refactor map logic into abstractions (e.g., `BaseMapView`) for MapLibre migration.


## Purpose
Displays the main map, overlays, and user location.

## Overlays & Map Types
- Supports multiple map overlays: streetmap (default), FAA sectional, IFR low, IFR high.
- Overlays are managed via the Option Grid and can be switched at runtime.
- All overlay logic is abstracted behind the `MapOverlayType` enum and view models, making it easy to add or modify overlays.
- The map can display the user's current GPS position as a marker, and supports panning, zooming, and overlay stacking.
- Overlay data is sourced from open and authoritative sources (e.g., OpenAIP, FAA, Eurocontrol) and processed into XYZ raster tiles or GeoJSON as needed.

## Structure
- `domain/`: Contains `MapOverlayType` enum, view models, and `IGeolocatorService` abstraction.
- `application/`: Providers and notifiers for overlay state and map logic.
- `widgets/`: UI-only map widgets (e.g., `BaseMapView`).

## Rationale
- **SRP:** Map logic, overlay state, and UI are separated.
- **Abstractions:** All geolocation and tile provider logic is injectable for testability.
- **UI-only Widgets:** Map widgets do not contain business logic, only receive data/state via parameters.
- **Testability:** Fake geolocator and tile providers are used in tests to avoid network/platform dependencies.

## Extending
- Add overlays by updating the enum and view model, and extending the provider logic.
- UI changes go in `widgets/` only.
- Overlay sources and types can be extended by adding new tile/GeoJSON sources and updating the abstraction.

## Testing
- Inject fake geolocator and tile providers in tests.
- Override overlay provider state for deterministic UI.

---

> For overall documentation and architecture principles, see the "Documentation & Architecture Principles" section in the README.md.

# Example
- To add a new overlay, add it to `MapOverlayType`, update the view model, and extend the provider logic.

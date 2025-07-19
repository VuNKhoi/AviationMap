# Map Feature

## Purpose
Displays the main map, overlays, and user location.

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

## Testing
- Inject fake geolocator and tile providers in tests.
- Override overlay provider state for deterministic UI.

---

# Example
- To add a new overlay, add it to `MapOverlayType`, update the view model, and extend the provider logic.

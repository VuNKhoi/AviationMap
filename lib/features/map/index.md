
# Map Feature Documentation

This document covers the map feature in AviationMap: overlays, user location, recentering, and extensibility.

## Overview
- Uses flutter_map for MVP (BaseMapView abstraction in progress)
- Supports FAA chart overlays (sectional, IFR low/high, terminal area)
- User location and recentering
- Modular, testable, and ready for future map engine swaps

## Architecture
- Map logic is abstracted behind a view model and service layer
- Location and permission logic is in LocationService
- State is managed with Riverpod providers
- UI is separated from business logic

## Extensibility
- Overlays and layers are modular and can be extended
- Map engine can be swapped by updating BaseMapView

## References
- See [architecture.md](../../../docs/architecture.md) for project structure
- See [riverpod.md](../../../docs/riverpod.md) for state management patterns

---
Add new map feature notes and patterns here as the feature evolves.
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

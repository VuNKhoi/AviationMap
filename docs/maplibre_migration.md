
# MapLibre Migration Status & Guide

This document tracks the plan and readiness for migrating from flutter_map to MapLibre.

## Why Migrate to MapLibre?
- Full open-source control and flexibility
- Advanced features (vector tiles, 3D terrain, custom styles)
- No vendor lock-in, scalable for future needs

## Migration Readiness
- All map logic is being abstracted behind `BaseMapView` and a service layer.
- Overlay logic is modular and ready for engine swap.
- Testing and validation are ongoing to ensure compatibility.

## Next Steps
- Complete BaseMapView abstraction.
- Implement MapLibre wrapper and test overlays, markers, and user location.
- Update documentation and onboarding notes as migration progresses.

## Technical Challenges
- Platform channel integration for advanced features
- Tile caching and offline support
- Styling and interactivity differences

## Resources
- [MapLibre GL for Flutter](https://github.com/maplibre/flutter-maplibre-gl)
- [MapLibre Documentation](https://maplibre.org/)

---
Update this doc as migration progresses.

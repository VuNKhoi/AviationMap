# MapLibre Migration Status & Guide

This document tracks the migration from flutter_map to MapLibre, including technical details, challenges, and progress.

## Why Migrate to MapLibre?
- Full open-source control and flexibility
- Advanced features (vector tiles, 3D terrain, custom styles)
- No vendor lock-in, scalable for future needs

## Migration Steps
1. Abstract all map logic behind `BaseMapView` and service layer
2. Implement MapLibre wrapper and platform channels as needed
3. Migrate overlays, markers, and user location logic
4. Test all overlays and map features for compatibility
5. Update documentation and onboarding notes

## Current Status
- [ ] flutter_map is used for MVP
- [ ] MapLibre wrapper is in development
- [ ] Overlay logic is abstracted and ready for migration
- [ ] Testing and validation in progress

## Technical Challenges
- Platform channel integration for advanced features
- Tile caching and offline support
- Styling and interactivity differences

## Resources
- [MapLibre GL for Flutter](https://github.com/maplibre/flutter-maplibre-gl)
- [MapLibre Documentation](https://maplibre.org/)

---
Update this doc as migration progresses.

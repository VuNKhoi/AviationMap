
# TODOs for AviationMap (Detailed Roadmap)

## 1. Map MVP with flutter_map
- [ ] Add `flutter_map` and `geolocator` dependencies.
- [ ] Implement map screen in `map_screen.dart` (rationale: keeps feature logic together, easier to refactor for migration).
  - Keeping all map logic in one place simplifies testing and onboarding. New files can be added for abstractions later.
- [ ] Request location permission on startup (use `geolocator`).
  - Checkpoint: Permission dialog appears, handles denied/allowed states.
  - Be aware: iOS/Android permission flows differ; test both.
- [ ] Center map on user’s current location after permission is granted.
  - Rationale: Improves UX for pilots; map is immediately relevant.
- [ ] Add floating action button to re-center map on user’s location.
  - Checkpoint: Button is visible, works after permission granted.
- [ ] Display user’s location as a marker on the map.
  - Be aware: Location updates, marker accuracy, and error handling.
- [ ] Handle permission denied and location errors gracefully (show error UI).
  - Rationale: Avoids confusion, improves reliability.
- [ ] Add basic unit and widget tests for map and location flows.
  - Checkpoint: Tests pass for permission, location, and UI states.

### For maintainability and future development:
- [ ] Abstract location and permission logic into a service/provider (not just in widget).
- [ ] Use a view model or state notifier for map state (location, errors, permission).
- [ ] Ensure all services (location, map) are injectable/mocked in tests.
- [ ] Add a mock location provider for widget tests (simulate denied/allowed/error).
- [ ] Add basic accessibility labels for map controls and error messages.
- [ ] Prepare for i18n (wrap user-facing strings for easy translation).
- [ ] Add hooks for logging permission/location events (even if just debugPrint for now).
- [ ] Profile map and location update performance (ensure no jank on low-end devices).
- [ ] Add a “dev mode” toggle to show debug info (e.g., current lat/lon, permission state).
- [ ] Document how to run and test the map MVP in README or a dev guide.
- [ ] Design error UI to be easily extendable (e.g., error widget with retry/callback).
- [ ] (Optional) Save/restore last map position if location is denied.
- [ ] Add doc comments to all public classes/methods, especially for map and location logic.
- [ ] Add a basic test for map screen to CI pipeline (if not already).

## 2. Option Bubble & Grid
- [ ] Implement Option Bubble (floating button) to open Option Grid.
- [ ] Add quick actions to Option Grid (e.g., switch overlays, center map).
- [ ] Pass actions via parameters/providers for testability.
- [ ] Add widget tests for Option Bubble/Grid.
  - Rationale: Modular, testable UI; easy to extend.

## 3. Overlay Support
- [ ] Add FAA sectional, IFR low, IFR high overlays as selectable layers.
- [ ] Abstract overlay logic behind enums and view models.
- [ ] Validate overlays on real devices and emulators.
- [ ] Document overlay sources and configuration.
  - Checkpoint: All overlays display correctly; docs updated.

## 4. Tile Caching & Fallback
- [ ] Implement tile caching for offline support.
- [ ] Add fallback logic for missing tiles.
- [ ] Test caching and fallback on various devices.
  - Be aware: Storage limits, cache invalidation, and platform differences.

## 5. Error Handling & Stability
- [ ] Add error boundary widgets and global error handling.
- [ ] Integrate logging for errors and important events (Sentry/Firebase Crashlytics).
- [ ] Add runtime checks for permissions and platform-specific features.
  - Rationale: Improves reliability and debugging.

## 6. Security & Secrets
- [ ] Remove all secrets from repo/logs.
- [ ] Store secrets in environment variables or CI/CD secrets.
- [ ] Add .gitignore rules for secrets/config files.
- [ ] Add CI/CD steps to restore/write secrets at build time.
  - Be aware: Never commit secrets; automate secret management.

## 7. Testing & CI/CD
- [ ] Expand unit, widget, and integration tests for all flows.
- [ ] Set up GitHub Actions for linting, testing, and builds (Android/iOS/Web).
- [ ] Add automated test coverage reporting.
- [ ] Add pre-commit hooks for lint, format, and tests.
  - Checkpoint: CI/CD runs on every push/PR; coverage is tracked.

## 8. Documentation & Onboarding
- [ ] Update docs as features evolve.
- [ ] Add onboarding notes and diagrams for contributors.
- [ ] Expand technical guides for overlays, map, and options.
  - Rationale: Ensures maintainability and easy onboarding.

## 9. Map Engine Abstraction
- [ ] Abstract all map logic behind `BaseMapView` and service layer.
- [ ] Prepare for future map engine swaps (e.g., MapLibre, vector tiles, advanced overlays).
- [ ] Document abstraction steps and update architecture docs.
  - Checkpoint: Abstraction plan is clear; code is ready for engine switch.

## 10. FAA Chart Pipeline Review
- [ ] Periodically review FAA chart pipeline and overlay accuracy.

## 11. Web Support (after mobile is stable)
- [ ] Add web-specific TODOs and implementation steps.

---
**Rationale:**
This roadmap ensures modular, testable, and maintainable code. Each checkpoint is designed to catch issues early, improve UX, and make future engine swaps seamless. Documenting rationale and things to be aware of helps onboard new contributors and avoid common pitfalls.

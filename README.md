# Aviation Map: Modern Flutter Aviation App

## Overview
- **Separation of concerns**: UI, business logic, and data access are separated using Riverpod providers, repositories, and notifiers.
- **Reusable widgets**: Common UI elements (fields, banners, buttons) are extracted for maintainability and testability.

## No Authentication
Aviation Map is fully open and free to use. No login, registration, or authentication is required. All features are available to every user.
## Project & Documentation Structure

### Codebase Organization
```
lib/
  constants.dart
  app.dart
  main.dart
  features/
    splash/
      index.md        # Feature documentation (Markdown)
      splash_screen.dart
    map/
      index.md        # Feature documentation (Markdown)
      map_screen.dart
    options/
      index.md        # Feature documentation (Markdown)
      ...
    ...
  widgets/
  services/
  utils/
test/
integration_test/
docs/
  index.md           # Documentation hub
  architecture.md    # Architecture and principles
  todo.md            # Project TODOs
  CONTRIBUTING.md    # Contribution guidelines
  migration.md       # Migration guide
  ...
```

### Naming Conventions
- Feature folders use singular names (e.g., `map`, `splash`, `options`).
- Each feature folder contains an `index.md` for documentation and relevant Dart files for implementation.
- Shared documentation is in the `docs/` folder, with links to feature docs.
- All links in documentation point to the correct feature or doc location for consistency.

### Documentation Practices
- All features have their own `index.md` in their respective folders.
- The main documentation index (`docs/index.md`) links to all features and core docs.
- Documentation is updated as features evolve and new folders/files are added.

This structure ensures clarity, maintainability, and easy onboarding for new contributors.
- **Interoperability**: Tiles and styles are stored in open formats (XYZ raster, Style JSON v8).
- **Dependency injection**: Map engine selection is configurable for easy migration.
- **Offline-first**: The architecture anticipates offline support from the start.

## Aviation Overlays & Airspace Data

Aviation Map is designed to support advanced aviation features such as FAA chart overlays and airspace boundaries. These features are enabled by integrating open and authoritative data sources:

- **Airspace Boundaries:**
  - Sourced from [OpenAIP](https://www.openaip.net/) (global, GeoJSON), FAA (US, Shapefile/GeoJSON), Eurocontrol (Europe, AIXM/GeoJSON), and other open-data projects.
  - Data includes lines and polygons for all major airspace classes, restricted areas, and more.
  - Data is regularly updated and can be automated via APIs or scheduled downloads.
- **FAA Sectional/IFR Overlays:**
  - FAA raster charts are processed into XYZ tiles and overlaid as raster TileLayers in flutter_map.
- **Terrain Visualization:**
  - (Optional, not planned for MVP) MapLibre supports 3D terrain using DEM tiles; flutter_map supports raster hillshading and custom layers.

### Compatibility
- All airspace and overlay data (GeoJSON, KML, Shapefile) can be rendered as vector or raster overlays in both **flutter_map** and **MapLibre**.
- The app's map abstraction ensures seamless integration and future migration between mapping engines.
- Styling, interactivity, and offline support are supported in both approaches.

## Project Structure
```
lib/
  constants.dart
  app.dart
  main.dart
  features/
    splash/
      splash_screen.dart
    map/
      map_screen.dart
    // No auth feature folder (fully open app)
    // home/ (not used, splash and map are entry points)
    ...
  widgets/
  services/
  utils/
  ...
test/
integration_test/
```

## Testing
- **Widget and unit tests**: All reusable widgets and flows are tested, including splash screen and navigation transitions.
- **Integration tests**: Navigation flows (e.g., splash to map) are covered.
- **Test helpers**: Common test setup and mocks are provided in `test_helpers.dart`.
- **Test grouping**: All tests in a file should be placed inside a `group()` for clarity, organization, and to ensure proper setup/teardown. This is a project convention for all test files.

## Future Plans
- Complete flutter_map MVP and user testing.
- Build out the `BaseMapView` abstraction for all map logic (start early to support multiple map/overlay types).
- Prepare FAA chart tiling and hosting pipeline (XYZ raster tiles for sectional, IFR low, and IFR high overlays).
- Migrate to MapLibre for open-source, offline, and scalable deployment.
- Integrate advanced aviation overlays (airspace, NOTAMs, etc.) and ensure compatibility with both flutter_map and MapLibre.

## Contributing
- Follow the feature-based folder structure and keep business logic out of UI widgets.
- Add tests for all new widgets and flows.
- Use constants and theming for all UI elements.
- Document all public classes and methods.

---


## Architectural Principles: Decoupling & Maintainability

- **Dependency Injection & Testability**: We follow the principle of **programming to an interface** (Dependency Inversion Principle, SOLID) and use **dependency injection** wherever possible. This means:
  - All platform-dependent or side-effectful logic (e.g., location, permissions, storage, network) should be abstracted behind interfaces.
  - UI and business logic depend only on abstractions, not concrete implementations.
  - In production, real implementations are injected; in tests, mocks/fakes are injected for full control and reliability.
  - **Benefits:** Makes code easy to test, maintain, and extend. Decouples UI from platform details. Enables robust widget and unit testing.
  - **Guideline:** When adding new features or platform logic, always consider introducing an interface and injecting it, rather than calling platform APIs directly in widgets or business logic.

- **Routing and Auth Decoupling**: Routing logic should not directly depend on authentication providers. Use navigation guards, services, or event-based patterns to handle redirects and access control.
- **Screen Construction**: Route definitions should use factories or builders for screen creation, not direct instantiation. This enables dependency injection and easier refactoring.
- **Provider Abstraction**: UI widgets should depend on interfaces or abstract providers, not concrete implementations. Pass providers as parameters for easier testing and mocking.
- **Enum/UI Decoupling**: UI code should not directly reference enums for display. Use view models or mapping layers to translate enum values to user-facing strings and icons.
- **Test-Driven**: All new features and bug fixes should include appropriate widget and logic tests. Fix all failed tests unless the subject is deprecated, hard to test, or integration-only.

_These principles ensure Aviation Map remains modular, testable, and easy to maintain as it grows._

## SOLID Principles & Code Quality

Aviation Map adheres to the SOLID principles of object-oriented design:

- **S: Single Responsibility Principle (SRP)** — Every class, file, and module should have one responsibility. For example, enums and view models are separated from widgets, and business logic is decoupled from UI.
- **O: Open/Closed Principle** — Code is open for extension but closed for modification. New map overlays or features can be added without changing core logic.
- **L: Liskov Substitution Principle** — Subtypes can replace their base types without breaking the app. All abstractions and interfaces are designed for safe extension.
- **I: Interface Segregation Principle** — Classes and widgets depend only on the interfaces they use. UI, domain, and data layers are separated.
- **D: Dependency Inversion Principle** — High-level modules do not depend on low-level modules; both depend on abstractions. Providers and dependency injection are used throughout.

All new code and refactors should conform to these principles for maintainability and scalability.

## Questions for the Team
1. **Map Abstraction**: Should the `BaseMapView` abstraction be a widget, a service, or both? (Current plan: widget with injectable engine)
2. **FAA Chart Hosting**: Is there a preferred cloud provider for tile hosting (Cloudflare, S3, or self-hosted)?
3. **Offline Support**: Should we prioritize full offline support in the MVP, or defer until after MapLibre migration?
4. **Testing**: Are there any additional flows or edge cases that should be prioritized for automated testing?
5. **Open-Source Goals**: Are there any licensing or compliance requirements we should consider for MapLibre and FAA data?

---

For more details, see the project plan in this README or contact the maintainers.
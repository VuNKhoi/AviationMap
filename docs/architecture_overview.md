# AviationMap Architecture Overview

## Principles

AviationMap is architected for maintainability, testability, and scalability, following SOLID principles:
- **Single Responsibility Principle (SRP):** Each class/module has one responsibility.
- **Open/Closed Principle:** Code is open for extension, closed for modification.
- **Liskov Substitution Principle:** Interfaces and base classes are substitutable.
- **Interface Segregation Principle:** Use small, focused interfaces.
- **Dependency Inversion Principle:** Depend on abstractions, not concretions.


## App Flow
1. App launches with a splash screen for branding and resource preparation.
2. After a brief delay, the app transitions to the main map view.
3. All subsequent navigation and features are accessible from the map screen.

## Project Structure
| Folder | Purpose |
|--------|---------|
| lib/features/splash/ | Splash screen feature |
| lib/features/map/ | Map feature |
| lib/core/ | Shared utilities, base classes |
| lib/constants.dart | App-wide constants |
| lib/widgets/ | Shared UI widgets |
| test/ | Unit/widget tests |
| docs/ | Documentation |

## Style Guide & Code Review
- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use the [Flutter Code Review Checklist](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)

## Common Pitfalls & Anti-Patterns
- Mixing business logic into UI widgets (keep UI-only)
- Not injecting dependencies (use providers/services)
- Skipping tests for new features
- Hardcoding secrets or config in code

- `lib/features/` — Feature-based folders (auth, map, home, options, etc.)
- `lib/core/` — Shared core utilities, base classes, and abstractions
- `lib/constants.dart` — App-wide constants
- `lib/widgets/` — Shared UI widgets
- `test/` — Mirrors `lib/` for unit/widget tests
- `docs/` — Documentation for architecture and features

## Feature Folders

Each feature folder contains:
- `domain/` — Enums, models, interfaces, and business logic contracts
- `application/` — Providers, notifiers, and business logic implementations
- `presentation/` or `widgets/` — UI widgets/screens (UI-only, no business logic)
- `repositories/` — Data access implementations (if needed)

## Dependency Management
- All business logic depends on interfaces/abstractions, not concrete classes.
- Providers and notifiers are injected with dependencies via constructors or provider overrides.
- Widgets are UI-only and receive data/state via parameters or providers.

## Testing
- All test helpers and mocks implement the same interfaces as production code.
- Widget tests inject fake/mock services (e.g., geolocator, tile provider) to avoid platform dependencies and network calls.
- Provider state is overridden in tests for deterministic UI.

---

# Feature Documentation

See the following docs for detailed explanations and rationale for each feature:
- [Map Feature](./feature_map.md)
- [Home Feature](./feature_home.md)
- [Options Feature](./feature_options.md)

---

# Onboarding for New Developers

- Start by reading this overview and the feature docs.
- Each feature doc explains the folder structure, responsibilities, and how to extend or test the feature.
- All business logic is in providers/services, not UI.
- All dependencies are injected and testable.
- Tests are deterministic and do not depend on real network or platform APIs.

If you have questions, check the feature docs or ask the team!

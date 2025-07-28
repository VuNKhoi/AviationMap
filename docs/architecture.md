
# AviationMap Architecture

## Principles
AviationMap is architected for maintainability, testability, and scalability, following SOLID principles:
- **Single Responsibility Principle (SRP):** Each class/module has one responsibility.
- **Open/Closed Principle:** Code is open for extension, closed for modification.
- **Liskov Substitution Principle:** Interfaces and base classes are substitutable.
- **Interface Segregation Principle:** Use small, focused interfaces.
- **Dependency Inversion Principle:** Depend on abstractions, not concretions.

## Project Structure
| Folder | Purpose |
|--------|---------|
| lib/features/ | Feature-based code organization (map, splash, options, etc.) |
| lib/core/ | Shared services, providers, and utilities |
| lib/common/ | Reusable widgets and UI components |
| lib/constants.dart | App-wide constants |
| test/ | Unit/widget tests (mirrors lib/) |
| docs/ | Documentation |

## Feature Folders
Each feature folder contains:
- `domain/` — Enums, models, interfaces, and business logic contracts
- `application/` — Providers, notifiers, and business logic implementations
- `widgets/` — UI widgets/screens (UI-only, no business logic)
- `repositories/` — Data access implementations (if needed)

## Dependency Injection
- Use Riverpod for all app state and service injection
- Centralize providers in `lib/core/providers.dart`
- Providers and notifiers are injected with dependencies via constructors or provider overrides.
- Widgets are UI-only and receive data/state via parameters or providers.

## Logging
- Use `AppLogger` (wrapper for `logger` package) for all logging

## Constants
- Centralize constants in `lib/core/constants.dart`

## Error Handling
- Add global error handler in main entry point

## Style Guide & Code Review
- Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use the [Flutter Code Review Checklist](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)

## Common Pitfalls & Anti-Patterns
- Mixing business logic into UI widgets (keep UI-only)
- Not injecting dependencies (use providers/services)
- Skipping tests for new features
- Hardcoding secrets or config in code

## Testing
- All business logic is covered by unit tests.
- All UI widgets are covered by widget tests with provider overrides and fake services.
- Integration tests cover critical flows (map overlays, user location, options, splash-to-map navigation, etc.).
- No tests depend on real network or platform APIs; all dependencies are injected and mockable.
- Use `test/test_helpers.dart` for common test setup and mocks
- Widget tests inject fake/mock services (e.g., geolocator, tile provider) to avoid platform dependencies and network calls.
- Provider state is overridden in tests for deterministic UI.

## Onboarding for New Developers
- Start by reading this overview and the feature docs.
- Each feature doc explains the folder structure, responsibilities, and how to extend or test the feature.
- All business logic is in providers/services, not UI.
- All dependencies are injected and testable.
- Tests are deterministic and do not depend on real network or platform APIs.

---
_This document will grow as the app evolves._

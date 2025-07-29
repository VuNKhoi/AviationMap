

# AviationMap Architecture

## Principles
AviationMap is designed for maintainability, testability, and scalability, following SOLID principles:
- Single Responsibility: Each class/module has one responsibility.
- Open/Closed: Code is open for extension, closed for modification.
- Liskov Substitution: Interfaces and base classes are substitutable.
- Interface Segregation: Use small, focused interfaces.
- Dependency Inversion: Depend on abstractions, not concretions.

## Folder Structure
| Folder         | Purpose                                      |
|---------------|----------------------------------------------|
| lib/features/  | Feature-based code (map, splash, options, etc.) |
| lib/core/      | Shared services, providers, and utilities     |
| lib/common/    | Reusable widgets and UI components            |
| lib/constants.dart | App-wide constants                        |
| test/          | Unit/widget tests (mirrors lib/)              |
| docs/          | Documentation                                 |


See [docs/index.md](index.md) for documentation structure, expectations, and feature documentation requirements.

## Dependency Injection & State Management
- Riverpod is used for all app state and service injection.
- Providers and notifiers are injected with dependencies via constructors or provider overrides.
- Widgets are UI-only and receive data/state via parameters or providers.
- See [Riverpod State Management](riverpod.md) for patterns and best practices.

## Logging & Constants
- Use `AppLogger` (wrapper for `logger` package) for all logging.
- Centralize constants in `lib/core/constants.dart`.

## Error Handling
- Add a global error handler in the main entry point.

## Code Style & Review
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).
- Use the [Flutter Code Review Checklist](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).

## Common Pitfalls
- Avoid mixing business logic into UI widgets.
- Always inject dependencies (use providers/services).
- Write tests for all new features.
- Never hardcode secrets or config in code.

## Testing
- All business logic is covered by unit tests.
- All UI widgets are covered by widget tests with provider overrides and fake services.
- Integration tests cover critical flows (map overlays, user location, options, splash-to-map navigation, etc.).
- No tests depend on real network or platform APIs; all dependencies are injected and mockable.
- See [Testing](testing.md) for details.

## Onboarding
- Start by reading this overview and the feature docs (each feature has an index.md).
- All business logic is in providers/services, not UI.
- All dependencies are injected and testable.
- Tests are deterministic and do not depend on real network or platform APIs.

---
_This document will grow as the app evolves. See [index.md](index.md) for the full doc hub._

# AviationMap Testing Strategy

This document details the testing philosophy, coverage, and CI/CD integration for AviationMap.

## Principles
- All business logic is covered by unit tests.
- All UI widgets are covered by widget tests with provider overrides and fake services.
- Integration tests cover critical flows (map overlays, user location, options, splash-to-map navigation, etc.).
- No tests depend on real network or platform APIs; all dependencies are injected and mockable.

## Structure
- `test/`: Mirrors `lib/` for unit and widget tests.
- `integration_test/`: End-to-end integration tests.

## CI/CD Integration
- GitHub Actions runs all tests on every push and pull request.
- Automated coverage reporting and linting are included in CI/CD workflows.

## How to Run Tests
```bash
flutter test
flutter test test/widget_test.dart
flutter test test/feature_map_test.dart
```

## How to Add Tests
- Add new tests in the corresponding feature folder under `test/`.
- Use provider overrides and fake services for deterministic results.
- Test that splash screen displays on launch and transitions to map screen after delay.
- For integration tests, use the `integration_test/` folder and follow Flutter's integration test setup.

## Coverage
- Run coverage locally with `flutter test --coverage`.
- Review coverage reports to identify gaps and improve test quality.

---
Add more testing notes and examples as the project evolves.

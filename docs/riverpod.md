# Riverpod State Management 💙

## Why Riverpod?
- Scalable, testable, and safe state management for Flutter.
- Decouples business logic from UI.
- Supports dependency injection and provider overrides for testing.

## Usage
- Define providers for app state, services, and configuration.
- Use `ConsumerWidget` or `ref.watch()` to access state in widgets.
- Override providers in tests for deterministic results.

## Example
```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

## Principles
- Keep business logic out of UI widgets.
- Use providers for all shared state and services.
- Test providers and state changes with unit and widget tests.

---
Add new provider patterns and best practices here as the app grows.

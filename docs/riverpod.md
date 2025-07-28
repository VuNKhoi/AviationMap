

# Riverpod State Management

Riverpod is the foundation for scalable, testable, and robust state management in AviationMap. It decouples business logic from UI, enables dependency injection, and supports modular architecture.

## Core Usage
- Define providers for app state, services, and configuration (e.g., `StateProvider`, `StateNotifierProvider`, `FutureProvider`).
- Access state in widgets using `ConsumerWidget`, `Consumer`, or `ref.watch()`/`ref.read()`.
- Use provider families for parameterized state (e.g., `StateProvider.family`).
- Override providers in tests for deterministic, isolated results.
- Wrap your app in `ProviderScope` for global overrides and dependency injection.

### Example
```dart
final mapViewModelProvider = StateNotifierProvider<MapViewModel, MapState>((ref) {
  return MapViewModel(ref.watch(locationServiceProvider));
});

final locationServiceProvider = Provider<LocationService>((ref) => LocationService());
```

## Advanced Patterns
- Use `AsyncValue` for loading/error/data states in async providers.
- Use `StateNotifier` or `Notifier` for complex state and business logic.
- Compose providers for modular, testable features.
- Use provider overrides in widget and integration tests to inject mocks/fakes.

## Best Practices
- Keep business logic out of UI widgets—use providers and notifiers.
- All shared state and services should be provided via Riverpod.
- Test providers and state changes with unit and widget tests.
- Document new provider patterns and best practices as the app grows.

## References
- See [architecture.md](architecture.md) for project structure and provider placement.
- See [testing.md](testing.md) for provider testing and overrides.

---
Add new provider patterns, advanced usage, and best practices here as the project evolves.

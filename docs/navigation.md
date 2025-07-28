# Navigation Strategy 🚦

Navigation in AviationMap is declarative, testable, and fully decoupled from UI logic. This enables scalable route management and robust testing.

## Frameworks
- Uses [go_router](https://pub.dev/packages/go_router) for navigation.
- Navigation logic is abstracted via a NavigationService for testability and decoupling.

## Route Configuration
- All routes are defined in `lib/navigation/route_config.dart`.
- Use named routes for maintainability and deep linking.

## Principles
- Centralize route definitions for clarity.
- Decouple navigation logic from UI and business logic.
- Use Riverpod for dependency injection and state management.
- Test navigation flows with widget and integration tests.

## Example
```dart
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
  ],
);
```

## Architectural Context
- Navigation is a core part of the app's modular architecture.
- See [architecture.md](architecture.md) for how navigation fits into the overall structure.
- See [riverpod.md](riverpod.md) for state management and dependency injection patterns.
- See [testing.md](testing.md) for navigation testing strategies.

---
Add new routes and navigation patterns here as the app grows. For feature-specific navigation, document patterns in the relevant feature's `index.md`.

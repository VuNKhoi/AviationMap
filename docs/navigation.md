# Navigation Strategy 🚦

## Frameworks
- Uses [go_router](https://pub.dev/packages/go_router) for declarative, scalable navigation.
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

---
Add new routes and navigation patterns here as the app grows.

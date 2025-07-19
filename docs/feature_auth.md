# Auth Feature

## Purpose
Handles all authentication logic, state, and UI for AviationMap.

## Structure
- `domain/`: Contains `AuthStatus` enum and `IAuthRepository` interface.
- `application/`: Contains providers and notifiers for authentication state and logic.
- `repositories/`: Implements the repository interface for data access.
- `presentation/screens/`: UI screens for login, registration, etc. (UI-only, no business logic).

## Rationale
- **SRP:** Each class/file has a single responsibility (e.g., state, UI, data access).
- **Abstractions:** All business logic depends on `IAuthRepository` for testability and flexibility.
- **UI-only Widgets:** Screens and widgets do not contain business logic, only UI and callbacks.
- **Testability:** Providers and notifiers are injected with dependencies and can be mocked in tests.

## Extending
- Add new auth flows by extending the repository and updating the notifier/provider.
- UI changes go in `presentation/screens/` only.

## Testing
- Use mock/fake repositories and notifiers in tests.
- All provider state can be overridden for deterministic tests.

---

# Example
- To add a new login method, add it to the repository interface and implementation, then update the notifier/provider.

# AviationMap Architecture Overview

## Project Structure
- `lib/features/`: Feature-based code organization
- `lib/core/`: Shared services, providers, and utilities
- `lib/common/`: Reusable widgets and UI components

## Dependency Injection
- Use Riverpod for all app state and service injection
- Centralize providers in `lib/core/providers.dart`

## Logging
- Use `AppLogger` (wrapper for `logger` package) for all logging

## Testing
- Use `test/test_helpers.dart` for common test setup and mocks

## Constants
- Centralize constants in `lib/core/constants.dart`

## Error Handling
- Add global error handler in main entry point

---

_This document will grow as the app evolves._

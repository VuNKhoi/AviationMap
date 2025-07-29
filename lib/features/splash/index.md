
# Splash Screen Feature Documentation

## Feature Overview and Purpose
The splash screen provides a branded loading experience and is the entry point for app setup logic (e.g., config loading, permissions, service initialization). Navigation to the main map is handled by the parent widget.

## Key Implementation Details
- `SplashScreen` is a `StatefulWidget`.
- Setup logic is placed in `_setupApp()` (async, extensible).
- UI includes app branding, loading indicator, and is styled for dark mode.
- Navigation to the map screen is triggered after setup (by parent).

## Extensibility
- Add setup steps to `_setupApp()` as needed (e.g., permissions, config, service init).
- Add error handling and UI for setup failures if required.
- Animate branding or loading indicator for a polished experience.

## Testing Notes
- Widget test verifies branding and progress indicator are shown.
- Widget test verifies setup logic runs and splash screen remains visible during setup.
- (Optional) Splash screen displays error UI if setup fails.

## Example Test Cases
- Splash screen displays correct branding and loading indicator.
- Splash screen runs setup logic and remains visible during setup.
- (Optional) Splash screen displays error UI if setup fails.

---
See `splash_screen_test.dart` for implementation details.

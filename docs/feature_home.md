# Home Feature

## Purpose
Hosts the main app screen, navigation, and integrates map and options features.

## Structure
- `presentation/screens/`: Main home screen UI (UI-only, no business logic).
- Integrates map, options, and account features via composition.

## Rationale
- **SRP:** Home screen is responsible only for layout and navigation.
- **Composition:** Integrates other features via widgets and providers.
- **UI-only Widgets:** No business logic in UI files.

## Extending
- Add new UI elements or navigation by updating the home screen widget.
- Integrate new features via providers and widget composition.

## Testing
- Use provider overrides and fake services for deterministic widget tests.

---

# Example
- To add a new quick action, update the options feature and compose it in the home screen.

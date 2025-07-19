# Options Feature

## Purpose
Provides the floating Option Bubble and Option Grid for quick access to app actions.

## Structure
- `widgets/`: UI-only widgets for the option bubble and grid.

## Rationale
- **SRP:** Each widget is responsible for a single UI concern.
- **UI-only:** No business logic or state in UI files; all actions/data are passed via parameters or providers.
- **Testability:** Widgets are easily testable with provider overrides and parameter injection.

## Extending
- Add new options by updating the grid widget and passing new actions via parameters.

## Testing
- Use provider overrides and parameter injection for deterministic widget tests.

---

# Example
- To add a new option, update the grid widget and pass the action via the parent widget.

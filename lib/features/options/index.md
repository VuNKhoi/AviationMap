# Options Feature

## Purpose
Provides the floating Option Bubble and Option Grid for quick access to app actions.

## Behavior & Design
- The Option Bubble is a draggable, floating button that snaps to the nearest screen edge with a margin for comfort. This keeps the UI uncluttered and improves usability.
- When tapped, the Option Bubble expands into an Option Grid (minimum 2x2 layout), showing quick-access actions.
- The Option Grid includes controls for switching map overlay types (e.g., streetmap, sectional, IFR low, IFR high), and can be extended with more options as needed.
- The design is modular: UI-only widgets, no business logic inside, and all actions are passed in from above (parent/provider).
- This system is easy to test and extend, and supports a clean, modern UX for map-based apps.

## Structure
- `widgets/`: UI-only widgets for the option bubble and grid.

## Rationale
- **SRP:** Each widget is responsible for a single UI concern.
- **UI-only:** No business logic or state in UI files; all actions/data are passed via parameters or providers.
- **Testability:** Widgets are easily testable with provider overrides and parameter injection.

## Extending
- Add new options by updating the grid widget and passing new actions via parameters.
- The grid is designed to be easily extendable for future quick actions.

## Testing
- Use provider overrides and parameter injection for deterministic widget tests.

# Example
- To add a new option, update the grid widget and pass the action via the parent widget.

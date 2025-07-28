# Recent UI/UX Notes and Technical Details


## 2025-07-28: Map Recenter Button UI/Logic/Behavior

### User Experience
- When the user taps the "center the map" button (FAB), the app instantly recenters the map to the last known location (if available), providing immediate feedback.
- In the background, the app requests a fresh GPS location. When the new location is available, the map animates or updates to the new position.
- If fetching the new location takes longer than 300ms, a small loading spinner appears in the FAB and as a semi-transparent overlay, but the map remains visible and interactive.
- The full-screen loading spinner is only shown on initial app load, not during recenter actions.

### Logic Details
- The recenter button triggers the following sequence:
  1. Get the last known location (if available) and update the map immediately.
  2. Start fetching a fresh GPS location in the background.
  3. If the GPS fetch takes >300ms, show a small spinner overlay and in the FAB.
  4. When the new location arrives, update the map and remove the spinner.
- If no last known location is available, the spinner appears immediately while waiting for the GPS fix.
- If the location fetch fails, an error message is shown.

### UI Details
- The FloatingActionButton (FAB) shows a spinner when loading, otherwise the location icon.
- A semi-transparent overlay with a spinner is shown only if loading and a location is already present (not on initial load).
- The map is never fully blocked during recentering; only the spinner overlay and FAB indicate loading.

### Rationale
- This approach provides instant feedback, keeps the UI responsive, and avoids blocking the map view.
- It matches best practices for location-based apps and modern mobile UX.

---

## Other Notes
- NDK version mismatches: Always use the highest required NDK version in `android/app/build.gradle.kts` for plugin compatibility.
- OSM tile server warnings: For production, use your own or a commercial tile server, not the public OSM demo server.
- Async ViewModel bug: Always guard `notifyListeners()` with a `_disposed` flag to avoid using disposed objects in async code.

---

Add more notes here as you encounter new UI/UX or technical details.

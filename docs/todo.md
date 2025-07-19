# TODOs for AviationMap

## Map Stability (iOS & Android)
- [ ] Ensure all overlays display correctly:
  - [ ] Sectional
  - [ ] IFR Low
  - [ ] IFR High
- [ ] Test overlays on real devices and emulators (various screen sizes)
- [ ] Fix any crashes, glitches, or missing tiles
- [ ] Validate tile caching and fallback logic
- [ ] Document tile server URLs and overlay configuration in code/docs

## Security
- [ ] Remove all secrets (API keys, service files) from the repo and logs
- [ ] Store secrets in environment variables or GitHub Actions secrets
- [ ] Add CI/CD steps to write secrets to files at build time (see workflow example)
- [ ] Review all code and docs for accidental secret exposure
- [ ] Add .gitignore rules for secrets and config files

## Best Practices & Code Quality
  - [ ] Add/expand unit tests for business logic
  - [ ] Add/expand widget tests for UI
  - [ ] Add/expand integration tests for flows (auth, map, overlays)

## Additional Best Practices & Stability
- [ ] Add error boundary widgets and global error handling for uncaught exceptions
- [ ] Add logging for errors and important events (consider Sentry or Firebase Crashlytics)
- [ ] Add runtime checks for platform-specific features (e.g., permissions, sensors)
- [ ] Add automated test coverage reporting to CI/CD
- [ ] Add pre-commit hooks for lint, format, and tests (e.g., with Husky or Lefthook)
- [ ] Review all dependencies for maintenance and security (remove unused/outdated packages)
- [ ] Add onboarding documentation for new contributors

## CI/CD
- [ ] Set up GitHub Actions workflow for:
  - [ ] Linting
  - [ ] Testing
  - [ ] Android build
  - [ ] iOS build (macOS runner)
- [ ] Add steps to restore/write secrets for builds
- [ ] Ensure workflow runs on every push and pull request

- [ ] Add workflow to run all appropriate tests and create all debug builds (Android, iOS, Web if applicable)

## Web Support (after mobile is stable)
- [ ] Register Firebase Auth for Web
  - Run `flutterfire configure --platforms=web` and follow the prompts
- [ ] Update `firebase_options.dart` for web
- [ ] Test all flows on web (Chrome, Safari, Edge)
- [ ] Fix any web-specific issues (UI, permissions, etc.)

---
Add more TODOs below as needed.

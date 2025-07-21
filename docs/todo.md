# TODOs for AviationMap

## Clean Code Principles
- Follow SOLID principles, feature-based structure, and testability
- No secrets or sensitive info in code or docs
- Maintain readable, organized, and well-documented code

## Code Review & Refactoring
- [ ] Schedule regular code reviews to maintain quality
- [ ] Refactor code as needed to improve clarity and reduce technical debt

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

## Documentation TODOs
- [ ] Update docs as features evolve
- [ ] Improve onboarding notes and diagrams
- [ ] Add/expand technical guides as needed

## MapLibre Migration Review
- [ ] Review migration status and update [docs/maplibre_migration.md](maplibre_migration.md)
- [ ] Validate overlays and tile caching after migration

## FAA Chart Pipeline Review
- [ ] Periodically review FAA chart pipeline and overlay accuracy

## Web Support (after mobile is stable)
// Add web-specific TODOs here after mobile is stable

---
Add more TODOs below as needed.

# Migration Checklist: LightOre → Aviation Map

This document provides a detailed, step-by-step checklist for migrating the LightOre project to Aviation Map, ensuring architectural consistency, code quality, and maintainability.

---

## 1. Project Setup & Initialization

## App Flow
1. Implement splash screen as the initial entry point for the app.
2. Transition to map screen after splash.
- [x] Create a new Aviation Map repository and workspace.
- [x] Set up version control (Git) and configure remote origin.
- [x] Copy and rename all documentation files (docs/) from LightOre to Aviation Map, updating references and branding.
- [x] Update README.md to reflect Aviation Map’s goals, architecture, and naming.

## 2. Folder Structure & Organization
- [x] Mirror LightOre’s feature-based folder structure in Aviation Map:
    - [x] lib/features/
    - [x] lib/core/
    - [x] lib/widgets/
    - [x] lib/constants.dart
    - [x] test/
    - [x] integration_test/
- [ ] Migrate features one at a time from LightOre to Aviation Map:
    - [ ] For each feature:
        - [ ] Move the feature’s code and related files to Aviation Map.
        - [ ] Refactor imports, namespaces, and references to use `aviation_map`.
        - [ ] Remove or archive any deprecated, unused, or experimental code for that feature.
        - [ ] Test the feature in Aviation Map to ensure it works as expected before proceeding to the next feature.
        - [ ] Document migration notes and any architectural changes for each feature.

+ ## 3. Codebase Migration
+ - [ ] For each feature in LightOre:
+     - [ ] Review the feature’s code and tests for relevance and quality.
+     - [ ] Copy the Dart source files to Aviation Map, preserving feature-based organization.
+     - [ ] Rename all references, comments, and documentation from LightOre to Aviation Map.
+     - [ ] Update package names, identifiers, and namespaces in pubspec.yaml and throughout the codebase.
+     - [ ] Migrate and update all constants, theming, and configuration files.
+     - [ ] Refactor code to follow Aviation Map’s architecture and best practices.
+     - [ ] Remove any deprecated, unused, or experimental code for that feature.
+     - [ ] Test the feature in Aviation Map to ensure it works as expected.
+     - [ ] Document migration notes and any architectural changes for each feature.


## 5. Mapping & Overlays
- [ ] Migrate all map-related code, including BaseMapView, overlay logic, and tile providers.
- [ ] Update overlay URLs and configuration to Aviation Map endpoints.
- [ ] Review and refactor map abstraction layers for compatibility and extensibility.
- [ ] Migrate FAA chart tiling and hosting pipeline documentation and scripts.
- [ ] Test all overlays (sectional, IFR low, IFR high) for correct display and performance.

## 6. Testing & Quality Assurance
- [ ] Migrate all widget, unit, and integration tests; update references and mocks.
- [ ] Set up CI/CD pipelines for Aviation Map (GitHub Actions, etc.).
- [ ] Add/expand test coverage for new features and refactored code.
- [ ] Validate all tests pass and fix any failures due to migration.

## 7. Documentation & Onboarding
- [ ] Update all documentation to reference Aviation Map (architecture, features, pipeline, migration, onboarding).
- [ ] Add migration notes and rationale for major changes.
- [ ] Document any new architectural decisions or patterns adopted during migration.
- [ ] Provide onboarding instructions for new contributors.

## 8. Final Review & Cleanup
- [ ] Review the entire codebase for consistency, naming, and architectural alignment.
- [ ] Remove all LightOre branding, comments, and legacy references.
- [ ] Archive or delete the old LightOre repository if no longer needed.
- [ ] Announce migration completion to the team and update all project tracking tools.

---

## Additional Considerations
- [ ] Ensure licensing and compliance for all dependencies and data sources (MapLibre, FAA charts, etc.).
- [ ] Review and update .gitignore and other config files for Aviation Map.
- [ ] Validate mobile, web, and desktop builds for platform-specific issues.
- [ ] Plan for future enhancements and refactoring as needed.

---

_This checklist should be updated as migration progresses. Assign tasks, track status, and ensure all steps are completed for a successful transition._

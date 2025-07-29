

# AviationMap Documentation Index

Welcome! This is the central hub for all AviationMap documentation. Every major feature and technical area is documented and cross-linked here.


## Documentation Structure & Expectations

This is the canonical source for documentation structure and expectations.

- Each feature folder must have its own `index.md` for documentation.
- All major docs and feature indexes are linked below for easy access.

## Documentation Guidelines

Follow these guidelines to ensure documentation is clear, consistent, and easy to maintain:

- **What to Document:**
  - All public classes, methods, and important private logic should have Dart doc comments (`///`) explaining their purpose, usage, and any important details.
  - Each feature folder should include or reference a Markdown `index.md` with:
    - Feature overview and purpose
    - Key implementation details
    - Extensibility and testing notes
  - Complex widgets, services, and providers should have inline comments for non-obvious logic or architectural decisions.
  - All new code and refactors should include or update relevant documentation.

- **Where to Put Documentation:**
  - Use Dart doc comments (`///`) for all public APIs and important logic in code files.
  - Place feature-level documentation in the feature's `index.md` (e.g., `lib/features/map/index.md`).
  - Add architectural or project-wide docs to the `docs/` folder.
  - Update this index (`docs/index.md`) with links to new docs as they are added.

- **How to Keep Docs Up to Date:**
  - Update documentation as features evolve or new files are added.
  - Remove or revise outdated docs when refactoring or deprecating features.
  - Ensure all links in documentation point to the correct feature or doc location for consistency.

Refer to this section whenever you add or update documentation to keep the project maintainable and easy to onboard.

## Core Docs
- [README.md](../README.md): Project overview and quick start.
- [Architecture](./architecture.md): Folder structure, principles, and onboarding.
- [TODOs](./todo.md): Project roadmap and rationale.
## Features (each has its own index.md)
- [Map Feature](../lib/features/map/index.md): Map overlays, user location, extensibility.
- [Options Feature](../lib/features/options/index.md): Option bubble/grid for quick actions.
- [Splash Feature](../lib/features/splash/index.md): Splash screen implementation and tests.

## Integrations & Pipelines
- [FAA Tile Converter](../lib/features/faa_tile_converter/): FAA chart tiling pipeline, workflow, and integration steps.

## Testing & CI/CD
- [Testing](../lib/features/testing/): Unit, widget, integration tests, and CI/CD integration.

## State Management & Navigation
- [Riverpod State Management](../lib/features/riverpod/): Riverpod usage, patterns, and best practices.
- [Navigation](../lib/features/navigation/): Navigation service and route configuration.

---
Add new docs and links here as the project evolves.

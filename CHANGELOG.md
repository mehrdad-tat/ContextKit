# ContextKit Changelog

<!-- ContextKit: 0.2.7 | Updated: 2025-10-22 -->

Maintains accurate changelog following [Keep a Changelog](https://keepachangelog.com/) format.
Used by `/ctxk:proj:migrate` command to track file changes and preserve user customizations.

════════════════════════════════════════════════════════════════════════════════
║ 🤖 EXECUTION FLOW - CHANGELOG MAINTENANCE
════════════════════════════════════════════════════════════════════════════════
║
║ ## When to Add Entries
║
║ Add entries for ANY file changes in the ContextKit repository:
║ - New files created
║ - Existing files modified (content, structure, format changes)
║ - Files moved or renamed
║ - Files deleted
║ - Directory structure changes
║
║ ## Entry Format Rules
║
║ Always use full file paths from repository root:
║ - ✅ `Templates/Commands/proj/init.md`
║ - ❌ `init.md` or `proj/init.md`
║
║ Include brief description of what changed and short commit SHA:
║ - ✅ `Templates/Scripts/AutoFormat.sh` - Added Swift 6 compatibility (a1b2c3d)
║ - ❌ `Templates/Scripts/AutoFormat.sh` - Updated
║
║ Commit SHA format:
║ - Use short 7-character SHA: (a1b2c3d)
║ - Get with: git rev-parse --short HEAD
║ - Enables /migrate command to examine exact git changes
║
║ ## Migration Markers
║
║ Use [M] prefix for changes that affect existing user projects:
║ - [M] Template files that users customize (commands, agents, hooks)
║ - [M] File moves/renames that require path updates
║ - [M] File deletions that need cleanup
║ - [M] Configuration changes that affect user settings
║
║ No marker for safe changes:
║ - Documentation updates (README.md, CLAUDE.md)
║ - New optional files users can adopt gradually
║ - Repository infrastructure that doesn't affect deployed projects
║
║ ## Changelog Sections
║
║ Use standard Keep a Changelog format:
║ - Added: New files and features
║ - Changed: Modifications to existing files
║ - Deprecated: Soon-to-be removed features (with timeline)
║ - Removed: Files and features removed in this version
║ - Fixed: Bug fixes
║ - Security: Security improvements
║
║ ## Release Process
║
║ When making a release:
║ 1. Update first line: **Current Version: X.X.X** to new version number
║ 2. Change [Unreleased] to [Version] - YYYY-MM-DD
║ 3. Remove empty sections from the released version
║ 4. Create new [Unreleased] section above it with all sections showing "N/A"
║
║ Example after release:
║ **Current Version: 1.0.0**
║
║ # ContextKit Changelog
║ [system instructions...]
║

## [Unreleased]

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [0.2.7] - 2025-10-22

### Added

- `VERSION` file (44b9578) - Simple text file containing current version for quick comparison
- `Templates/Scripts/check-version.sh` (44b9578) - Fast version checker with colored output

### Changed

- `install.sh` - Copy VERSION file (44b9578) during installation
- `[M] Templates/Commands/proj/migrate.md` - Copy VERSION file (44b9578) during migration

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [0.2.7] - 2025-10-22

### Fixed

- `[M] Templates/Commands/proj/migrate.md` - Added Phase 1.5 to explicitly update global commands during migration (92040b3)
- Documentation clarity improvements for migration workflow

## [Unreleased]

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [0.2.7] - 2025-10-22

### Added

- `VERSION` file (44b9578) - Simple text file containing current version for quick comparison
- `Templates/Scripts/check-version.sh` (44b9578) - Fast version checker with colored output

### Changed

- `install.sh` - Copy VERSION file (44b9578) during installation
- `[M] Templates/Commands/proj/migrate.md` - Copy VERSION file (44b9578) during migration

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [0.2.7] - 2025-10-22

### Fixed

- `[M] Templates/Commands/proj/migrate.md` - Added Phase 1.5 to explicitly update global commands during migration (92040b3)
- Documentation clarity improvements for migration workflow

### Added

N/A

### Changed

N/A

### Deprecated

N/A

### Removed

N/A

### Fixed

N/A

### Security

N/A

## [0.2.7] - 2025-10-22

### Fixed

- `[M] Templates/Commands/version.md` - Moved from proj/ to root for correct /ctxk:version command path (72ab0c6)
- `install.sh` - Updated to copy version.md to root of ctxk commands directory (72ab0c6)

## [0.2.7] - 2025-10-22

### Added

- `Templates/Commands/proj/version.md` - New command to display ContextKit version with GitHub update checking (f3314f1)

### Changed

- `[M] Templates/Commands/proj/init.md` - Removed blocking git status confirmations, auto-continue with warnings for uncommitted changes and non-git directories (f3314f1)
- `[M] Templates/Commands/plan/1-spec.md` - Removed understanding confirmation prompt, auto-continue with summary display for faster workflow (f3314f1)
- `[M] Templates/Commands/plan/quick.md` - Removed understanding confirmation prompt, auto-continue with summary display for faster workflow (f3314f1)
- `[M] Templates/Commands/plan/4-steps.md` - Auto-resolve clarification points with reasonable defaults instead of interactive prompts (f3314f1)
- `[M] Templates/Commands/impl/release-app.md` - Auto-select version bump and auto-generate release notes for faster app releases (f3314f1)
- `[M] Templates/Commands/impl/release-package.md` - Auto-select version bump and auto-generate release notes for faster package releases (f3314f1)

## [0.2.7] - 2025-10-21

### Changed

- `[M] Templates/Scripts/CustomStatusline.sh` - Enhanced with 256-color gradient, better formatting, icons, and improved code structure (1e64d9c)

## [0.2.7] - 2025-10-21

### Fixed

- `[M] Templates/Commands/proj/init.md` - Replace hanging user prompts with AskUserQuestion tool for interactive buttons (a78a46f)
- `install.sh` - Auto-detect and update repository remote URL to ensure users always pull from correct repository (da4cbb4)

## [0.2.7] - 2025-10-17

### Added

- Quick planning workflow for smaller tasks (`/ctxk:plan:quick`)
- Developer customization sections in all command and agent templates

### Changed

- `[M] Templates/Commands/plan/2-research-tech.md` - Streamlined to single-run workflow integrating research into Tech.md
- `[M] Templates/Features/Tech.md` - Combined research and architecture phases into single template
- `[M] Templates/Commands/impl/start-working.md` - Updated to work with integrated Tech.md
- `[M] Templates/Commands/proj/init.md` - Improved submodule handling and guideline detection
- `[M] Templates/Guidelines/Swift.md` - Added logger and String-Data conversion preferences
- `[M] Templates/Commands/plan/1-spec.md` - Enhanced clarification requirement validation
- `[M] Templates/Commands/plan/3-steps.md` - Better agent usage documentation

### Removed

- `Templates/Features/Research.md` - Merged into Tech.md for streamlined workflow

## [0.1.0] - 2025-09-17

Initial release with complete ContextKit workflow system.

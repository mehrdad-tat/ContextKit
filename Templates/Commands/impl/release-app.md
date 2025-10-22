# Release App to App Store
<!-- Template Version: 4 | ContextKit: 0.2.3 | Updated: 2025-10-22 -->

> [!WARNING]
> **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: https://github.com/mehrdad-tat/ContextKit/issues

## Description
Execute iOS/macOS app release workflow with constitutional compliance validation and App Store Connect preparation

## Parameters
- `version` (required): Semantic version for release (e.g., "1.2.0")

## Execution Flow (main)

### Phase 0: Check Customization
0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Prerequisites Validation
1. **Verify project readiness**
   - Use `Glob` to check for `*.xcodeproj`: If missing, ERROR "Not an iOS/macOS app project - use /ctxk:impl:release-package for Swift packages" → EXIT
   - Use `Bash` to check git status: `git status --porcelain`
   - If uncommitted changes: ERROR "Commit all changes before release using /ctxk:impl:commit-changes" → EXIT
   - Use `Read` to verify `Context.md` exists: If missing, ERROR "Run /ctxk:proj:init to set up ContextKit first" → EXIT

### Phase 2: Change Analysis and Version Planning
2. **Analyze all changes since last release**
   - Use `Bash` to find latest release tag: `git tag --sort=-version:refname | head -1`
   - If no tags found: Set LAST_TAG to initial commit for full history analysis
   - Use `Bash` to get commit overview: `git log --oneline LAST_TAG..HEAD`
   - Use `Bash` to get complete code changes: `git diff LAST_TAG..HEAD` for full diff analysis
   - **Analyze conversation context for additional insights:**
     - Review current chat conversation for work performed and context
     - Understand the intent behind changes made during this development session
     - Cross-reference with git changes to ensure accurate release notes

3. **Auto-determine next version based on change analysis**
   Analyze code changes and automatically select version bump:
   - **MAJOR**: Breaking changes, removed features, major UX overhauls
   - **MINOR**: New features, significant improvements, new user-facing functionality
   - **PATCH**: Bug fixes, minor improvements, performance optimizations

   Display auto-selected version:
     ```
     ════════════════════════════════════════════════════════════════
     📦 AUTO-SELECTED VERSION
     ════════════════════════════════════════════════════════════════

     Current Version: [current version from project]

     Changes Found:
     [Summary of changes since last release]

     Auto-Selected Version: [suggested version] ([MAJOR/MINOR/PATCH])
     Reasoning: [why this version bump was selected]

     Proceeding with this version...
     ════════════════════════════════════════════════════════════════
     ```
   - Auto-continue with suggested version (no user prompt)

4. **Auto-generate release notes as simple prioritized list**
   Analyze changes and create sorted list following Keep a Changelog order:

   **Include in release notes (sorted by importance within each category):**
   - **Added**: New features, functionality, UI elements users can access
   - **Changed**: Behavior changes, improved features, UX enhancements
   - **Deprecated**: Features marked for future removal (rare for apps)
   - **Removed**: Deleted features or functionality
   - **Fixed**: Bug fixes that affect user experience, crashes, incorrect behavior
   - **Security**: Security improvements affecting user privacy or app security

   **Exclude from release notes:**
   - Internal refactoring, code cleanup, dependency updates
   - Developer tooling, build system changes, tests
   - Code formatting, documentation, comments

   Display generated release notes:
     ```
     ════════════════════════════════════════════════════════════════
     📝 AUTO-GENERATED RELEASE NOTES
     ════════════════════════════════════════════════════════════════

     [Generated release notes as simple bullet list organized by category]

     Using these release notes for App Store submission...
     ════════════════════════════════════════════════════════════════
     ```
   - Auto-continue with generated notes (no user prompt)
   - Developer can manually edit release notes in App Store Connect if needed

### Phase 3: Version Management and Git Operations
5. **Update project version**
   - Use `Read` to examine project.pbxproj file structure
   - Use `Edit` to update MARKETING_VERSION to provided version parameter
   - Keep CURRENT_PROJECT_VERSION at "1" (Xcode Cloud manages build numbers)
   - Verify version consistency across Debug and Release configurations

6. **Execute git workflow**
   - Determine appropriate commit message:
     - If only MARKETING_VERSION changed: "Bump version to [version]"
     - If both MARKETING_VERSION and CURRENT_PROJECT_VERSION changed: "Bump version and build number to [version]"
   - Use `Bash` to commit version changes with appropriate message
   - Use `Bash` to create release tag: `git tag [version]`
   - Prepare for user to push: `git push && git push --tags`
   - Tag push will trigger Xcode Cloud build automatically

### Phase 4: App Store Connect Preparation
7. **Display What's New text for App Store Connect**
   - Use `Read` to get App Store URL from Context.md configuration
   - Extract Apple ID from App Store URL (pattern: `/id(\d+)`)
   - Present final release notes as formatted "What's New" text
   - Show copy-pasteable format for App Store Connect
   - Provide direct App Store Connect URL using extracted Apple ID

### Phase 5: Completion and Next Steps
8. **Finalize and provide guidance**
   - Summarize constitutional compliance results
   - List files created and modified
   - Provide clear next steps for user:
     - Push commits and tags to trigger Xcode Cloud
     - Monitor build progress in Xcode Cloud dashboard
     - Submit for review once build completes
   - Reference Guidelines/Release.md for detailed App Store Connect procedures

9. **Return SUCCESS** with release prepared and ready for user to push

## Success Message

### Release Prepared
```
🚀 Release [Version] prepared for [ProjectName]

📋 Files modified:
   ✓ project.pbxproj - Version updated to [version]
   ✓ Git tag [version] created and ready for push


📱 What's New for App Store Connect:
═══════════════════════════════════════════
– [Generated release note 1]
– [Generated release note 2]
– [Generated release note 3]
═══════════════════════════════════════════

🔗 App Store Connect: https://appstoreconnect.apple.com/apps/[APP_ID]/appstore

🚀 Next steps:
   1. Push commits and tags: git push && git push --tags
   2. Monitor Xcode Cloud dashboard for build progress
   3. Copy What's New text above and paste into App Store Connect
   4. Submit for review once build completes
```

## Error Conditions
- "Not an app project" → Use /ctxk:impl:release-package for Swift packages → EXIT
- "Uncommitted changes" → Commit all changes first using /ctxk:impl:commit-changes → EXIT
- "No Context.md found" → Run /ctxk:proj:init to set up ContextKit first → EXIT
- "Version conflicts" → Resolve git tag conflicts or project version inconsistencies
- "No meaningful changes" → Consider if maintenance release is necessary

## Validation Gates
- [ ] Project is iOS/macOS app with *.xcodeproj file?
- [ ] Git repository is clean with all changes committed?
- [ ] User-facing changes identified and documented?
- [ ] Version number confirmed by user?
- [ ] Release notes approved or skipped by user?
- [ ] Project version updated correctly in all configurations?
- [ ] Git tag created and ready for push?
- [ ] Next steps provided for user (push, monitor, submit)?

## Integration Points
- **Commands**: Integrates with /ctxk:impl:commit-changes and /ctxk:impl:start-working
- **Guidelines**: References Guidelines/Release.md for detailed App Store Connect procedures

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

<!-- Add project-specific guidance here -->

## Additional Examples

<!-- Add examples specific to your project here -->

## Override Behaviors

<!-- Document any project-specific overrides here -->
# Release Swift Package

<!-- Template Version: 4 | ContextKit: 0.2.9 | Updated: 2025-10-22 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: https://github.com/mehrdad-tat/ContextKit/issues

## Description

Execute Swift Package release workflow with version management, release notes generation, and GitHub integration.

## Parameters

**Usage**: `/ctxk:impl:release-package [version]`

- `version` (optional): Specific version like "1.2.0" or "major"/"minor"/"patch" for semantic bumping

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Prerequisites Validation

1. **Verify Swift Package Project**

   ```bash
   ls Package.swift || echo "❌ Not a Swift package project"
   ```

   - If Package.swift not found: ERROR "This command is for Swift packages. Use /ctxk:impl:release-app for iOS/macOS apps."

2. **Check Git Repository Status**

   ```bash
   git status --porcelain
   ```

   - If uncommitted changes exist: ERROR "Uncommitted changes detected. Commit all changes before release."
   - If not in git repository: ERROR "Git repository required for package releases."

3. **Validate Package Builds and Tests**

   - Use `Task` tool to launch `build-project` agent: "Execute release build validation"
   - Use `Task` tool to launch `run-test-suite` agent: "Execute complete test suite for release validation"
   - If build fails: ERROR "Package must build successfully before release."
   - If tests fail: ERROR "All tests must pass before release."

4. **Check GitHub CLI Access**
   ```bash
   gh auth status || echo "❌ GitHub CLI not authenticated"
   ```
   - If not authenticated: ERROR "Run 'gh auth login' to authenticate with GitHub."

### Phase 2: Version Management

5. **Extract Package Information**

   - Use `Read` tool to read Package.swift: `Read Package.swift`
   - Parse package name from manifest (extract from `name:` field)
   - Determine repository URL from git remote: `git remote get-url origin`

6. **Determine Current Version and Get User Input**

   ```bash
   git tag --list --sort=-version:refname | head -1
   ```

   - Extract current version from latest git tag (e.g., "v1.4.2" → "1.4.2")
   - If no tags exist: current version is "none" (first release)

7. **Comprehensive Change Analysis Since Last Release**
   **Step 7a: Commit Message Analysis**

   ```bash
   git log [LAST_TAG]..HEAD --oneline
   ```

   - Count commits since last release
   - Look for conventional commit patterns (feat:, fix:, BREAKING:)

   **Step 7b: File Change Analysis**

   ```bash
   git diff --name-status [LAST_TAG]..HEAD
   ```

   - Identify added (A), modified (M), deleted (D), renamed (R) files
   - Categorize files by type: Sources/, Tests/, Package.swift, README.md, etc.

   **Step 7c: Code Diff Analysis**

   ```bash
   git diff [LAST_TAG]..HEAD
   ```

   - Analyze actual code changes line by line
   - Focus on public API changes in Sources/ directory
   - Examine Package.swift for dependency changes
   - Check README.md and documentation updates

8. **Auto-Select Version Number**

   - Analyze changes from step 7 to auto-select version bump type:

     - **MAJOR**: If breaking changes detected (public API removals, signature changes)
     - **MINOR**: If new features added (new public APIs, significant functionality)
     - **PATCH**: If only bug fixes, documentation, internal improvements, performance optimizations

   - Display auto-selected version:

     ```
     ════════════════════════════════════════════════════════════════
     📦 AUTO-SELECTED VERSION
     ════════════════════════════════════════════════════════════════

     Package: [package name]
     Repository: [repository URL]
     Current Version: [current version]
     Commits Since Last Release: [count]

     Auto-Selected Bump: [MAJOR/MINOR/PATCH]
     New Version: [calculated version]
     Reasoning: [why this version bump was selected based on changes]

     Proceeding with this version...
     ════════════════════════════════════════════════════════════════
     ```

   - Auto-continue with selected version (no user prompt)

### Phase 3: Release Notes Generation

9. **Analyze Changes and Generate Release Notes**
   **Step 9a: Review Conversation Context**

   - Analyze current chat conversation for work performed and context
   - Understand the intent behind changes made during this development session
   - Cross-reference with git changes to ensure accuracy

   **Step 9b: Comprehensive Change Analysis**
   Use the comprehensive change analysis from step 7 to systematically review each change:

   **For each modified file, examine the actual code changes and categorize:**

   **INCLUDE in release notes:**
   ✅ New public APIs or features users can access
   ✅ Bug fixes that affect user experience
   ✅ Performance improvements users will notice
   ✅ Breaking changes requiring user action
   ✅ New dependencies or platform requirements
   ✅ Security improvements
   ✅ Improved error messages or error handling
   ✅ Documentation updates that help users

   **EXCLUDE from release notes:**
   ❌ Internal refactoring with no user impact
   ❌ Test-only changes (unless they indicate new features being tested)
   ❌ Code formatting or style changes
   ❌ Internal helper methods or private implementations
   ❌ Development tooling changes (unless affecting package consumers)
   ❌ Commit message fixes or typos in non-user-facing text

   **Step 9c: Generate Simple Release Notes List**

   - Create a simple list of bullet points (no file created)
   - Sort by Keep A Changelog order: Added, Changed, Deprecated, Removed, Fixed, Security
   - Within each type, sort by importance (most impactful first)
   - Start each point with the action word: "Added", "Fixed", "Changed", etc.
   - Write user-focused descriptions explaining the benefit
   - If no meaningful user-facing changes found: Ask "Create maintenance release anyway?"

10. **Auto-Generate Release Notes**

    - Display generated release notes:

      ```
      ════════════════════════════════════════════════════════════════
      📝 AUTO-GENERATED RELEASE NOTES
      ════════════════════════════════════════════════════════════════

      [Generated release notes as simple bullet list organized by category]

      Using these release notes for GitHub release...
      ════════════════════════════════════════════════════════════════
      ```

    - Auto-continue with generated notes (no user prompt)
    - Developer can manually edit release on GitHub if needed

### Phase 4: Build Verification

11. **Verify Package Builds Successfully**
    - Use `Task` tool to launch `build-project` agent
    - If build fails: ERROR "Fix build errors before release" → EXIT

### Phase 5: GitHub Release Creation

12. **Create Git Tag**

    ```bash
    git tag -a "v[NEW_VERSION]" -m "Release [NEW_VERSION]"
    git push origin "v[NEW_VERSION]"
    ```

13. **Create GitHub Release**

    - Use the confirmed release notes from step 10
    - Format as simple markdown list for GitHub release body

    ```bash
    gh release create "v[NEW_VERSION]" --title "[PACKAGE_NAME] [NEW_VERSION]" --notes "[FORMATTED_RELEASE_NOTES]"
    ```

14. **Verify Release Creation**
    ```bash
    gh release view "v[NEW_VERSION]" --web
    ```
    - Provide direct GitHub release URL for user verification
    - Confirm release appears on GitHub with correct notes

### Phase 6: Success Confirmation

16. **Display Success Message** (see Success Message section below)

## Error Conditions

- **"Package.swift not found"** → This command is for Swift packages. Use `/ctxk:impl:release-app` for iOS/macOS apps
- **"Uncommitted changes"** → Commit all changes with `git add . && git commit -m "message"` before release
- **"Build failed"** → Fix compilation errors before attempting release
- **"Tests failed"** → All tests must pass before release. Fix failing tests first
- **"GitHub CLI not authenticated"** → Run `gh auth login` to authenticate with GitHub
- **"Git tag creation failed"** → Check if tag already exists or repository permissions
- **"GitHub release creation failed"** → Verify repository access and GitHub authentication

## Validation Gates

- [ ] Swift package project confirmed (Package.swift exists)?
- [ ] Git repository is clean (no uncommitted changes)?
- [ ] Package builds successfully in release configuration?
- [ ] All tests pass?
- [ ] GitHub CLI is authenticated and has repository access?
- [ ] User confirmed new version number?
- [ ] User reviewed and approved generated release notes?
- [ ] Git tag created and pushed successfully?
- [ ] GitHub release created with release notes?

## Success Message

```
🎉 Swift Package [PACKAGE_NAME] [NEW_VERSION] released successfully!

📦 Release Details:
   ✓ Version: [CURRENT_VERSION] → [NEW_VERSION]
   ✓ Git tag: v[NEW_VERSION] created and pushed
   ✓ GitHub release: Created with release notes

🔗 View Release:
   📋 [GITHUB_RELEASE_URL]
```

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

<!-- Add extra release steps like updating documentation sites, notifying dependent projects, custom versioning -->

## Additional Examples

<!-- Add examples of release workflows specific to your package types or dependencies -->

## Override Behaviors

<!-- Document any project-specific requirement overrides here -->

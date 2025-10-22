# Display ContextKit Version
<!-- Template Version: 0 | ContextKit: 0.2.6 | Updated: 2025-10-22 -->

> [!WARNING]
> **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: https://github.com/mehrdad-tat/ContextKit/issues

## Description

Display current ContextKit version installed in this project and available updates.

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Version Detection

1. **Check Latest Version on GitHub**
   ```bash
   echo "🔍 Checking latest version on GitHub..."
   LATEST_GITHUB=$(curl -s https://api.github.com/repos/mehrdad-tat/ContextKit/releases/latest | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')

   if [ -z "$LATEST_GITHUB" ]; then
       echo "⚠️ Could not check GitHub for latest version (no internet or API limit)"
       LATEST_GITHUB="unknown"
   else
       echo "📦 Latest on GitHub: v$LATEST_GITHUB"
   fi
   ```

2. **Check Global ContextKit Installation**
   ```bash
   if [ -f ~/.ContextKit/CHANGELOG.md ]; then
       GLOBAL_VERSION=$(sed -n '2s/.*ContextKit: \([0-9.]*\).*/\1/p' ~/.ContextKit/CHANGELOG.md)
       echo "💾 Installed Globally: v$GLOBAL_VERSION"
   else
       echo "❌ ContextKit not installed globally"
       echo "   Run: curl -fsSL https://raw.githubusercontent.com/mehrdad-tat/ContextKit/main/install.sh | sh"
       GLOBAL_VERSION="not-installed"
   fi
   ```

3. **Check Project ContextKit Version**
   - Use `Glob` to check if Context.md exists: `Glob . Context.md`
   - If Context.md found:
     - Use `Bash` to detect project version from any template file:
       ```bash
       if [ -f .claude/commands/ctxk/plan/1-spec.md ]; then
           PROJECT_VERSION=$(sed -n '2s/.*ContextKit: \([0-9.]*\).*/\1/p' .claude/commands/ctxk/plan/1-spec.md)
           echo "📦 Project ContextKit: v$PROJECT_VERSION"
       else
           echo "⚠️  Project not initialized with ContextKit"
           echo "   Run: /ctxk:proj:init"
       fi
       ```
   - If Context.md not found:
     - Display message: "⚠️ Not a ContextKit project (Context.md missing)"

4. **Compare Versions and Display Update Status**
   ```bash
   # Function to compare semantic versions
   version_gt() {
       test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"
   }

   # Check if GitHub update available
   if [ "$LATEST_GITHUB" != "unknown" ] && [ "$GLOBAL_VERSION" != "not-installed" ]; then
       if version_gt "$LATEST_GITHUB" "$GLOBAL_VERSION"; then
           echo ""
           echo "════════════════════════════════════════════════════════════════"
           echo "🆕 NEW VERSION AVAILABLE ON GITHUB"
           echo "════════════════════════════════════════════════════════════════"
           echo ""
           echo "Installed:        v$GLOBAL_VERSION"
           echo "Latest on GitHub: v$LATEST_GITHUB"
           echo ""
           echo "Update your global installation:"
           echo "curl -fsSL https://raw.githubusercontent.com/mehrdad-tat/ContextKit/main/install.sh | sh"
           echo ""
           echo "════════════════════════════════════════════════════════════════"
       fi
   fi

   # Check if project needs migration
   if [ "$PROJECT_VERSION" != "not-initialized" ] && [ "$GLOBAL_VERSION" != "not-installed" ]; then
       if version_gt "$GLOBAL_VERSION" "$PROJECT_VERSION"; then
           echo ""
           echo "════════════════════════════════════════════════════════════════"
           echo "🔄 PROJECT UPDATE AVAILABLE"
           echo "════════════════════════════════════════════════════════════════"
           echo ""
           echo "Project Version:  v$PROJECT_VERSION"
           echo "Global Version:   v$GLOBAL_VERSION"
           echo ""
           echo "Update your project templates:"
           echo "/ctxk:proj:migrate"
           echo ""
           echo "════════════════════════════════════════════════════════════════"
       fi
   fi

   # Show success if everything is up to date
   if [ "$LATEST_GITHUB" != "unknown" ] && [ "$GLOBAL_VERSION" != "not-installed" ] && [ "$PROJECT_VERSION" != "not-initialized" ]; then
       if [ "$LATEST_GITHUB" = "$GLOBAL_VERSION" ] && [ "$GLOBAL_VERSION" = "$PROJECT_VERSION" ]; then
           echo ""
           echo "✅ Everything is up to date!"
           echo ""
       fi
   fi
   ```

5. **Display Additional Information**
   ```
   📚 Resources:
   • Documentation: https://github.com/mehrdad-tat/ContextKit
   • Changelog: https://github.com/mehrdad-tat/ContextKit/blob/main/CHANGELOG.md
   • Report Issues: https://github.com/mehrdad-tat/ContextKit/issues
   ```

## Success Messages

### Up to Date
```
🎉 ContextKit Version Information

✅ Global ContextKit: v0.2.6
📦 Project ContextKit: v0.2.6

✅ ContextKit is up to date!

📚 Resources:
• Documentation: https://github.com/mehrdad-tat/ContextKit
• Changelog: https://github.com/mehrdad-tat/ContextKit/blob/main/CHANGELOG.md
• Report Issues: https://github.com/mehrdad-tat/ContextKit/issues
```

### Update Available
```
🎉 ContextKit Version Information

✅ Global ContextKit: v0.2.6
📦 Project ContextKit: v0.2.6

════════════════════════════════════════════════════════════════
🔄 UPDATE AVAILABLE
════════════════════════════════════════════════════════════════

Your project is using an older ContextKit version.

Project Version:  v0.2.6
Latest Available: v0.2.6

Run /ctxk:proj:migrate to update your project templates.

════════════════════════════════════════════════════════════════

📚 Resources:
• Documentation: https://github.com/mehrdad-tat/ContextKit
• Changelog: https://github.com/mehrdad-tat/ContextKit/blob/main/CHANGELOG.md
• Report Issues: https://github.com/mehrdad-tat/ContextKit/issues
```

## Error Conditions

- **"ContextKit not installed globally"** → Run global installation script
- **"Not a ContextKit project"** → Run `/ctxk:proj:init` to initialize
- **"Project not initialized"** → Context.md exists but commands not installed

## Validation Gates

- Global ContextKit version detected successfully?
- Project ContextKit version detected if project initialized?
- Version comparison accurate?
- Update suggestion provided when applicable?

## Integration Points

- **Global Installation**: Uses ~/.ContextKit/CHANGELOG.md for version detection
- **Project Detection**: Uses template version headers for project version
- **Migration Command**: Suggests /ctxk:proj:migrate when update available

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Additional Version Information

<!-- Add extra version checks like project dependencies, related tools, etc. -->

## Custom Update Workflows

<!-- Document project-specific update procedures or requirements -->

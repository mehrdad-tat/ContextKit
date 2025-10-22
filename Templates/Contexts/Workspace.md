# Workspace Context Template
<!-- Template Version: 2 | ContextKit: 0.2.6 | Updated: 2025-10-02 -->

## Description
Workspace-level Context.md template providing workspace-specific configuration, client/company requirements, technology standards, and team workflow overrides for multi-project environments.

════════════════════════════════════════════════════════════════════════════════
║ 🤖 EXECUTION FLOW - WORKSPACE CONTEXT GENERATION
════════════════════════════════════════════════════════════════════════════════
║
║ ## Execution Flow (main)
║ 
║ ### Phase 0: Check Customization
║ 
║ 0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
║    - Use `Grep` tool to find the start of the section
║    - Read everything below that line contained in this document til the end of the file
║    - Make sure to consider what was said there with high priority
║    - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"
║
║ ### Phase 1: User Configuration Collection
║
║ **NOTE**: User preferences are collected by init-workspace.md command before template execution.
║ The following user preferences are available for use during context generation:
║ - Workspace type (Personal/Client/Enterprise/Open Source)
║ - Company name and description (if applicable)
║ - Coding standards preference (indentation)
║ - Development principle overrides (if any)
║
║ ### Phase 2: Complete Repository Discovery & Deep Analysis
║
║ 1. **Recursive Repository Discovery**
║    - Use `Bash` command to find ALL git repositories: `find . -name ".git" -type d`
║    - For each .git directory found, identify the repository root
║    - Use `Read` tool to examine `.gitmodules` files to understand submodule structure
║    - Create complete hierarchical map of all repositories and their relationships
║    - CRITICAL: Every single repository must be analyzed individually, including nested repos
║
║ 2. **Deep Project Analysis for Each Repository**
║    For EVERY repository found, perform detailed analysis:
║
║    **A. Repository Metadata Analysis**
║    - Use `Read` tool on README.md, README.txt, or similar files to understand project purpose
║    - Use `Read` tool on LICENSE files to detect open-source vs proprietary
║    - Use `Bash` to check git remote origins to understand repository relationships
║    - Use `Bash` to check if repository has submodules: `ls -la .gitmodules 2>/dev/null`
║
║    **B. Technology Stack Detection**
║    - **Swift Projects**:
║      - Use `Glob` for Package.swift, *.xcodeproj, *.xcworkspace files
║      - Use `Read` on Package.swift to detect dependencies, platforms, swift-tools-version
║      - Check for SwiftUI usage: `Grep "import SwiftUI" --glob "*.swift"`
║      - Check for UIKit usage: `Grep "import UIKit" --glob "*.swift"`
║      - Detect if it's Vapor server: `Grep "import Vapor" --glob "*.swift"`
║      - Detect if it's DocC documentation: `Glob` for *.docc folders
║    - **JavaScript/Node Projects**:
║      - Use `Glob` for package.json, yarn.lock, npm-shrinkwrap.json
║      - Use `Read` on package.json to detect framework (React, Vue, etc.) and dependencies
║    - **Python Projects**:
║      - Use `Glob` for requirements.txt, pyproject.toml, setup.py, Pipfile
║      - Use `Read` to detect framework (Django, Flask, etc.)
║    - **Other Technologies**: Extend detection as needed (Rust, Go, etc.)
║
║    **C. Project Purpose Detection**
║    - Analyze README content to understand what the project does
║    - Look for app descriptions, library purposes, tool functionality
║    - Check for App Store links, package registry references, deployment information
║    - Examine package.json/Package.swift names and descriptions
║    - Look for localization files to understand target markets: `Glob "**/Localizable.xcstrings" "**/Localizable.strings"`
║    - Check for app icons, marketing materials, documentation sites
║
║    **D. Project Structure Analysis**
║    - Identify if it's an app (has main executable), library/package, server, documentation, tool
║    - Detect multi-platform support from build configurations
║    - Understand project relationships (does it depend on other workspace projects?)
║
║ 3. **Code Style & Standards Detection**
║    ONLY report what is ACTUALLY FOUND, never guess or assume:
║    - Use `Read` on formatter config files: .swift-format, .swiftformat, .prettierrc, .eslintrc
║    - Use `Bash` to detect actual indentation in source files: `head -20 [source-file] | sed 's/\t/<TAB>/g'`
║    - Use `Read` on .editorconfig files if present
║    - Check git hooks for automated formatting: `ls -la .git/hooks/`
║    - Look for consistent patterns across multiple files, don't assume defaults
║
║ 4. **ContextKit Setup Status Analysis**
║    - For each repository: Use `Glob` to check for Context.md, .claude/commands/ctxk, .claude/agents/ctxk
║    - Count enabled vs not-setup repositories
║    - Note which repositories are ready for ContextKit vs need initialization
║
║ 5. **Dependency & Version Analysis**
║    - For Swift: Parse Package.swift dependencies and version constraints
║    - For Node: Parse package.json dependencies and versions
║    - Document common dependencies used across projects
║    - Identify shared libraries/frameworks within the workspace
║    - Note version consistency or conflicts across projects
║
║ ### Phase 3: Context Generation & Completion
║
║ 6. **Generate Hierarchical Repository Structure**
║    - Create complete hierarchical view of all repositories found
║    - Show parent-child relationships, submodules, nested projects
║    - Include for each repository: name, type, purpose, tech stack, ContextKit status
║    - Use indentation to show nesting levels and relationships
║    - Format: Repository Name (Type) - Purpose - Tech Stack - Status
║
║ 7. **Generate Technology Findings Summary**
║     - Document ONLY what was actually detected, not assumptions
║     - List common dependencies and their versions across projects
║     - Report actual code style findings from formatter configs and source analysis
║     - Identify shared frameworks and architectural patterns found in code
║     - Note version consistency or conflicts discovered
║
║ 8. **Generate Workspace Context Content**
║     - Use `Edit` tool to replace this entire template with new structure focused on:
║       A) Hierarchical Repository Structure (primary focus)
║       B) Technology Findings (actual detected patterns and dependencies)
║       C) Workspace Configuration (user preferences collected by init-workspace.md)
║     - Remove or minimize sections not relevant to detected repositories
║     - CRITICAL: Only include Communication & Collaboration if relevant to workspace type
║
║ 9. **Final Validation**
║     - Verify all information is based on actual analysis, not assumptions
║     - Ensure hierarchical repository structure is complete and accurate
║     - Confirm technology findings are backed by file analysis
║     - Check that no placeholder content remains
║
║ 10. **COMPLETION**
║     - Use `Edit` tool to remove this entire boxed system instructions section
║     - Leave only the clean workspace context content for team use
║     - Display repository-specific setup recommendations based on analysis
║
║ ## Success Criteria
║ - Complete hierarchical repository structure with purpose and tech stack for each
║ - Technology findings based on actual file analysis, not assumptions
║ - All information backed by specific file reads and tool executions
║ - Repository relationships and dependencies clearly mapped
║ - ContextKit setup status accurate for all repositories
║ - System instructions completely removed from final Context.md
║
════════════════════════════════════════════════════════════════════════════════

# Workspace: [AI Detects Workspace Name Based on Analysis]

## Workspace Identity

**Type**: [User Selected via init-workspace.md: Personal/Indie/Client/Enterprise/Open Source]

**Purpose**: [User Input via init-workspace.md - Brief Description]

**Client/Company**: [User Input via init-workspace.md or N/A for indie work]

## Repository Structure

**Hierarchical Repository Map**:

[AI Generated Hierarchical Structure - Example Format:]
```
📁 Workspace Root
├── 📦 Package-Name (Swift Package) - [Purpose from README] - Swift/Foundation - Status
├── 📱 App-Name (iOS App) - [Purpose from README] - Swift/SwiftUI - Status
│   ├── 📦 Submodule-SDK (Swift Package) - [Purpose] - Swift/Foundation - Status
│   └── 🖥️ Server (Vapor Server) - [Purpose] - Swift/Vapor - Status
├── 📚 Docs (Documentation) - [Purpose] - DocC - Status
└── 🔧 Tool-Name (Command Line Tool) - [Purpose] - Swift/ArgumentParser - Status
```

**Repository Analysis Summary**:
- **Total Repositories**: [X discovered] ([Y with ContextKit], [Z without])
- **Repository Types**: [X apps, Y packages, Z servers, etc. - based on actual analysis]
- **Technology Distribution**: [Languages and frameworks found with counts]

## Technology Findings

**Languages & Frameworks** (detected from analysis):
- **Swift**: [Version from swift-tools-version] - [X projects]
  - SwiftUI: [X projects use import SwiftUI]
  - UIKit: [X projects use import UIKit]
  - Vapor: [X projects use import Vapor]
- **[Other Languages]**: [Versions detected] - [X projects]

**Common Dependencies** (found in Package.swift/package.json files):
[AI Lists actual dependencies found with versions, e.g.:]
- HandySwift: [version range] - Used in [X] projects
- SwiftUI: Native framework - Used in [X] projects
- [Other dependencies found]

**Code Style Findings** (from actual file analysis):
[AI Reports only what was actually detected:]
- **Formatter Configurations**: [List .swift-format, .swiftformat files found]
- **Indentation Patterns**: [Report actual findings from source file analysis]
- **Naming Conventions**: [Report consistent patterns found across projects]
- **Editor Configurations**: [List .editorconfig files found]

**Platform Targets** (detected from build configurations):
[AI Lists platforms found in Package.swift/Xcode projects]

**Development Tools Detected**:
- **Package Managers**: [Swift Package Manager, npm, etc. - based on files found]
- **Build Systems**: [Xcode, SPM, etc. - based on project structure]
- **Documentation**: [DocC, etc. - based on .docc folders found]

## Workspace Configuration

**Coding Standards**:
- **Indentation**: [User Selected via init-workspace.md based on findings or override]
- **Code Formatting**: [Based on detected formatter configs and user preference]

**Development Principles**:
- ✅ Accessibility-first design
- ✅ Privacy by design
- ✅ Localizability from day one
- ✅ Code maintainability
- ✅ Platform-appropriate UX

**Principle Overrides**: [User specified overrides via init-workspace.md with justifications, or "None"]

[CONDITIONAL SECTION - Only for Client/Enterprise workspaces:]
## Communication & Collaboration

**Client Requirements**: [Client-specific requirements if applicable]

**Team Standards**: [Enterprise-specific standards if applicable]

## ContextKit Integration

**Setup Status**: [X] of [Y] repositories have ContextKit enabled

**Next Steps**:
- Navigate to individual project directories to run `/ctxk:proj:init`
- Each project will inherit these workspace standards
- Individual projects can override workspace settings with justification

**Configuration Hierarchy**: Global ContextKit Defaults → **This Workspace** → Individual Projects

---
*Generated by ContextKit via repository analysis. Manual edits are preserved during updates.*
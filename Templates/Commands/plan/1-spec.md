# Create Feature Specification
<!-- Template Version: 16 | ContextKit: 0.2.6 | Updated: 2025-10-22 -->

> [!WARNING]
> **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Initialize feature specification by validating setup, confirming feature naming, copying specification template, and executing template workflow with progress tracking.

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Setup Validation & Prerequisites

1. **Check Project Setup**
   - Use `Glob` tool to verify Context.md exists: `Glob . Context.md`
   - If Context.md missing:

     ```
     ❌ ContextKit not initialized in this project!

     Run /ctxk:proj:init first to setup ContextKit in this project.
     This command requires project context to detect tech stack and apply
     appropriate constitutional principles.
     ```

     → END (exit with error)

### Phase 2: Interactive Feature Definition & Naming

2. **Check Git Status (Auto-Continue with Warning)**

   ```bash
   git status --porcelain || echo "⚠️ Git not available - continuing without version control"
   ```

   - If uncommitted changes exist:
     - Display warning in chat and auto-continue:

       ```
       ═══════════════════════════════════════════════════
       ⚠️ WARNING - Uncommitted Changes Detected
       ═══════════════════════════════════════════════════

       You have uncommitted changes in your working directory.
       Recommendation: Commit these before creating a feature branch.

       Run: git add . && git commit -m "Your commit message"

       Auto-continuing anyway...
       ═══════════════════════════════════════════════════
       ```

     - Continue automatically (no user prompt)

3. **Get Feature or App Description from User**
   - Ask user for feature/app description via text input
   - Wait for user input
   - **CRITICAL**: Store description exactly verbatim for specification Input field - do NOT summarize or paraphrase
   - Continue with description-based processing

4. **Auto-Detect Components (Default: Root Only)**
   - Use `Bash` tool to check for multi-component structure:

     ```bash
     find . -maxdepth 3 -name ".git" -type d
     ```

   - Use `Bash` tool to check for submodules:

     ```bash
     ls -la .gitmodules 2>/dev/null || echo "No .gitmodules file found"
     ```

   - **Always default to "root only"** (most common case)
   - If multiple components detected:
     - Display info message:

       ```
       ℹ️ Multi-component project detected.
       Defaulting to: Root repository only

       Discovered components:
       • [List of components]

       Note: Feature branch will be created in root only.
       Use manual git commands to create branches in other components if needed.
       ```

   - Store affected components: ["root"]

5. **Generate Names**
   - Parse user description for key concepts
   - Create PascalCase name (e.g., "user authentication" → "UserAuthentication", "recipe app" → "RecipeApp")
   - Create kebab-case name for branch suffix (e.g., "user-authentication", "recipe-app")
   - Focus on user value, not implementation details

6. **Auto-Generate and Confirm Names**
   - Display generated names to user in a summary:

     ```
     ℹ️ Generated names:
        • Feature folder: [XXX]-[PascalCaseName]
        • Git branch: feature/[XXX]-[kebab-case-name]

     Auto-accepting generated names...
     ```

   - Store confirmed names for subsequent steps (no user prompt)

7. **Generate Understanding Summary (Auto-Continue)**
   - Based on user's original description, generate CONCISE understanding summary
   - Display summary in chat:

     ```
     ═══════════════════════════════════════════════════
     📋 UNDERSTANDING SUMMARY
     ═══════════════════════════════════════════════════

     My understanding of the feature:

     [1-2 paragraph summary of what the feature does and why]

     IN SCOPE ✅
     • [Key item 1 that will be addressed]
     • [Key item 2 that will be addressed]
     • [Key item 3 that will be addressed]
     (3-5 items maximum - keep concise for quick review)

     OUT OF SCOPE ❌
     • [Related item 1 that won't be included]
     • [Related item 2 that won't be included]
     • [Related item 3 that won't be included]
     (3-5 items maximum - clear boundaries)

     KEY EDGE CASES 🔍
     • [Important edge case 1 to consider]
     • [Important edge case 2 to consider]
     (2-3 items maximum - most critical ones)

     Proceeding with specification creation...
     ═══════════════════════════════════════════════════
     ```

   - **CRITICAL**: Keep this concise for quick developer review
   - Auto-continue without confirmation (no user prompt)
   - **Store understanding** for Spec.md generation (full detailed spec will be created from this)
   - Developer can review and edit Spec.md after it's created if understanding is incorrect

### Phase 3: Template Setup & Execution

8. **Generate Sequential Feature Number & Create Workspace**

   ```bash
   # Find next sequential number by counting existing feature directories
   NEXT_NUM=$(printf "%03d" $(($(ls -1d Context/Features/???-* 2>/dev/null | wc -l) + 1)))
   NUMBERED_FEATURE_NAME="${NEXT_NUM}-[ConfirmedFeatureName]"
   mkdir -p Context/Features/${NUMBERED_FEATURE_NAME}
   echo "✅ Created feature directory: Context/Features/${NUMBERED_FEATURE_NAME}"
   ```

   - Store the numbered directory name for use in subsequent steps and success message

9. **Copy Feature Template**

   ```bash
   cp ~/.ContextKit/Templates/Features/Spec.md Context/Features/[numbered-feature-directory]/Spec.md
   echo "✅ Copied specification template"
   ```

10. **Create Git Branch in Root Directory**

    ```bash
    git checkout -b feature/${NEXT_NUM}-[auto-generated-kebab-case-name] || echo "⚠️ Git branch creation failed - continuing without branch"
    echo "✅ Created git branch: feature/${NEXT_NUM}-[auto-generated-kebab-case-name]"
    ```

    - Note: Branch created in root repository only
    - For multi-component projects: Use manual git commands in other components if needed

11. **Execute Specification Template**
    - Use `Read` tool to read the copied Spec.md: `Read Context/Features/[numbered-feature-directory]/Spec.md`
    - Follow the **system instructions** section (boxed area) step by step
    - The template contains specification generation logic and progress tracking
    - Use tools (`Read`, `Edit`) as directed by the template instructions
    - **Template execution**: The copied Spec.md handles all context reading, guidelines loading, constitutional validation, and content generation
    - **IMPORTANT**: Use confirmed understanding from Step 7 to inform spec generation
    - **Progress tracking**: User can see checkboxes being completed in the copied file

12. **Auto-Resolve Clarification Points with Reasonable Defaults**
    - Use `Grep` tool to find clarification markers in final Spec.md: `Grep "🚨 \\[NEEDS CLARIFICATION:" [numbered-feature-directory]/Spec.md`
    - If clarification points found:
      - Parse each clarification point to extract the specific question and line context
      - **FOR EACH CLARIFICATION**:
        - Analyze the extracted clarification question
        - Generate most reasonable answer based on:
          - Project Context.md understanding
          - Industry best practices
          - Constitutional principles
          - Common user expectations
        - Use `Edit` tool to replace 🚨 marker with auto-resolved answer:

          ```
          OLD: 🚨 [NEEDS CLARIFICATION: Should users see archived items?]
          NEW: ✅ [AUTO-RESOLVED: Users can view archived items in a separate "Archive" section with read-only access. This follows common UX patterns and maintains data transparency.]
          ```

        - Log resolution in chat:

          ```
          ℹ️ Auto-resolved clarification:
             Question: [extracted question]
             Answer: [reasonable default based on context]
          ```

      - After all clarifications resolved:

        ```
        ✅ Auto-resolved [count] clarification points with reasonable defaults.
        Review Spec.md and adjust answers if needed before proceeding.
        ```

13. **Display Success Message** (see Success Messages section)

## Error Conditions

- **"Context.md not found"** → User must run `/ctxk:proj:init` to initialize ContextKit
- **"Feature template not found"** → Ensure template files are available
- **"Directory creation failed"** → Check permissions and disk space
- **"Template copy failed"** → Check file permissions
- **"Template execution failed"** → Verify Spec.md template contains system instructions section

## Validation Gates

- Project Context.md exists (ContextKit project setup complete)?
- Feature names auto-generated and displayed to user?
- Understanding summary presented in chat and confirmed by user?
- Feature workspace directory created successfully?
- Specification template copied to feature directory?
- Template system instructions executed successfully?
- Confirmed understanding used to inform spec generation?
- System instructions section removed from final Spec.md?
- Clarification points auto-resolved with reasonable defaults?
- User informed to review specification before proceeding?

## Integration Points

- **Global ContextKit**: Uses Templates/Features/Spec.md template for specification generation
- **Project Setup**: Requires Context.md created by /ctxk:proj:init for project detection and context
- **Template Execution**: Delegates all specification logic to copied Spec.md template (follows init-workspace pattern)
- **Development Workflow**: Creates foundation for /ctxk:plan:2-research-tech technical planning phase
- **Team Collaboration**: Creates committed specification for team review and stakeholder validation
- **Git Integration**: Establishes feature branch for systematic development workflow
- **Workspace Integration**: Template inherits coding standards and constitutional overrides from workspace Context.md

## Success Messages

### Specification Created Successfully

```
🎉 Specification created successfully!

📁 Feature: [numbered-feature-directory-name]
✅ Created: [numbered-feature-directory]/Spec.md
✅ Git branch: feature/[XXX]-[auto-generated-kebab-case-name]
✅ Branch created in root repository
✅ Applied constitutional principles from project guidelines
✅ All mandatory sections completed with project-specific content
✅ Clarifications auto-resolved with reasonable defaults

🔗 Next Steps:
1. Review [numbered-feature-directory]/Spec.md to ensure it matches your intent
2. Adjust auto-resolved answers (marked with ✅ [AUTO-RESOLVED:]) if needed
3. When satisfied with the spec: commit your changes with git
4. Continue planning:
   • Quick: Run /ctxk:plan:planning to auto-complete all remaining phases
   • Manual: Run /ctxk:plan:2-research → /ctxk:plan:3-tech → /ctxk:plan:4-steps

💡 Specification ready for research and architecture phases!
```

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Custom Feature Examples
<!-- Add examples of feature/app descriptions that work well with your project type -->

## Naming Overrides
<!-- Document project-specific naming conventions or automatic name generation rules -->

## Validation Rules
<!-- Add extra specification validation steps or quality gates specific to your project -->
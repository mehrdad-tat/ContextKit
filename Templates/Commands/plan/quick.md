Quick planning for smaller tasks, bug fixes, and improvements (single-file workflow)

<!-- Template Version: 6 | ContextKit: 0.2.8 | Updated: 2025-10-22 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: https://github.com/mehrdad-tat/ContextKit/issues

---

# Quick Planning Workflow

This command creates a condensed, single-file plan for:

- Bug fixes
- Smaller feature additions
- Code improvements and refactoring
- Dependency updates
- Documentation updates
- Focused enhancements

**Note**: These tasks are smaller but substantial enough to need planning, just not the full multi-file workflow.

**Use the full workflow** (`/ctxk:plan:1-spec`, etc.) for:

- New major features
- Multiple component changes
- Unclear requirements requiring extensive research
- Tasks needing detailed technical architecture with separate research phase

---

## 🤖 Execution Instructions

### Phase 0: Check Customization

1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section in this file
   - Read everything below that line until end of file
   - Prioritize developer customizations if conflicts exist

### Phase 1: Setup Validation

2. **Check Project Setup**
   - Use Glob to verify `Context.md` exists: `Glob "Context.md"`
   - If missing: ERROR "Run /ctxk:proj:init first"
   - Stop execution if not initialized

### Phase 2: Capture User Intent

3. **Get Task Description from User**

   - Ask user to describe the task using standardized format:

   ```
   ════════════════════════════════════════════════════════════════
   📝 QUICK TASK - What needs to be done?
   ════════════════════════════════════════════════════════════════

   Please describe the task, bug fix, or improvement:

   Examples:
   • "Fix the login button alignment on iPad"
   • "Add dark mode toggle to settings screen"
   • "Refactor AuthService to use async/await"
   • "Update SwiftUI dependencies to latest versions"

   Your description:
   ```

   - **WAIT for user response** (execution MUST stop)
   - **CRITICAL**: Store description exactly verbatim for Quick.md Input field
   - Do NOT summarize or paraphrase

### Phase 3: Codebase & Research Analysis

4. **Analyze Relevant Code and Context**
   - Use Grep to find relevant files and patterns:
     - Search for class/struct names mentioned in description
     - Search for function names or features mentioned
     - Find related test files
   - Use Read to examine relevant files (as many as needed for understanding)
   - Use Read to load project Context.md for patterns and architecture
   - **May include online research** if needed for understanding technologies or APIs
   - Extract:
     - Relevant file paths with line numbers
     - Current implementation patterns
     - Integration points and dependencies
     - Any research findings from documentation or resources
   - **Be thorough** - if the task needs ContextKit, it needs proper analysis

### Phase 4: Interactive Understanding Validation

5. **Display Understanding Summary (Auto-Continue)**

   - **CRITICAL: DO NOT ask user for confirmation - this is informational only**
   - Display understanding summary in chat (DO NOT create file yet):

     ```
     ════════════════════════════════════════════════════════════════
     📋 TASK UNDERSTANDING
     ════════════════════════════════════════════════════════════════

     ## What I Understood

     [Summary of the task - as detailed as necessary for clarity]

     ## In Scope ✅

     - [Items that will be addressed]
     - [As many items as needed for clarity]

     ## Out of Scope ❌

     - [Related items that won't be addressed]
     - [Clearly defined boundaries]

     ## Potential Edge Cases 🔍

     - [Edge cases to consider]
     - [Boundary conditions to watch for]

     ## Questions/Clarifications ❓

     [Only if there are genuine uncertainties]

     Proceeding with quick plan creation...
     ════════════════════════════════════════════════════════════════
     ```

   - Developer can review and edit Quick.md file after it's created if understanding is incorrect
   - **NO USER PROMPT - proceed immediately to next step**

### Phase 5: Generate Quick Plan File

6. **Generate Sequential Number & Create File**

   ```bash
   # Count existing items in Context/Features/ (both folders and files)
   NEXT_NUM=$(printf "%03d" $(($(ls -1 Context/Features/ 2>/dev/null | wc -l) + 1)))
   ```

7. **Generate Task Name from Description**

   - Parse user description for key concepts
   - Create UpperCamelCase name (e.g., "FixLoginButtonAlignment")
   - Keep concise: 2-4 words maximum
   - Focus on action and subject

8. **Copy Quick Template**

   ```bash
   cp ~/.ContextKit/Templates/Features/Quick.md Context/Features/${NEXT_NUM}-[TaskName].md
   ```

9. **Execute Quick Template Workflow**

   - Use Read to read the newly copied Quick.md file
   - Use Edit to populate all sections:
     - **Header**: Replace `[TaskName]` with generated name
     - **Input**: User's verbatim description (use triple quotes)
     - **Understanding**: Confirmed summary from interactive validation (as detailed as needed)
     - **In Scope**: Items from validated understanding (as many as needed for clarity)
     - **Out of Scope**: Items from validated understanding (clearly define boundaries)
     - **Edge Cases**: Items from validated understanding (all relevant considerations)
     - **Code Context**: File paths, patterns, integration points
       - **If online research WAS conducted**: Populate Research Sources subsection with URLs, versions, dates
       - **If NO online research was needed**: Remove Research Sources subsection entirely
     - **Implementation Approach**: Detailed technical approach with rationale and research
     - **Tasks**: Generate specific actionable tasks (as many as needed)
   - Use Edit to remove entire boxed system instructions section
   - Verify all placeholder text replaced

10. **Display Success Message**

    ```
    🎉 Quick task plan created successfully!

    ✅ Created: Context/Features/[XXX]-[TaskName].md
    ✅ Understanding validated with you interactively
    ✅ Ready to start working

    📊 Task Scope:
    • [Number] items in scope
    • [Number] edge cases identified
    • [Number] implementation tasks

    🔗 Next Steps:
    1. Review Context/Features/[XXX]-[TaskName].md
    2. Work through the task checklist
    3. Optionally use Task tool with build-project agent for validation
    4. Commit changes manually with git when done

    💡 Tips:
    • Check off tasks as you complete them
    • Add notes to the Notes section as you work
    • No need for feature branches or formal commits
    • Keep it simple and fast!
    ```

---

## Validation Gates

**Prerequisites:**

- Project Context.md exists?
- User provided task description?

**Understanding Validation:**

- Summary presented to user in chat?
- In Scope/Out of Scope clearly defined?
- Edge cases identified?
- User confirmed understanding is correct?

**File Generation:**

- Quick.md template copied successfully?
- All sections populated with content?
- System instructions removed?
- User informed of next steps?

---

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

[Add any project-specific quick planning requirements here]

## Custom Validation Rules

[Add any additional validation rules for quick tasks here]

## Additional Examples

[Add project-specific examples of when to use quick vs full workflow here]

════════════════════════════════════════════════════════════════════════════════

# Create Implementation Task Breakdown
<!-- Template Version: 9 | ContextKit: 0.2.5 | Updated: 2025-10-22 -->

> [!WARNING]
> **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Generate implementation task breakdown by detecting current feature, validating prerequisites, copying steps template, and executing template workflow with S### task enumeration and parallel execution planning.

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Feature Detection & Validation

1. **Detect Current Feature**
   - Use `Bash` tool to check current git branch: `git branch --show-current`
   - If on feature/[prefix]-[name] branch: Extract feature name from branch
   - If not on feature branch: Use text input to ask user which feature to work on
   - Use `Glob` tool to find numbered feature directory: `Glob Context/Features/???-[FeatureName]`

2. **Validate Prerequisites**
   - Use `Bash` tool to check planning files exist:

     ```bash
     ls [numbered-feature-directory]/Spec.md [numbered-feature-directory]/Research.md [numbered-feature-directory]/Tech.md
     ```

   - If any missing:

     ```
     ❌ Prerequisites not complete!

     All planning phases are required for implementation:
     - Run /ctxk:plan:1-spec if Spec.md is missing
     - Run /ctxk:plan:2-research if Research.md is missing
     - Run /ctxk:plan:3-tech if Tech.md is missing

     Or run /ctxk:plan:planning to execute all planning phases automatically.

     Implementation task breakdown requires completed specification, research, and architecture.
     ```

     → END (exit with error)

### Phase 2: Template Setup & Execution

3. **Copy Steps Template**

   ```bash
   cp ~/.ContextKit/Templates/Features/Steps.md [numbered-feature-directory]/Steps.md
   echo "✅ Copied implementation steps template"
   ```

4. **Execute Steps Template**
   - Use `Read` tool to read the copied Steps.md: `Read [numbered-feature-directory]/Steps.md`
   - Follow the **system instructions** section (boxed area) step by step
   - The template contains task generation logic with S### enumeration and parallel markers
   - Use tools (`Read`, `Edit`) as directed by the template instructions
   - **Template execution**: The copied Steps.md handles all task breakdown, dependency analysis, and parallel execution planning
   - **Progress tracking**: User can see checkboxes being completed in the copied file

5. **Auto-Resolve Clarification Points with Reasonable Defaults**
   - Use `Grep` tool to find clarification markers in Steps.md: `Grep "🚨 \\[NEEDS CLARIFICATION:" [numbered-feature-directory]/Steps.md`
   - If clarification points found:
     - Parse each clarification point to extract the specific question and line context
     - **FOR EACH CLARIFICATION**:
       - Analyze the extracted clarification question
       - Generate most reasonable answer based on:
         - Project Context.md understanding
         - Spec.md and Tech.md context
         - Industry best practices
         - Constitutional principles
         - Common developer expectations
       - Use `Edit` tool to replace 🚨 marker with auto-resolved answer:

         ```
         OLD: 🚨 [NEEDS CLARIFICATION: Should we cache API responses?]
         NEW: ✅ [AUTO-RESOLVED: Yes, implement 5-minute cache for API responses to improve performance and reduce server load. This follows best practices for network efficiency.]
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
       Review Steps.md and adjust answers if needed before proceeding.
       ```

6. **Display Success Message** (see Success Messages section)

## Error Conditions

- **"Prerequisites not complete"** → Must run `/ctxk:plan:1-spec`, `/ctxk:plan:2-research`, and `/ctxk:plan:3-tech` first (or use `/ctxk:plan:planning` for all)
- **"Steps template not found"** → Ensure template files are available
- **"Template execution failed"** → Verify Steps.md template contains system instructions section

## Integration Points

- **Global ContextKit**: Uses Templates/Features/Steps.md template for implementation task generation
- **Project Setup**: Requires Context.md created by /ctxk:proj:init for project detection and context
- **Template Execution**: Delegates all task logic to copied Steps.md template (follows init-workspace pattern)
- **Development Workflow**: Creates foundation for /ctxk:impl:start-working development execution phase
- **Team Collaboration**: Creates committed implementation plan for team review and development coordination
- **Git Integration**: Works within existing feature branch for systematic development workflow
- **Workspace Integration**: Template inherits coding standards and constitutional overrides from workspace Context.md

## Success Messages

### Implementation Steps Created Successfully

```
🎉 Implementation task breakdown created successfully!

✅ Created: [numbered-feature-directory]/Steps.md
✅ Generated S### task enumeration with parallel execution markers
✅ All mandatory phases completed with dependency analysis
✅ All clarification points auto-resolved with reasonable defaults

🔗 Next Steps:
1. Review [numbered-feature-directory]/Steps.md to ensure task breakdown is comprehensive
2. Check auto-resolved answers (marked with ✅ [AUTO-RESOLVED:]) and adjust if needed
3. When satisfied with the implementation plan: commit your changes with git
4. Run /ctxk:impl:start-working (in a new chat) to begin systematic development execution

💡 Implementation roadmap ready for development execution!
```

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

<!-- Add any project-specific guidance for task breakdown and step creation here -->

## Additional Examples

<!-- Add examples of task breakdown patterns that work well with your project -->

## Override Behaviors

<!-- Document any project-specific task organization overrides here -->
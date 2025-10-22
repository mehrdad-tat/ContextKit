# Technical Architecture Design

<!-- Template Version: 0 | ContextKit: 0.2.9 | Updated: 2025-10-21 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Design technical architecture based on research findings: apply development guidelines, create architecture decisions, assess implementation complexity. Creates Tech.md with research-informed technical design.

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Feature Detection & Validation

1. **Detect Current Feature (Auto-Continue with Fallback)**

   - Use `Bash` tool to check current git branch: `git branch --show-current`
   - If on feature/[prefix]-[name] branch: Extract feature name from branch
   - If not on feature branch:

     - Display warning:

       ```
       ⚠️ Not on feature branch. Searching for most recent feature...
       ```

     - Use most recent feature directory from Context/Features/

   - Use `Glob` tool to find numbered feature directory: `Glob Context/Features/???-*`
   - Store the found directory path for use in subsequent steps

2. **Validate Prerequisites**

   - Use `Bash` tool to check required files exist:

     ```bash
     ls [numbered-feature-directory]/Spec.md [numbered-feature-directory]/Research.md
     ```

   - If Spec.md missing:

     ```
     ❌ Feature specification not found!

     Run /ctxk:plan:1-spec first to create the business requirements.
     ```

     → END (exit with error)

   - If Research.md missing:

     ```
     ❌ Research not found!

     Run /ctxk:plan:2-research first to conduct research and analysis.
     Architecture design requires research findings as input.
     ```

     → END (exit with error)

### Phase 2: Template Setup & Architecture Design

3. **Copy Tech Template**

   ```bash
   cp ~/.ContextKit/Templates/Features/Tech.md [numbered-feature-directory]/Tech.md
   echo "✅ Copied technical architecture template"
   ```

4. **Execute Tech Template**

   - Use `Read` tool to read the **ENTIRE** copied Tech.md template: `Read [numbered-feature-directory]/Tech.md`
   - **CRITICAL**: Follow the Tech.md template's **🤖 EXECUTION FLOW** instructions step by step:

   **Phase 1: Context & Research Loading** (Steps 1-3 in Tech.md)

   - Load feature specification (Spec.md)
   - Load research findings (Research.md)
   - Load project context (Context.md)
   - Understand feature requirements and research outcomes

   **Phase 2: Guidelines & Standards** (Steps 4-5 in Tech.md)

   - Discover and load all development guidelines from Context/Guidelines/
   - Apply Context/Guidelines compliance gates
   - Understand constitutional principles and coding standards

   **Phase 3: Architecture Design** (Steps 6-10 in Tech.md)

   - Design iOS/macOS architecture using research findings
   - Make technology choices based on research
   - Design data models, services, UI components
   - Document architecture decisions with research references
   - Apply constitutional principles (accessibility, privacy, localizability, etc.)

   **Phase 4: Complexity Assessment** (Steps 11-12 in Tech.md)

   - Analyze implementation complexity
   - Identify risks and challenges
   - Document complexity tracking

   **Phase 5: Validation & Completion** (Steps 13-14 in Tech.md)

   - Execute validation steps
   - Use `Edit` tool to **remove the entire boxed system instructions section**
   - Verify architecture quality

   **Template execution**: You must populate Tech.md with actual architecture decisions informed by Research.md

5. **Auto-Resolve Clarification Points with Reasonable Defaults**

   - Use `Grep` tool to find clarification markers: `Grep "🚨 \\[NEEDS CLARIFICATION:" [numbered-feature-directory]/Tech.md`
   - If clarification points found:

     - Parse each clarification point
     - **FOR EACH CLARIFICATION**:

       - Analyze the question
       - Generate most reasonable answer based on:
         - Research.md findings
         - Project Context.md
         - Development guidelines
         - Constitutional principles
       - Use `Edit` tool to replace 🚨 marker with auto-resolved answer:

         ```
         OLD: 🚨 [NEEDS CLARIFICATION: Which pattern to use?]
         NEW: ✅ [AUTO-RESOLVED: Use MVVM pattern because [reasoning based on research, guidelines, and constitutional principles]]
         ```

       - Log resolution in chat:

         ```
         ℹ️ Auto-resolved architecture clarification:
            Question: [extracted question]
            Answer: [reasonable default based on research and standards]
         ```

     - After all clarifications resolved:

       ```
       ✅ Auto-resolved [count] clarification points with research-informed defaults.
       Review Tech.md and adjust if needed before proceeding.
       ```

6. **Display Success Message** (see Success Messages section)

## Error Conditions

- **"Feature specification not found"** → Must run `/ctxk:plan:1-spec` first
- **"Research not found"** → Must run `/ctxk:plan:2-research` first
- **"Tech template not found"** → Ensure template files are available
- **"Template execution failed"** → Verify Tech.md template contains system instructions section

## Validation Gates

- Project Context.md exists?
- Feature Spec.md exists and complete?
- Research.md exists with findings?
- Tech template copied successfully?
- Development guidelines loaded and applied?
- Architecture decisions made and documented?
- Complexity assessment completed?
- System instructions removed from final file?
- Clarifications auto-resolved with research-informed defaults?

## Integration Points

- **Global ContextKit**: Uses Templates/Features/Tech.md template for architecture design
- **Project Setup**: Requires Context.md created by /ctxk:proj:init
- **Research Phase**: Uses Research.md findings from /ctxk:plan:2-research
- **Template Execution**: Delegates architecture logic to copied Tech.md template
- **Development Workflow**: Creates foundation for /ctxk:plan:4-steps implementation planning
- **Team Collaboration**: Creates committed architecture for team review
- **Git Integration**: Works within existing feature branch
- **Workspace Integration**: Template inherits workspace standards

## Success Messages

### Architecture Design Completed Successfully

```
🎉 Technical architecture completed successfully!

✅ Created: [numbered-feature-directory]/Tech.md
✅ Research findings integrated into architecture
✅ Development guidelines applied
✅ Architecture decisions documented
✅ Implementation complexity assessed
✅ Clarifications auto-resolved with research-informed defaults

📐 Architecture Summary:
   • Data Models: [X] models designed
   • Services: [Y] service layers defined
   • UI Components: [Z] components planned

🔗 Next Steps:
1. Review [numbered-feature-directory]/Tech.md to validate architecture
2. Adjust auto-resolved answers (marked with ✅ [AUTO-RESOLVED:]) if needed
3. When satisfied: commit your changes with git
4. Run /ctxk:plan:4-steps to proceed with implementation task breakdown

💡 Architecture ready for implementation planning!
```

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

<!-- Add any project-specific architecture guidance here -->

## Additional Architecture Patterns

<!-- Document preferred patterns, frameworks, design principles -->

## Override Behaviors

<!-- Document any project-specific architecture requirement overrides here -->

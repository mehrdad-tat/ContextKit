# Research & Knowledge Acquisition

<!-- Template Version: 0 | ContextKit: 0.2.7 | Updated: 2025-10-21 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Conduct comprehensive research for feature implementation: analyze codebase integration points, investigate relevant technologies/APIs, and explore architecture patterns. Creates Research.md documenting all findings.

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

   - Use `Bash` tool to check Spec.md exists: `ls [numbered-feature-directory]/Spec.md`
   - If Spec.md missing:

     ```
     ❌ Feature specification not found!

     Run /ctxk:plan:1-spec first to create the business requirements.
     Research requires completed specification as input.
     ```

     → END (exit with error)

### Phase 2: Template Setup & Research Execution

3. **Copy Research Template**

   ```bash
   cp ~/.ContextKit/Templates/Features/Research.md [numbered-feature-directory]/Research.md
   echo "✅ Copied research template"
   ```

4. **Execute Research Template**

   - Use `Read` tool to read the **ENTIRE** copied Research.md template: `Read [numbered-feature-directory]/Research.md`
   - **CRITICAL**: Follow the Research.md template's **🤖 EXECUTION FLOW** instructions step by step:

   **Phase 1: Context Loading** (Steps 1-2 in Research.md)

   - Load feature specification (Spec.md)
   - Load project context (Context.md)
   - Understand what needs to be researched

   **Phase 2: Codebase Analysis** (Steps 3-4 in Research.md)

   - Launch codebase integration agent using `Task` tool
   - Identify existing patterns, similar features, integration points
   - Document codebase findings

   **Phase 3: Technology Research** (Steps 5-7 in Research.md)

   - Launch technology research agents using `Task` tool (if needed)
   - Research relevant frameworks, APIs, tools
   - **CRITICAL**: Instruct ALL agents to RETURN findings as text responses, NOT create files
   - **Wait for ALL agents to complete** before proceeding
   - Document technology findings

   **Phase 4: Architecture Pattern Research** (Steps 8-10 in Research.md)

   - Launch architecture pattern research agents using `Task` tool (if needed)
   - Explore design patterns, best practices
   - Document pattern findings

   **Phase 5: Consolidation** (Steps 11-12 in Research.md)

   - Consolidate all research findings into structured sections
   - Identify key decisions that need to be made
   - Use `Edit` tool to **remove the entire boxed system instructions section**

   **Template execution**: You must populate Research.md with actual findings from agents and analysis

5. **Auto-Resolve Clarification Points with Reasonable Defaults**

   - Use `Grep` tool to find clarification markers: `Grep "🚨 \\[NEEDS CLARIFICATION:" [numbered-feature-directory]/Research.md`
   - If clarification points found:

     - Parse each clarification point
     - **FOR EACH CLARIFICATION**:

       - Analyze the question
       - Generate most reasonable answer based on:
         - Project Context.md
         - Industry best practices
         - Research findings
       - Use `Edit` tool to replace 🚨 marker with auto-resolved answer:

         ```
         OLD: 🚨 [NEEDS CLARIFICATION: Should we use X or Y?]
         NEW: ✅ [AUTO-RESOLVED: Use X because [reasoning based on research findings and project context]]
         ```

       - Log resolution in chat:

         ```
         ℹ️ Auto-resolved research clarification:
            Question: [extracted question]
            Answer: [reasonable default based on findings]
         ```

     - After all clarifications resolved:

       ```
       ✅ Auto-resolved [count] clarification points with research-based defaults.
       Review Research.md and adjust if needed before proceeding.
       ```

6. **Display Success Message** (see Success Messages section)

## Error Conditions

- **"Feature specification not found"** → Must run `/ctxk:plan:1-spec` first
- **"Research template not found"** → Ensure template files are available
- **"Template execution failed"** → Verify Research.md template contains system instructions section

## Validation Gates

- Project Context.md exists?
- Feature Spec.md exists and complete?
- Research template copied successfully?
- Research agents launched and completed?
- All findings documented in Research.md?
- System instructions removed from final file?
- Clarifications auto-resolved with research-based defaults?

## Integration Points

- **Global ContextKit**: Uses Templates/Features/Research.md template for research execution
- **Project Setup**: Requires Context.md created by /ctxk:proj:init
- **Template Execution**: Delegates research logic to copied Research.md template
- **Development Workflow**: Creates foundation for /ctxk:plan:3-tech architecture phase
- **Team Collaboration**: Creates committed research for team review
- **Git Integration**: Works within existing feature branch
- **Workspace Integration**: Template inherits workspace standards

## Success Messages

### Research Completed Successfully

```
🎉 Research phase completed successfully!

✅ Created: [numbered-feature-directory]/Research.md
✅ Codebase integration analysis complete
✅ Technology research findings documented
✅ Architecture pattern exploration complete
✅ Clarifications auto-resolved with research-based defaults

📊 Research Summary:
   • Codebase: [X] integration points identified
   • Technologies: [Y] frameworks/APIs analyzed
   • Patterns: [Z] architecture patterns explored

🔗 Next Steps:
1. Review [numbered-feature-directory]/Research.md to validate findings
2. Adjust auto-resolved answers (marked with ✅ [AUTO-RESOLVED:]) if needed
3. When satisfied: commit your changes with git
4. Run /ctxk:plan:3-tech to proceed with architecture design (uses research findings)

💡 Research ready for architecture phase!
```

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Project-Specific Instructions

<!-- Add any project-specific research guidance here -->

## Additional Research Sources

<!-- Document preferred research sources, documentation sites, etc. -->

## Override Behaviors

<!-- Document any project-specific research requirement overrides here -->

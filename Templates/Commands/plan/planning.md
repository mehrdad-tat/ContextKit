# Complete Feature Planning Workflow

<!-- Template Version: 0 | ContextKit: 0.2.7 | Updated: 2025-10-21 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Execute complete planning workflow automatically: specification → research → architecture → task breakdown. Creates all four planning documents (Spec.md, Research.md, Tech.md, Steps.md) in one continuous flow.

**Use this when**: Starting a new feature and want complete planning done automatically.

**Alternative**: Run individual commands for more control:

- `/ctxk:plan:1-spec` - Specification only
- `/ctxk:plan:2-research` - Research only
- `/ctxk:plan:3-tech` - Architecture only
- `/ctxk:plan:4-steps` - Task breakdown only

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Prerequisites

1. **Verify ContextKit Setup**

   - Use `Glob` to verify Context.md exists: `Glob . Context.md`
   - If missing:

     ```
     ❌ ContextKit not initialized!

     Run /ctxk:proj:init first to setup ContextKit in this project.
     ```

     → END (exit with error)

### Phase 2: Workflow Execution

2. **Display Planning Workflow Start**

   ```
   ════════════════════════════════════════════════════════════════
   🎯 COMPLETE PLANNING WORKFLOW
   ════════════════════════════════════════════════════════════════

   This workflow will execute 4 planning phases automatically:

   Phase 1/4: Specification (1-spec.md)
      ↓ Creates: Spec.md with business requirements

   Phase 2/4: Research (2-research.md)
      ↓ Creates: Research.md with technical findings

   Phase 3/4: Architecture (3-tech.md)
      ↓ Creates: Tech.md with design decisions

   Phase 4/4: Task Breakdown (4-steps.md)
      ↓ Creates: Steps.md with implementation tasks

   ════════════════════════════════════════════════════════════════
   ```

3. **Execute Phase 1: Specification** (/ctxk:plan:1-spec)

   - Use `SlashCommand` tool to execute: `/ctxk:plan:1-spec`
   - Wait for completion
   - Verify Spec.md was created
   - Display progress:

     ```
     ✅ Phase 1/4 Complete: Specification created

     📄 Created: Context/Features/[XXX]-[FeatureName]/Spec.md

     Proceeding to Phase 2: Research...
     ```

4. **Execute Phase 2: Research** (/ctxk:plan:2-research)

   - Use `SlashCommand` tool to execute: `/ctxk:plan:2-research`
   - Wait for completion
   - Verify Research.md was created
   - Display progress:

     ```
     ✅ Phase 2/4 Complete: Research findings documented

     📄 Created: Context/Features/[XXX]-[FeatureName]/Research.md

     Proceeding to Phase 3: Architecture...
     ```

5. **Execute Phase 3: Architecture** (/ctxk:plan:3-tech)

   - Use `SlashCommand` tool to execute: `/ctxk:plan:3-tech`
   - Wait for completion
   - Verify Tech.md was created
   - Display progress:

     ```
     ✅ Phase 3/4 Complete: Technical architecture designed

     📄 Created: Context/Features/[XXX]-[FeatureName]/Tech.md

     Proceeding to Phase 4: Task Breakdown...
     ```

6. **Execute Phase 4: Task Breakdown** (/ctxk:plan:4-steps)

   - Use `SlashCommand` tool to execute: `/ctxk:plan:4-steps`
   - Wait for completion
   - Verify Steps.md was created
   - Display progress:

     ```
     ✅ Phase 4/4 Complete: Implementation tasks defined

     📄 Created: Context/Features/[XXX]-[FeatureName]/Steps.md
     ```

### Phase 3: Completion

7. **Display Success Summary**

   ```
   ════════════════════════════════════════════════════════════════
   🎉 COMPLETE PLANNING WORKFLOW FINISHED!
   ════════════════════════════════════════════════════════════════

   ✅ All 4 planning phases completed successfully:

   📁 Feature: Context/Features/[XXX]-[FeatureName]/
      ✓ Spec.md - Business requirements and user stories
      ✓ Research.md - Technical research findings
      ✓ Tech.md - Architecture and design decisions
      ✓ Steps.md - Implementation task breakdown

   🌿 Git branch: feature/[XXX]-[feature-name]

   📊 Planning Summary:
      • Feature understanding validated with you
      • Research: [X] integration points, [Y] technologies, [Z] patterns
      • Architecture: [A] models, [B] services, [C] components
      • Implementation: [N] tasks with S001-S### enumeration

   🔗 Next Steps:
   1. Review all planning documents in Context/Features/[XXX]-[FeatureName]/
   2. Adjust any auto-resolved answers (marked with ✅ [AUTO-RESOLVED:])
   3. Commit planning documents: git add . && git commit -m "Complete planning for [FeatureName]"
   4. Begin implementation: /ctxk:impl:start-working (in a new chat session)

   💡 Ready to start systematic development!
   ════════════════════════════════════════════════════════════════
   ```

## Error Conditions

- **"ContextKit not initialized"** → Run `/ctxk:proj:init` first
- **"Phase X failed"** → Check error message from individual command, fix issue, resume manually
- **"Documents not created"** → Verify template files exist and are accessible

## Validation Gates

- Project Context.md exists?
- Phase 1 (Spec.md) completed successfully?
- Phase 2 (Research.md) completed successfully?
- Phase 3 (Tech.md) completed successfully?
- Phase 4 (Steps.md) completed successfully?
- All documents exist in feature directory?
- User informed of next steps?

## Integration Points

- **Project Setup**: Requires `/ctxk:proj:init` completed
- **Individual Commands**: Orchestrates `/ctxk:plan:1-spec`, `/ctxk:plan:2-research`, `/ctxk:plan:3-tech`, `/ctxk:plan:4-steps`
- **Development Workflow**: Creates complete foundation for `/ctxk:impl:start-working`
- **Team Collaboration**: Creates all planning documents for team review
- **Git Integration**: Works within feature branch structure

## Success Messages

See Phase 3, Step 7 above for complete success summary.

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Custom Planning Phases

<!-- Add or skip specific planning phases for your project -->

## Additional Validation

<!-- Add project-specific validation between phases -->

## Override Behaviors

<!-- Document any project-specific workflow modifications here -->

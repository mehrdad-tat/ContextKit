# Re-Plan or Update Existing Feature

<!-- Template Version: 0 | ContextKit: 0.2.7 | Updated: 2025-10-21 -->

> [!WARNING] > **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: <https://github.com/mehrdad-tat/ContextKit/issues>

## Description

Smart replanning command that adapts based on what exists:

- **If feature documents exist**: Regenerates them with updated information
- **If no documents exist**: Creates new feature from scratch

**Use this when**:

- Requirements changed and you need to update existing plans
- You want to refresh planning documents with new insights
- Starting a new feature (works same as `/ctxk:plan:planning`)

## Execution Flow (main)

### Phase 0: Check Customization

0. **Read the "👩‍💻 DEVELOPER CUSTOMIZATIONS" section**
   - Use `Grep` tool to find the start of the section
   - Read everything below that line contained in this document til the end of the file
   - Make sure to consider what was said there with high priority
   - If anything conflicts with the rest of the workflow, prioritize the "developer customizations"

### Phase 1: Detect Current State

1. **Verify ContextKit Setup**

   - Use `Glob` to verify Context.md exists: `Glob . Context.md`
   - If missing:

     ```
     ❌ ContextKit not initialized!

     Run /ctxk:proj:init first to setup ContextKit in this project.
     ```

     → END (exit with error)

2. **Detect Feature and Existing Documents**

   - Use `Bash` tool to check current git branch: `git branch --show-current`
   - If on feature/[prefix]-[name] branch: Extract feature name
   - If not on feature branch: Use most recent feature from Context/Features/
   - Use `Glob` tool to find feature directory: `Glob Context/Features/???-*`
   - Check which planning documents exist:

     ```bash
     ls [feature-directory]/Spec.md 2>/dev/null && echo "Spec.md exists"
     ls [feature-directory]/Research.md 2>/dev/null && echo "Research.md exists"
     ls [feature-directory]/Tech.md 2>/dev/null && echo "Tech.md exists"
     ls [feature-directory]/Steps.md 2>/dev/null && echo "Steps.md exists"
     ```

   - Store list of existing documents

3. **Determine Replanning Strategy**

   - **If NO documents exist**:

     - Display:

       ```
       ℹ️ No existing planning documents found.
       Starting fresh planning workflow...
       ```

     - Proceed to Phase 2 (Fresh Planning)

   - **If SOME/ALL documents exist**:

     - Display:

       ```
       ════════════════════════════════════════════════════════════════
       🔄 REPLANNING MODE DETECTED
       ════════════════════════════════════════════════════════════════

       Found existing documents in: [feature-directory]

       Existing files:
       [✓] Spec.md - Will regenerate with current understanding
       [✓] Research.md - Will update with fresh research
       [✓] Tech.md - Will redesign architecture
       [✓] Steps.md - Will recreate task breakdown

       Missing files:
       [X] [List any missing documents that will be created]

       Auto-proceeding to regenerate all planning documents...
       ════════════════════════════════════════════════════════════════
       ```

     - Proceed to Phase 3 (Regeneration)

### Phase 2: Fresh Planning (No Documents Exist)

4. **Execute Complete Planning Workflow**
   - Use `SlashCommand` tool to execute: `/ctxk:plan:planning`
   - Wait for completion
   - END (planning command handles everything)

### Phase 3: Regeneration (Documents Exist)

5. **Backup Existing Documents**

   ```bash
   TIMESTAMP=$(date +%Y%m%d_%H%M%S)
   mkdir -p [feature-directory]/.backups/${TIMESTAMP}
   cp [feature-directory]/*.md [feature-directory]/.backups/${TIMESTAMP}/ 2>/dev/null || true
   echo "✅ Backed up existing documents to [feature-directory]/.backups/${TIMESTAMP}/"
   ```

6. **Regenerate Phase 1: Specification**

   - If Spec.md exists: Delete it
   - Use `SlashCommand` tool to execute: `/ctxk:plan:1-spec`
   - Wait for completion
   - Display:

     ```
     ✅ Phase 1/4 Regenerated: Specification

     Old version backed up, new Spec.md created with current understanding.
     ```

7. **Regenerate Phase 2: Research**

   - If Research.md exists: Delete it
   - Use `SlashCommand` tool to execute: `/ctxk:plan:2-research`
   - Wait for completion
   - Display:

     ```
     ✅ Phase 2/4 Regenerated: Research

     Fresh research conducted, new Research.md created with updated findings.
     ```

8. **Regenerate Phase 3: Architecture**

   - If Tech.md exists: Delete it
   - Use `SlashCommand` tool to execute: `/ctxk:plan:3-tech`
   - Wait for completion
   - Display:

     ```
     ✅ Phase 3/4 Regenerated: Architecture

     Architecture redesigned based on new research, Tech.md updated.
     ```

9. **Regenerate Phase 4: Task Breakdown**

   - If Steps.md exists: Delete it (preserves old task progress in backup)
   - Use `SlashCommand` tool to execute: `/ctxk:plan:4-steps`
   - Wait for completion
   - Display:

     ```
     ✅ Phase 4/4 Regenerated: Task Breakdown

     New implementation plan created in Steps.md.
     ```

### Phase 4: Completion

10. **Display Success Summary**

    ```
    ════════════════════════════════════════════════════════════════
    🎉 REPLANNING COMPLETE!
    ════════════════════════════════════════════════════════════════

    ✅ All planning documents regenerated successfully

    📁 Feature: [feature-directory]
       ✓ Spec.md - Updated business requirements
       ✓ Research.md - Fresh research findings
       ✓ Tech.md - Redesigned architecture
       ✓ Steps.md - New implementation tasks

    💾 Backup: [feature-directory]/.backups/[TIMESTAMP]/
       • Old versions preserved for reference
       • Compare using: diff [feature-directory]/Spec.md [feature-directory]/.backups/[TIMESTAMP]/Spec.md

    🔗 Next Steps:
    1. Review regenerated planning documents
    2. Compare with backup to see what changed
    3. Adjust any auto-resolved answers if needed
    4. Commit updates: git add . && git commit -m "Replan: [FeatureName] with updated requirements"
    5. Resume implementation: /ctxk:impl:start-working

    💡 Planning refreshed and ready!
    ════════════════════════════════════════════════════════════════
    ```

## Error Conditions

- **"ContextKit not initialized"** → Run `/ctxk:proj:init` first
- **"Feature not found"** → Create feature with `/ctxk:plan:planning` or `/ctxk:plan:1-spec` first
- **"Phase regeneration failed"** → Check error, fix issue, resume manually
- **"Backup failed"** → Check disk space and permissions

## Validation Gates

- Project Context.md exists?
- Feature directory detected?
- Existing documents backed up (if any)?
- All phases regenerated successfully?
- User informed of backup location?
- User informed of next steps?

## Integration Points

- **Project Setup**: Requires `/ctxk:proj:init` completed
- **Planning Workflow**: Uses `/ctxk:plan:planning` for fresh start or individual commands for regeneration
- **Development Workflow**: Preserves task progress in backups, creates fresh Steps.md
- **Team Collaboration**: Regenerates all planning documents for team review
- **Git Integration**: Works within existing feature branch

## Success Messages

See Phase 4, Step 10 above for complete success summary.

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific instructions, examples, and overrides below.

## Custom Replanning Strategy

<!-- Customize which documents to regenerate or preserve -->

## Backup Retention

<!-- Configure backup cleanup or retention policies -->

## Override Behaviors

<!-- Document any project-specific replanning modifications here -->

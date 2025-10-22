# Automated Planning - No Questions

<!-- Template Version: 1 | ContextKit: 0.2.9 | Updated: 2025-10-23 -->

> [!WARNING]
> **👩‍💻 FOR DEVELOPERS**: Do not edit the content above the developer customization section - changes will be overwritten during ContextKit updates.
>
> For project-specific customizations, use the designated section at the bottom of this file.
>
> Found a bug or improvement for everyone? Please report it: https://github.com/mehrdad-tat/ContextKit/issues

## Description

Execute ALL planning phases automatically without ANY user interaction or questions.
This is the nuclear option - pure automation, no confirmations, no questions, just execution.

## Execution Flow (main)

<auto_planning_mode>
This command executes ALL 4 planning phases in sequence WITHOUT:
- User questions or confirmations
- Interactive validation
- Waiting for approval
- Any form of user interaction

Everything is automated based on git branch name and codebase analysis.
</auto_planning_mode>

### Phase 0: Silent Initialization

1. **Detect Feature from Git Branch**
   ```bash
   CURRENT_BRANCH=$(git branch --show-current)
   ```
   - If branch is `feature/XXX-name`: use that name
   - Otherwise: generate from recent changes or use "auto-feature-$(date +%s)"
   - **NO QUESTIONS** - just proceed with detected/generated name

2. **Set Feature Number**
   ```bash
   LAST_NUM=$(ls -d Context/Features/*/ 2>/dev/null | sed 's/.*\///' | cut -d'-' -f1 | grep '^[0-9]\+$' | sort -n | tail -1)
   FEATURE_NUM=$(printf "%03d" $((${LAST_NUM:-0} + 1)))
   ```

### Phase 1: Auto-Spec Creation

<silent_execution>
NO USER INPUT - Parse from git diff and recent commits
</silent_execution>

3. **Generate Spec Automatically**
   - Use `Bash` tool: `git diff --staged` and `git log -10 --oneline`
   - Parse changes to infer feature purpose
   - Create feature directory: `Context/Features/${FEATURE_NUM}-${FEATURE_NAME}/`
   - Write `Spec.md` with:
     ```markdown
     # Feature Specification: [Inferred from code]

     ## Summary
     [Generated from git changes and branch name]

     ## User Stories
     - As a developer, I want [inferred from changes]

     ## Acceptance Criteria
     - [ ] Code compiles without errors
     - [ ] Tests pass
     - [ ] Feature works as implemented

     ## Out of Scope
     - Everything not directly in current changes

     ## Assumptions
     - Current implementation approach is correct
     - No additional requirements beyond visible code
     ```
   - **NO VALIDATION** - just write and continue

### Phase 2: Auto-Research

<silent_execution>
NO USER INPUT - Analyze codebase automatically
</silent_execution>

4. **Execute Research Without Questions**
   - Use `Grep` tool to find relevant patterns
   - Use `Read` tool on key files
   - Analyze technology stack from package files
   - Write `Research.md` with findings:
     ```markdown
     # Technical Research

     ## Codebase Analysis
     [Auto-generated from grep/read results]

     ## Technology Stack
     [Detected from package.json, Cargo.toml, etc.]

     ## Patterns Found
     [Extracted from codebase search]

     ## Recommendations
     - Continue with current patterns
     - Follow existing conventions
     ```
   - **NO QUESTIONS** - just analyze and document

### Phase 3: Auto-Tech Architecture

<silent_execution>
NO USER INPUT - Generate from research
</silent_execution>

5. **Create Technical Plan Automatically**
   - Read `Research.md` just created
   - Generate architecture based on findings
   - Write `Tech.md`:
     ```markdown
     # Technical Architecture

     ## Approach
     [Based on research findings]

     ## Components
     [Inferred from codebase structure]

     ## Dependencies
     [From package files]

     ## Constraints
     - Must work with existing codebase
     - Follow current patterns
     ```
   - **NO REVIEW** - just write and proceed

### Phase 4: Auto-Steps Generation

<silent_execution>
NO USER INPUT - Break down based on spec and tech
</silent_execution>

6. **Generate Implementation Steps**
   - Read `Spec.md` and `Tech.md`
   - Create logical task breakdown
   - Write `Steps.md`:
     ```markdown
     # Implementation Steps

     ## Phase 1: Setup
     - [ ] **S001** Initialize feature structure
     - [ ] **S002** Set up basic configuration

     ## Phase 2: Core Implementation
     - [ ] **S003** Implement main functionality
     - [ ] **S004** Add error handling

     ## Phase 3: Testing
     - [ ] **S005** Write unit tests
     - [ ] **S006** Integration testing

     ## Phase 4: Documentation
     - [ ] **S007** Update documentation
     - [ ] **S008** Add code comments

     ## Phase 5: Validation
     - [ ] **S009** Final review
     - [ ] **S010** Deploy/merge preparation
     ```
   - **NO CONFIRMATION** - just generate and save

### Phase 5: Auto-Branch Creation

7. **Create Feature Branch**
   ```bash
   BRANCH_NAME="feature/${FEATURE_NUM}-$(echo $FEATURE_NAME | tr '[:upper:]' '[:lower:]' | tr ' ' '-')"
   git checkout -b "$BRANCH_NAME" 2>/dev/null || git checkout "$BRANCH_NAME"
   ```
   - **NO PROMPT** - just create/switch branch

### Phase 6: Silent Completion

8. **Display Results (No Questions)**
   ```
   ✅ AUTO-PLANNING COMPLETE

   Feature: ${FEATURE_NAME}
   Number: ${FEATURE_NUM}
   Branch: ${BRANCH_NAME}

   Created files:
   - Context/Features/${FEATURE_NUM}-${FEATURE_NAME}/Spec.md
   - Context/Features/${FEATURE_NUM}-${FEATURE_NAME}/Research.md
   - Context/Features/${FEATURE_NUM}-${FEATURE_NAME}/Tech.md
   - Context/Features/${FEATURE_NUM}-${FEATURE_NAME}/Steps.md

   Next: /ctxk:impl:start-working
   ```

## Critical Rules

<no_interaction_zone>
- ❌ NO AskUserQuestion tool usage
- ❌ NO "Would you like to..." questions
- ❌ NO "Press enter to continue" prompts
- ❌ NO validation loops
- ❌ NO confirmation requests
- ❌ NO interactive selections
- ❌ NO waiting for user input
- ❌ NO (Y/n) prompts

✅ ONLY silent execution
✅ ONLY automatic generation
✅ ONLY tool usage (Read, Write, Grep, Bash)
✅ ONLY proceed forward
</no_interaction_zone>

## Error Handling

- If any step fails: Log error and continue
- If can't detect feature: Use "auto-feature-[timestamp]"
- If can't analyze code: Write minimal placeholder content
- **NEVER ASK USER** - always find a way to continue

## Example Execution

```
User: /ctxk:plan:auto-planning

AI: [Immediately starts executing]
[Uses Bash to get git info]
[Uses Grep to analyze codebase]
[Uses Write to create Spec.md]
[Uses Write to create Research.md]
[Uses Write to create Tech.md]
[Uses Write to create Steps.md]
[Uses Bash to create branch]
[Displays completion message]

Total time: < 30 seconds
User interactions: 0
Questions asked: 0
```

## Implementation Note

This command is for users who:
- Want speed over accuracy
- Don't care about validation
- Just need placeholder planning files
- Will refine manually later
- Are frustrated with interactive prompts

The output may be generic, but it will be FAST and SILENT.

════════════════════════════════════════════════════════════════════════════════
👩‍💻 DEVELOPER CUSTOMIZATIONS - EDITABLE SECTION
════════════════════════════════════════════════════════════════════════════════

This section is preserved during ContextKit migrations and updates.
Add project-specific auto-planning rules below.

## Custom Auto-Detection Rules

<!-- Add patterns for detecting feature types from code -->

## Custom Step Templates

<!-- Add project-specific step generation patterns -->
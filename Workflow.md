# ContextKit Complete Workflow Documentation

**Last Updated**: 2025-10-17
**Purpose**: Comprehensive step-by-step documentation of the complete ContextKit workflow from feature planning through implementation and commit.

---

## Table of Contents

1. [Workflow Overview](#workflow-overview)
2. [Phase 1: Feature Specification](#phase-1-feature-specification-ctxkplan1-spec)
3. [Phase 2: Research & Technical Architecture](#phase-2-research--technical-architecture-ctxkplan2-research-tech)
4. [Phase 3: Implementation Steps](#phase-3-implementation-steps-ctxkplan3-steps)
5. [Phase 4: Development Execution](#phase-4-development-execution-ctxkimplstart-working)
6. [Phase 5: Commit Changes](#phase-5-commit-changes-ctxkimplcommit-changes)
7. [Workflow Timing Analysis](#workflow-timing-analysis)

---

## Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│ COMPLETE CONTEXTKIT WORKFLOW                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣  /ctxk:plan:1-spec → Spec.md                               │
│     ├─ Check setup, git status, get user input                 │
│     ├─ Generate names, create feature directory                │
│     ├─ Copy Spec.md template → Execute template workflow       │
│     └─ Resolve clarifications → Ready for research             │
│                                                                 │
│  2️⃣  /ctxk:plan:2-research-tech (SINGLE RUN)                    │
│     ├─ Copy Tech.md template                                   │
│     ├─ Execute research phase → populate Research section      │
│     │  ├─ Launch research agents (tech, API, patterns)         │
│     │  └─ Document findings in Research & Analysis             │
│     ├─ Execute architecture phase → populate Tech section      │
│     │  ├─ Load guidelines + apply compliance gates             │
│     │  ├─ Design architecture (references research)            │
│     │  └─ Document in Technical Architecture section           │
│     └─ Resolve clarifications → Ready for steps                │
│                                                                 │
│  3️⃣  /ctxk:plan:3-steps → Steps.md                             │
│     ├─ Load Spec.md and Tech.md (research + architecture)      │
│     ├─ Copy Steps.md template → Execute template workflow      │
│     ├─ Generate S001-S999 tasks with [P] markers               │
│     └─ Resolve clarifications → Ready for development          │
│                                                                 │
│  4️⃣  /ctxk:impl:start-working (DEVELOPMENT LOOP)                │
│     ├─ Load ALL context (Spec, Tech with research, Steps)      │
│     ├─ Find next uncompleted task in Steps.md                  │
│     ├─ Execute task (manual delegation OR automated)           │
│     ├─ Update Steps.md progress tracking                       │
│     └─ Loop until all tasks complete                           │
│                                                                 │
│  5️⃣  /ctxk:impl:commit-changes                                  │
│     └─ Launch commit-changes agent → Create commit             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Feature Specification (`/ctxk:plan:1-spec`)

**Purpose**: Create business requirements document (Spec.md) with user stories, acceptance criteria, and scope definition.

### Execution Steps

#### Phase 0: Developer Customization Check
1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section
   - Read everything below that line until end of file
   - Prioritize developer customizations if conflicts exist

#### Phase 1: Setup Validation & Prerequisites
2. **Check Project Setup**
   - Use Glob to verify Context.md exists
   - If missing: ERROR "Run /ctxk:proj:init first"
   - Stop execution if not initialized

#### Phase 2: Interactive Feature Definition & Naming
3. **Check Git Status**
   ```bash
   git status --porcelain
   ```
   - If uncommitted changes exist: warn user
   - Ask for confirmation to continue or exit
   - Wait for user response

4. **Get Feature/App Description from User**
   - Ask user for feature/app description using standardized format
   - Wait for user input
   - **CRITICAL**: Store description exactly verbatim for Spec.md Input field
   - Do NOT summarize or paraphrase

5. **Discover Available Components and Ask User Which Are Affected**
   - Use Bash to check for multi-component structure:
     ```bash
     find . -maxdepth 3 -name ".git" -type d
     ls -la .gitmodules 2>/dev/null
     ```
   - If multiple components found: list all and ask user which are affected
   - Options: "root" | "all" | specific component names
   - **WAIT** for user response before proceeding
   - If single repository: automatically set to "root" only

6. **Generate Names**
   - Parse user description for key concepts
   - Create PascalCase name (e.g., "UserAuthentication")
   - Create kebab-case name for branch (e.g., "user-authentication")
   - Focus on user value, not implementation details

7. **Interactive Name Confirmation**
   - Display generated names to user for confirmation
   - Show: Feature folder name, Git branch name
   - Wait for user confirmation or alternative description
   - If alternative provided: regenerate names and ask again
   - Continue only after user approval

#### Phase 3: Template Setup & Execution
8. **Generate Sequential Feature Number & Create Workspace**
   ```bash
   NEXT_NUM=$(printf "%03d" $(($(ls -1d Context/Features/???-* 2>/dev/null | wc -l) + 1)))
   NUMBERED_FEATURE_NAME="${NEXT_NUM}-[ConfirmedFeatureName]"
   mkdir -p Context/Features/${NUMBERED_FEATURE_NAME}
   ```
   - Store numbered directory name for subsequent steps

9. **Copy Feature Template**
   ```bash
   cp ~/.ContextKit/Templates/Features/Spec.md Context/Features/[numbered-feature-directory]/Spec.md
   ```

10. **Create Git Branch in Current Directory**
    ```bash
    git checkout -b feature/${NEXT_NUM}-[confirmed-kebab-case-name]
    ```

11. **Create Branches in Additional Components**
    - For each additional component selected by user:
      ```bash
      cd [component-directory] && git checkout -b feature/${NEXT_NUM}-[confirmed-kebab-case-name]
      ```
    - Repeat for each selected component
    - Skip if user selected "root" only

12. **Execute Specification Template** (Spec.md Template Workflow)

    **Phase 0: Check Customization**
    - Read developer customizations section from Spec.md

    **Phase 1: Context Analysis & Guidelines Loading**
    - Use Read to read project Context.md
    - Extract project type, tech stack, development patterns
    - Use Glob to discover available guidelines: `Glob Context/Guidelines *.md`
    - For each found guideline: Use Read to load it
    - For workspace projects: Read workspace Context.md
    - Extract user requirements from original input

    **Phase 2: Specification Content Generation**
    - Use Edit to replace template header with specific feature information:
      - Title: "# Feature Specification: [Feature Name]"
      - Feature Branch: `feature/[prefix]-[kebab-case-name]`
      - Created: [Current Date]
      - Status: Draft
      - Input: [Original user description - verbatim, use triple quotes """]
    - Generate "As a [User Type], I want to [User Goal] so that [User Benefit]"
    - Include platform-specific context (iOS/macOS)
    - Create comprehensive Given/When/Then scenarios
    - Include Happy Path, Error Path, Edge Cases
    - Generate specific, testable requirements (FR-001, FR-002, etc.)

    **Phase 3: Business Validation & Scope Definition**
    - Focus on business value, avoid technical implementation details
    - Apply value validation checks (internal)
    - Generate clear scope boundaries:
      - IN SCOPE: Specific features with clear user value
      - OUT OF SCOPE: Exclude unnecessary features
    - Mark uncertainties with: 🚨 [NEEDS CLARIFICATION: specific question]

    **Phase 4: Validation & Completion**
    - Execute business validation gates:
      - User Value: Clear user problems solved
      - Scope Clarity: Well-defined boundaries
      - Testability: Requirements can be validated
    - Check all boxes in template validation section
    - Update execution status
    - Use Edit to remove entire boxed system instructions section
    - Use Edit to remove validation framework instructions box
    - Leave only clean feature specification content

13. **Extract and Resolve Clarification Points Interactively**
    - Use Grep to find clarification markers: `Grep "🚨 \\[NEEDS CLARIFICATION:" [numbered-feature-directory]/Spec.md`
    - If found: **FOR EACH CLARIFICATION** (one at a time):
      - Present specific question to user using standardized format
      - **WAIT for user response** (execution MUST stop)
      - Use Edit to replace the 🚨 marker with user's answer
      - Continue to next clarification
    - Confirm all markers removed

14. **Display Success Message**
    ```
    🎉 Specification created successfully!

    📁 Feature: [numbered-feature-directory-name]
    ✅ Created: [numbered-feature-directory]/Spec.md
    ✅ Git branch: feature/[XXX]-[confirmed-kebab-case-name]
    ✅ Branch created in selected affected components
    ✅ Applied constitutional principles from project guidelines
    ✅ All mandatory sections completed with project-specific content

    ✅ All specification clarifications resolved interactively

    🔗 Next Steps:
    1. Review [numbered-feature-directory]/Spec.md
    2. When satisfied: commit changes with git
    3. Run /ctxk:plan:2-research-tech to proceed
    ```

### Validation Gates
- Project Context.md exists?
- User confirmation obtained for feature naming?
- Feature workspace directory created successfully?
- Specification template copied and executed?
- System instructions removed from final Spec.md?
- Clarification points resolved interactively?
- User informed to review before proceeding?

---

## Phase 2: Technical Planning (`/ctxk:plan:2-research-tech`)

**Purpose**: SINGLE-RUN workflow combining research and architecture:
- Creates Tech.md containing both research findings AND technical architecture
- No halt - continuous execution from research through architecture design

### Execution Steps

#### Phase 0: Check Customization
1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section
   - Prioritize developer customizations if conflicts exist

#### Phase 1: Setup Validation & Prerequisites
2. **Check Project Setup**
   - Use Glob to verify Context.md exists
   - If missing: ERROR "Run /ctxk:proj:init first"

#### Phase 2: Feature Detection & Validation
3. **Detect Current Feature**
   - Use Bash to check current git branch: `git branch --show-current`
   - If on feature/[prefix]-[name] branch: extract feature name
   - If not on feature branch: ask user which feature to work on
   - Use Glob to find numbered feature directory

4. **Validate Prerequisites & Determine Workflow Stage**
   - Use Read to check Spec.md exists in numbered directory
   - If missing: ERROR "Run /ctxk:plan:1-spec first"
   - Check for 🚨 [NEEDS CLARIFICATION] markers in specification
   - If clarifications exist: WARN user to resolve them first
   - Use Glob to check if Research.md exists
   - If Research.md NOT found: **WORKFLOW STAGE = Research Phase**

#### Phase 2: Template Execution
3. **Copy Technical Planning Template**
   ```bash
   cp ~/.ContextKit/Templates/Features/Tech.md [numbered-feature-directory]/Tech.md
   ```

4. **Execute Technical Planning Template** (Tech.md Template Workflow)

   **Phase 0: Check Customization**
   - Read developer customizations section from Research.md

   **Phase 1: Knowledge Gap Identification**
   - Use Read to read current feature directory Spec.md
   - Extract: functional requirements, mentioned technologies, integrations
   - Use Read to read project Context.md
   - Extract: current tech stack, existing dependencies, architecture patterns
   - For workspace projects: Read workspace Context.md
   - Scan specification for mentioned technologies, frameworks, APIs
   - Identify external services and integration requirements
   - Mark unfamiliar patterns and architectural approaches
   - Launch comprehensive codebase integration agent:
     - Agent scope: Discovery, pattern analysis, integration planning
     - Use Glob/Grep to find existing models, views, services
     - Analyze architectural patterns, naming conventions
     - Determine integration requirements
     - Assess implementation complexity
     - Map data flow between feature and existing components

   **Phase 2: Active Knowledge Acquisition**
   - Launch technology research agents for each mentioned technology:
     - Use Task tool with subagent_type=general-purpose
     - Agent context: "[Technology] patterns and best practices"
     - **CRITICAL**: Instruct agents to RETURN findings as text, NOT create files
     - **Apple Platform Priority**: Prioritize developer.apple.com, wwdcnotes.com
     - Use WebSearch for official docs
     - Use iosfeeds.com/archive for Apple platform technologies
     - Return: versions, capabilities, limitations, integration approaches
     - **CRITICAL**: Document SPECIFIC URLs that informed findings
   - Launch API research agents for each external service:
     - Agent context: "[Service] API documentation, rate limits, pricing"
     - Use WebFetch for API docs
     - Return: capabilities, constraints, costs, integration complexity
     - **CRITICAL**: Include SPECIFIC DOCUMENTATION URLs with versions
   - Launch architecture pattern research agents:
     - Agent context: "Offline-first architecture patterns for iOS apps"
     - Use WebSearch for best practices
     - Return: implementation approaches, benefits, drawbacks, case studies
     - **CRITICAL**: Document SPECIFIC ARTICLES with exact URLs
   - **Wait for ALL agents to complete** before proceeding

   **Phase 3: Research Consolidation**
   - Use Edit to replace template header with specific feature information
   - Use Edit to document ALL technology research results from agents
   - Use Edit to document ALL API & service research results from agents
   - Use Edit to document codebase integration analysis from agents
   - Use Edit to document ALL architectural pattern research from agents

   **Phase 4: Completion**
   - Validate research completeness against specification
   - Generate research summary with key decisions
   - Use Edit to remove entire boxed system instructions section

7. **Clean Up Research Template**
   - Use Read to check if Research.md still contains system instructions
   - Search for "🤖 EXECUTION FLOW" or "VALIDATION & EXECUTION STATUS"
   - If system instructions remain: Use Edit to remove all boxed sections

8. **Validate Research Completion**
   - Use Read to verify research completion
   - Ensure all technologies mentioned in specification researched
   - Verify research findings documented with decisions and rationale

9. **HALT for User Review** (END EXECUTION - DO NOT PROCEED)
   ```
   🎉 Technical research completed!

   ✅ Created: Context/Features/[Name]/Research.md

   📋 What to do next:

   1️⃣  Review the research findings
   2️⃣  Continue by running this command again:
       /ctxk:plan:2-research-tech

   💡 Tips:
      - You can edit Research.md first, or continue immediately
      - If context usage above 60%, consider /compact or new chat
   ```

### SECOND RUN: Tech Architecture Phase

#### Phase 2 (continued): Feature Detection & Validation
4. **Validate Prerequisites & Determine Workflow Stage**
   - Use Glob to check if Research.md exists
   - If Research.md found:
     - Use Read to check if it contains system instructions
     - Search for "🤖 EXECUTION FLOW" or boxed instruction sections
     - If system instructions found: ERROR "Research.md incomplete"
     - If no system instructions (clean research document):
       - **WORKFLOW STAGE = Tech Architecture Phase**

#### Phase 4: Technical Architecture Planning
10. **Copy Technical Architecture Template**
    ```bash
    cp ~/.ContextKit/Templates/Features/Tech.md [numbered-feature-directory]/Tech.md
    ```

11. **Execute Technical Architecture Template** (Tech.md Template Workflow)

    **Phase 0: Check Customization**
    - Read developer customizations section from Tech.md

    **Phase 1: Prerequisites & Context Loading**
    - Use Read to read current feature directory Research.md
    - Extract: researched technology decisions, API constraints, patterns
    - Use Read to read current feature directory Spec.md
    - Extract: user flows, functional requirements, business constraints
    - Cross-reference with research findings
    - Use Read to read project Context.md
    - Extract: project type, existing architecture, tech stack preferences
    - For workspace projects: Read workspace Context.md
    - Use Glob to discover available guidelines: `Glob Context/Guidelines *.md`
    - For each guideline: Use Read to load and extract patterns

    **Phase 2: Architecture Design & Validation**
    - Apply Context/Guidelines Compliance Gates:
      - Package-first principle
      - ErrorKit integration
      - Code quality standards
      - Platform compliance
      - If any gate fails: DOCUMENT justification or ERROR "Simplify"
    - Design iOS/macOS Architecture with research-informed decisions:
      - SwiftUI structure: Views, ViewModels, navigation patterns
      - Data layer: SwiftData, CoreData, CloudKit, package-based
      - Service layer: API integration, business logic separation
      - For each decision: DOCUMENT rationale and alternatives
    - Generate implementation complexity assessment
    - Mark uncertain areas with 🚨 [NEEDS CLARIFICATION: ...]

    **Phase 3: Technical Plan Generation**
    - Use Edit to replace template header with specific feature information
    - Fill system overview section:
      - High-level architecture description
      - Core components with responsibilities
      - Data flow documentation
    - Complete implementation details sections:
      - SwiftUI structure with view hierarchy
      - Data layer design with storage strategy
      - Service layer with integration patterns
      - Platform-specific considerations (iOS/macOS)
    - Generate complexity assessment:
      - Technical complexity analysis
      - Risk assessment and mitigation
      - Dependency analysis (external and internal)

    **Phase 4: Validation & Completion**
    - Run technical validation gates:
      - Architecture supports all user scenarios?
      - Context/Guidelines standards maintained?
      - Dependencies reasonable and justified?
      - Performance implications acceptable?
    - Update technical plan status
    - Use Edit to remove entire boxed system instructions section

12. **Clean Up Technical Architecture Template**
    - Use Read to check if Tech.md still contains system instructions
    - If system instructions remain: Use Edit to remove all boxed sections

13. **Extract and Resolve Clarification Points Interactively**
    - Use Grep to find markers in Research.md: `Grep "🚨 \\[NEEDS CLARIFICATION:" Research.md`
    - Use Grep to find markers in Tech.md: `Grep "🚨 \\[NEEDS CLARIFICATION:" Tech.md`
    - If found in either file: **FOR EACH CLARIFICATION** (one at a time):
      - Present specific question to user
      - **WAIT for user response**
      - Use Edit to replace marker with user's answer in appropriate file
      - Continue to next clarification
    - Confirm all markers removed from both files

14. **Display Success Message**
    ```
    🎉 Technical architecture planning completed successfully!

    ✅ Existing: Context/Features/[Name]/Research.md
    ✅ Created: Context/Features/[Name]/Tech.md
    ✅ Applied Context/Guidelines standards
    ✅ All mandatory sections completed
    ✅ Technical template system instructions cleaned up

    ✅ All technical clarifications resolved interactively

    🔗 Next Steps:
    1. Review Context/Features/[Name]/Tech.md
    2. When satisfied: commit changes with git
    3. Run /ctxk:plan:3-steps to proceed
    ```

### Validation Gates

**First Run (Research Phase)**:
- Project Context.md exists?
- Feature specification exists and complete?
- No unresolved [NEEDS CLARIFICATION] markers in spec?
- Research.md doesn't exist yet?
- Research template copied and executed?
- Research.md system instructions cleaned up?
- User informed to review before continuing?

**Second Run (Tech Architecture Phase)**:
- Research.md exists and complete?
- Tech.md doesn't exist yet?
- Technical template copied and executed?
- Tech.md system instructions cleaned up?
- Clarification points resolved from Research.md and Tech.md?
- User informed to review before proceeding?

---

## Phase 3: Implementation Steps (`/ctxk:plan:3-steps`)

**Purpose**: Generate implementation task breakdown with S001-S999 enumeration, parallel execution markers, and dependency analysis.

### Execution Steps

#### Phase 0: Check Customization
1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section
   - Prioritize developer customizations if conflicts exist

#### Phase 1: Setup Validation & Prerequisites
2. **Check Project Setup**
   - Use Glob to verify Context.md exists
   - If missing: ERROR "Run /ctxk:proj:init first"

#### Phase 2: Feature Detection & Validation
3. **Detect Current Feature**
   - Use Bash to check current git branch: `git branch --show-current`
   - If on feature/[prefix]-[name] branch: extract feature name
   - If not on feature branch: ask user which feature
   - Use Glob to find numbered feature directory

4. **Validate Prerequisites**
   - Use Read to check Spec.md exists in numbered directory
   - Use Read to check Tech.md exists in numbered directory
   - Use Read to check Research.md exists in numbered directory
   - If any missing:
     ```
     ❌ Prerequisites not complete!

     - Run /ctxk:plan:1-spec if Spec.md is missing
     - Run /ctxk:plan:2-research-tech if Tech.md is missing
     ```
   - Check for 🚨 [NEEDS CLARIFICATION] markers in all three files
   - If clarifications exist: WARN user to resolve them first

#### Phase 3: Template Setup & Execution
5. **Copy Steps Template**
   ```bash
   cp ~/.ContextKit/Templates/Features/Steps.md [numbered-feature-directory]/Steps.md
   ```

6. **Execute Steps Template** (Steps.md Template Workflow)

   **Phase 0: Check Customization**
   - Read developer customizations section from Steps.md

   **Phase 1: Prerequisites & Planning Analysis**
   - Use Read to read Research.md:
     - Extract: technology decisions, API constraints, integration patterns
     - Document technology limitations for implementation guidance
   - Use Read to read Tech.md:
     - Extract: architecture decisions, component structure, dependencies
     - Cross-reference with research findings
     - If 🚨 [NEEDS CLARIFICATION] markers exist: ERROR
   - Use Read to read Spec.md:
     - Extract: user stories, functional requirements, acceptance criteria
     - Map requirements to implementation tasks
   - Analyze implementation complexity and scope:
     - Count: new files, modified files, new APIs, tests needed
     - If scope > 25 tasks: WARN "Consider breaking into smaller features"
     - **Knowledge Gap Assessment**: Evaluate API documentation quality
       - Well-documented Apple APIs = Low Risk
       - Community-documented technologies = Medium Risk
       - New/niche/poorly documented APIs = High Risk
     - Identify critical path and parallel opportunities

   **Phase 2: Task Generation & Organization**
   - Apply task generation rules with research-informed constraints:
     - Apply technology limitations from research
     - Include integration patterns from codebase analysis
     - Consider performance implications from research
     - **AI-Assisted Development Considerations**: Factor knowledge gaps
     - One task per file creation/modification
     - One task per API endpoint implementation
     - One task per data model definition
     - One task per significant UI component
     - TDD approach: tests before implementation
     - **Xcode Project Management**:
       - Target creation/deletion = Manual user action
       - Scheme modifications = Manual user action when complex
       - Simple Info.plist updates = Automated task
       - Build setting changes = Automated when straightforward
   - Generate tasks with S### enumeration (S001, S002...):
     - Setup tasks: Project structure, dependencies, config (S001-S010)
     - Model tasks: Data layer with TDD (S011-S020)
     - Service tasks: Business logic and API integration (S021-S030)
     - UI tasks: SwiftUI views, navigation, interaction (S031-S040)
     - Integration tasks: **Automated testing only** (S041-S050)
     - Manual validation tasks: **User testing required** (S051-S060)
     - Polish tasks: Performance, compliance, release prep (S061-S070)
   - Apply parallel execution markers [P]:
     - Different files = [P] parallel safe
     - Same file = sequential only
     - Independent components = [P] parallel safe
     - Shared resources = sequential only
     - Tests can run [P] with implementation counterparts

   **Phase 3: Dependency Analysis & Validation**
   - Validate dependency chains with research constraints:
     - Apply external service dependencies from research
     - Include technology integration requirements
     - Models before Services before UI
     - Tests can run parallel with implementation
     - Configuration before usage
     - Critical path identified
     - No circular dependencies
   - Run iOS-specific task validation with research integration:
     - Include Apple best practices from research
     - Apply version compatibility requirements
     - Privacy manifest updates included?
     - Context/Guidelines validation tasks planned?
     - App Store compliance tasks identified?

   **Phase 4: Implementation Plan Generation**
   - Use Edit to replace template header with specific feature information
   - Fill task breakdown sections with research-informed constraints:
     - Include technology version requirements in setup tasks
     - Apply API integration patterns to service tasks
     - Include codebase integration requirements
     - Setup & Configuration phase with exact file paths
     - Model Layer with TDD and parallel markers
     - Service Layer with dependency tracking
     - UI Layer with SwiftUI implementation tasks
     - **Automated Integration phase**: Only AI-executable tasks
       - **CRITICAL**: Build tasks specify "Use Task tool with build-project agent"
       - **CRITICAL**: Test tasks specify "Use Task tool with run-test-* agent"
     - **Manual User Testing phase**: Human app interaction with standardized format
     - **Milestone Commits**: Specify "Use Task tool with commit-changes agent"
     - Polish & Release Preparation with compliance tasks
   - Generate dependency analysis with external constraints:
     - Include external service dependencies and rate limits
     - Apply technology integration timing requirements
     - Critical path analysis with longest dependency chain
     - Parallel execution opportunities documentation
   - Create completion verification checklist with research validation:
     - Include technology implementation validation
     - Add performance verification criteria
     - **AI-Assisted Time Estimation**: Realistic estimates based on:
       - Claude Code execution speed (fast)
       - Human review time requirements
       - Knowledge gap risk factors
       - Expected correction cycles

   **Phase 5: Validation & Completion**
   - Run implementation validation gates with research compliance:
     - All research findings integrated into tasks?
     - Technology constraints reflected in dependencies?
     - API limitations incorporated into service tasks?
     - All requirements have implementation tasks?
     - All architecture components have creation tasks?
     - Context/Guidelines compliance tasks included?
     - Parallel tasks truly independent?
     - Each task specifies exact file path?
     - Dependency graph shows clear execution order?
   - Update implementation plan status
   - Use Edit to remove entire boxed system instructions section

7. **Extract and Resolve Clarification Points Interactively**
   - Use Grep to find markers in Steps.md: `Grep "🚨 \\[NEEDS CLARIFICATION:" Steps.md`
   - If found: **FOR EACH CLARIFICATION** (one at a time):
     - Present specific question to user
     - **WAIT for user response**
     - Use Edit to replace marker with user's answer
     - Continue to next clarification
   - Confirm all markers removed

8. **Display Success Message**
   ```
   🎉 Implementation task breakdown created successfully!

   ✅ Created: [numbered-feature-directory]/Steps.md
   ✅ Generated S### task enumeration with parallel markers
   ✅ All mandatory phases completed

   ✅ All implementation clarifications resolved interactively

   🔗 Next Steps:
   1. Review [numbered-feature-directory]/Steps.md
   2. When satisfied: commit changes with git
   3. Run /ctxk:impl:start-working (in new chat) to begin development
   ```

### Validation Gates
- Project Context.md exists?
- All prerequisites (Spec.md, Tech.md, Research.md) exist and complete?
- No unresolved 🚨 [NEEDS CLARIFICATION] markers?
- Steps template copied and executed?
- System instructions removed from final Steps.md?
- Clarification points resolved from Steps.md?
- User informed to review before proceeding?

---

## Phase 4: Development Execution (`/ctxk:impl:start-working`)

**Purpose**: Begin systematic development with context-aware setup, task analysis, and guided implementation based on Steps.md.

### Execution Steps

#### Phase 0: Check Customization
1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section
   - Prioritize developer customizations if conflicts exist

#### Phase 1: Prerequisites & Feature Detection
2. **Check Project Setup**
   - Use Glob to verify Context.md exists
   - If missing: ERROR "Run /ctxk:proj:init first"

3. **Detect Current Feature from Git Branch**
   ```bash
   git branch --show-current
   ```
   - If branch format is `feature/[prefix]-[kebab-case-name]`:
     - Extract full name (e.g., `feature/001-visionos26-modernization` → `001-visionos26-modernization`)
     - Set FEATURE_NAME variable for directory matching
   - If not on feature branch:
     ```
     ⚠️ Not on a feature branch!

     Current branch: [current_branch_name]
     Expected: feature/[prefix]-[feature-name]

     Continue anyway? (y/N):
     ```
     - Wait for user confirmation
     - If "N": EXIT
     - If "y": Ask user to specify feature name manually

4. **Validate Feature Planning Completion**
   - Use Bash to find numbered feature directory with flexible matching:
     ```bash
     # Try exact full name match first
     FEATURE_DIR=$(ls -d Context/Features/*/ | grep -i "[FEATURE_NAME]" | head -1)
     # If no match, try number-based matching
     if [[ -z "$FEATURE_DIR" ]]; then
       PREFIX=$(echo "[FEATURE_NAME]" | cut -d'-' -f1)
       FEATURE_DIR=$(ls -d Context/Features/${PREFIX}-*/ 2>/dev/null | head -1)
     fi
     ```
   - Use Read to check each required file exists:
     ```bash
     ls -la [numbered-feature-directory]/Spec.md
     ls -la [numbered-feature-directory]/Research.md
     ls -la [numbered-feature-directory]/Tech.md
     ls -la [numbered-feature-directory]/Steps.md
     ```
   - Use Read to verify Steps.md contains task breakdown (not empty)
   - If any file missing or empty:
     ```
     ❌ Feature planning incomplete!

     Complete the planning phases first:
     1. /ctxk:plan:1-spec
     2. /ctxk:plan:2-research-tech
     3. /ctxk:plan:3-steps
     ```

#### Phase 2: Context Loading & Environment Setup
5. **Load Development Context**
   - Use Read to read project Context.md
   - **DEEP ANALYSIS REQUIRED**: Understand project type, architecture, standards
   - Use Bash to check for workspace context:
     ```bash
     cd .. && find . -name "Context.md" -path "*/Context.md" | head -1
     ```
   - If workspace Context.md found: Use Read to load workspace overrides
   - **CRITICAL**: This context forms foundation for executing Steps.md tasks

6. **Verify Development Environment**
   ```bash
   git status --porcelain
   ```
   - If uncommitted changes exist:
     ```
     ⚠️ Uncommitted changes detected!

     Commit or stash changes before starting new work.
     Continue anyway? (y/N):
     ```
     - Wait for user confirmation
     - If "N": EXIT
     - If "y": Continue with warning

#### Phase 3: Steps.md-Driven Development Execution
7. **Load Complete Feature Context - DEEP UNDERSTANDING REQUIRED**
   - Use Read to read all planning files:
     ```
     Read [numbered-feature-directory]/Spec.md       # Business requirements
     Read [numbered-feature-directory]/Research.md   # Technical research
     Read [numbered-feature-directory]/Tech.md       # Technical architecture
     Read [numbered-feature-directory]/Steps.md      # PRIMARY TASK LIST
     ```
   - **CRITICAL - DEEP ANALYSIS REQUIRED**:
     - **From Spec.md**: Fully understand feature purpose, ALL user stories, acceptance criteria
     - **From Research.md**: Completely understand technology findings, API constraints
     - **From Tech.md**: Thoroughly understand architecture decisions, constraints
     - **From Steps.md**: **THIS IS THE PRIMARY TASK LIST**
   - **Parse Steps.md as Primary Task List**:
     - Identify ALL tasks with exact S### numbers
     - Parse completion status (checked/unchecked boxes)
     - Extract dependencies for each task
     - Note [P] parallel markers
     - Extract file paths and requirements

8. **Execute Steps.md Tasks Sequentially - NO SHORTCUTS ALLOWED**
   - **PRIMARY OBJECTIVE**: Follow Steps.md step-by-step as definitive task list
   - Find **first uncompleted task** in S001, S002, S003... sequence
   - **ABSOLUTE REQUIREMENT**: Do NOT skip tasks, do NOT choose "easier" tasks
   - **ABSOLUTE REQUIREMENT**: Do NOT assume tasks are complete
   - Check dependencies are satisfied:
     - Extract "Dependencies: S001, S002" from task description
     - Verify all dependency tasks completed (checked boxes in Steps.md)
     - If dependencies not met: Display which tasks need completion first
   - **CRITICAL RULE**: Steps.md is master plan - follow religiously
   - **NEVER SPEED UP**: Do NOT execute multiple steps at once
   - **NEVER ASSUME**: Do NOT assume tasks are simple or can be batched
   - **NEVER AUTOMATE THE PROCESS**: Each step requires individual attention
   - If no valid next task: Display completion status and guide to next phase
   - **Steps.md drives everything** - not just reference, it's execution plan

   **🚨 CRITICAL: TOKEN LIMITS ARE IRRELEVANT**
   - **NEVER optimize for token limits** - quality and thoroughness paramount
   - **NEVER rush through steps** to fit within session
   - **Session boundaries don't matter** - progress tracked in Steps.md
   - **Just ignore token limit concerns** - continue methodically
   - If context usage exceeds 80%: Pause and suggest `/compact`
   - If session ends due to token limit: User can resume (Steps.md has progress)
   - Entire workflow designed to be resumable across multiple sessions
   - **Each step deserves proper attention** - never sacrifice quality

9. **Execute Current Task from Steps.md - Follow Plan Exactly**

   **CRITICAL**: Current task comes from Steps.md - execute exactly as specified

   **For MANUAL REQUIRED Tasks** (marked with ⚠️ MANUAL REQUIRED):
   ```
   ═══════════════════════════════════════════════════
   ║ 👤 MANUAL TASK REQUIRED - [TaskNumber]
   ═══════════════════════════════════════════════════
   ║
   ║ 📋 TASK FROM STEPS.md: [Exact task description]
   ║ 📂 Files: [Exact file paths]
   ║ 🛠️ Manual steps required:
   ║ [Extract detailed instructions from Steps.md]
   ║
   ║ 📝 FULL CONTEXT:
   ║ • Feature purpose: [From Spec.md]
   ║ • Technical approach: [From Tech.md]
   ║ • Why this task: [From Steps.md]
   ║ • Current progress: [completed]/[total] tasks
   ║
   ║ Please complete this manual task exactly as specified.
   ║
   ║ Options:
   ║ ✅ 'done' - Completed (will mark as ✅ in Steps.md)
   ║ ⏭️  'skip' - Skip for now (breaks sequence)
   ║ ❓ 'help' - Show more detailed instructions
   ║ 🔙 'back' - Return to task selection
   ║
   ║ Status:
   ```

   **For AUTOMATED Tasks** (no manual markers):
   ```
   ═══════════════════════════════════════════════════
   ║ 🚀 AUTOMATED TASK - [TaskNumber]
   ═══════════════════════════════════════════════════
   ║
   ║ 📋 TASK FROM STEPS.md: [Exact description]
   ║ 📂 Files to modify: [Exact file paths]
   ║ 🎯 Acceptance criteria: [Criteria from Steps.md]
   ║ 🔗 Dependencies: [Dependencies listed]
   ║
   ║ 📝 FULL CONTEXT FOR IMPLEMENTATION:
   ║ • Feature specification: [From Spec.md]
   ║ • Technical architecture: [From Tech.md]
   ║ • Research findings: [From Research.md]
   ║ • Current progress: [completed]/[total] tasks
   ║
   ║ 🔧 IMPLEMENTATION APPROACH:
   ║ [How this will be implemented based on context]
   ║
   ║ Ready to execute this Steps.md task? (Y/n):
   ```

   **IMPORTANT**:
   - Task details come DIRECTLY from Steps.md - never modify
   - Use complete context from Spec.md, Tech.md, Research.md
   - Do NOT skip steps or take shortcuts
   - Wait for user confirmation before proceeding

#### Phase 4: Task Execution with Steps.md as Central Progress Tracker
10. **Execute Task Implementation with Complete Context**
    - **For Manual Tasks**: User delegation complete, mark as done in Steps.md
    - **For Automated Tasks**: Implement using complete context:
      - **Use ALL context from planning files**: Apply understanding from Spec, Tech, Research
      - Extract detailed task info from Steps.md: file paths, criteria, dependencies
      - Use Read to examine target files if they exist
      - Use Glob to discover guidelines: `Glob Context/Guidelines *.md`
      - For each guideline: Use Read to load and apply content
      - Apply constitutional principles relevant to task type
      - **Execute exactly as planned in Steps.md** - no shortcuts
      - Ensure implementation meets all criteria in Steps.md

11. **Update Steps.md Progress Tracking - CENTRAL TO WORKFLOW**
    - **IMMEDIATELY after task completion**: Use Edit to mark completed task:
      ```
      OLD: - [ ] **S001** [task description]
      NEW: - [x] **S001** [task description]
      ```
    - **Add completion timestamp**: Update task notes with completion time
    - **🚨 CRITICAL**: Steps.md is THE authoritative progress tracker
    - **Even if using TodoWrite**: Steps.md is real source of truth
    - TodoWrite is temporary session tracking - Steps.md persists across sessions
    - Verify checkbox update successful before proceeding
    - **Enables session continuity**: Any new session can resume by reading Steps.md

12. **Continue Sequential Execution - No Exit Until All Done**
    - **IMMEDIATELY after updating Steps.md**: Check for next sequential task
    - **Do NOT exit** - continue with next task in sequence per Steps.md
    - Display progress update:
    ```
    ✅ Task [TaskNumber] completed and marked in Steps.md!

    📊 Progress: [completed+1]/[total] tasks done per Steps.md
    🔄 Loading next task from Steps.md...
    ```
    - Return to Phase 3, Step 7 to determine next task
    - **Only exit when**:
      - ALL Steps.md tasks completed (all checkboxes checked)
      - Dependency blocking prevents any task execution
      - User explicitly requests to stop
    - **The goal**: Complete entire Steps.md task list systematically

13. **Quality Assurance Integration with Primary Agents**
    - **PRIMARY AGENTS FOR IMPLEMENTATION**: Use throughout development per Steps.md
      - `build-project` - Use when Steps.md mentions "build" or "compile"
      - `commit-changes` - Use at ALL milestone markers (🏁 MILESTONE)
      - `run-test-suite` / `run-specific-test` - Use when Steps.md specifies tests

    **Primary Agent Usage Examples**:
    ```
    # When Steps.md task says "build" or at Phase 5 validation:
    Use Task tool with build-project:
    "Execute project build and report status."

    # At every 🏁 MILESTONE marker in Steps.md:
    Use Task tool with commit-changes:
    "Analyze changes and create commit for [milestone description]."

    # When Steps.md specifies test execution:
    Use Task tool with run-test-suite:
    "Execute complete test suite and report results."

    Use Task tool with run-specific-test:
    "Run tests for LoginViewModel and report failures."
    ```

    - **When to use build-project**:
      - After implementing significant functionality
      - Before milestone commits to ensure code compiles
      - When Steps.md explicitly mentions "build validation"
      - After resolving dependency issues

    - **When to use commit-changes agent**:
      - At EVERY 🏁 MILESTONE marker in Steps.md (use Task tool)
      - After completing logical phase of work
      - When directed by Steps.md milestone instructions
      - Agent handles git analysis, formatting, commit message

    - **When to use run-test-* agents**:
      - When Steps.md Phase 5 tasks specify test execution
      - After implementing new test files
      - Before milestone commits when tests exist
      - When debugging failing tests

    - **If agents fail**: Focus on fixing specific issue, then re-run agent to verify

### Validation Gates

**Prerequisites**:
- ContextKit project setup complete?
- Git repository with feature branch active?
- All planning phases completed (Spec.md, Research.md, Tech.md, Steps.md)?
- Development environment verified and functional?

**Context Loading**:
- Project and workspace context loaded successfully?
- Constitutional principles identified for project type?
- Development patterns and standards accessible?

**Task Selection**:
- Implementation plan parsed successfully?
- Valid task selected with clear acceptance criteria?
- Task dependencies satisfied and ready for execution?

**Development Ready**:
- Quality assurance hooks enabled?
- Relevant guidelines referenced for task type?
- Development guidance displayed and ready to proceed?
- User confirmation received for selected task and approach?

---

## Phase 5: Commit Changes (`/ctxk:impl:commit-changes`)

**Purpose**: Delegate to specialized commit-changes agent for intelligent git analysis and commit execution.

### Execution Steps

1. **Read developer customizations**
   - Use Grep to find "👩‍💻 DEVELOPER CUSTOMIZATIONS" section
   - Prioritize developer customizations if conflicts exist

2. **Launch Commit Agent**
   - Use Task tool to launch `commit-changes` agent with no additional parameters
   - Agent handles:
     - All git analysis (status, diff, log)
     - Commit message generation
     - Commit execution
     - Structured summary of committed changes

3. **Forward Agent Response Exactly - NO ADDITIONAL TEXT**
   - **CRITICAL**: Display agent's response exactly as received
   - **FORBIDDEN**: Do NOT add summary, interpretation, preamble, or postamble
   - **FORBIDDEN**: Do NOT add phrases like "Here's the commit result:"
   - **FORBIDDEN**: Do NOT reformat or restructure agent's output
   - **OUTPUT ONLY**: Agent's raw response and nothing else
   - Agent already provides complete structured response:
     ```
     ✅ Successfully committed changes

     📝 Commit: [commit_hash]
     💬 Message: "[commit_message]"
     📂 Files: [number] files modified
     📊 Changes: +[lines_added] -[lines_deleted]
     ```

### Validation Gates
- Agent available (ContextKit agents set up with /ctxk:proj:init)?
- Git repository issues handled by agent
- Permission problems diagnosed by agent

---

## Workflow Timing Analysis

### Current Workflow Step Count

**Phase 1: Feature Specification** (~15 major steps)
- Phase 0: Check customization (1 step)
- Phase 1: Setup validation (1 step)
- Phase 2: Interactive feature definition (6 steps)
- Phase 3: Template setup & execution (6 steps including Spec.md template workflow with 15 sub-steps)
- Clarification resolution (1 step)

**Phase 2: Research & Technical Architecture** (~28 major steps across 2 runs)
- **First Run - Research** (~14 steps):
  - Phase 0-2: Setup and validation (4 steps)
  - Phase 3: Research execution (5 steps including Research.md template workflow with 16 sub-steps)
  - HALT for review
- **Second Run - Tech Architecture** (~14 steps):
  - Phase 2 continued: Validation (1 step)
  - Phase 4: Tech architecture (4 steps including Tech.md template workflow with 14 sub-steps)
  - Clarification resolution (1 step)

**Phase 3: Implementation Steps** (~8 major steps)
- Phase 0: Check customization (1 step)
- Phase 1: Setup validation (1 step)
- Phase 2: Feature detection (2 steps)
- Phase 3: Template execution (3 steps including Steps.md template workflow with 17 sub-steps)
- Clarification resolution (1 step)

**Phase 4: Development Execution** (~13 major steps + loop)
- Phase 0: Check customization (1 step)
- Phase 1: Prerequisites & feature detection (3 steps)
- Phase 2: Context loading (2 steps)
- Phase 3: Steps.md-driven execution (3 steps)
- Phase 4: Task execution loop (4 steps, repeats for each task in Steps.md)

**Phase 5: Commit Changes** (~3 steps)
- Read customizations (1 step)
- Launch commit agent (1 step)
- Forward agent response (1 step)

**Total Major Steps**: ~67 steps across 5 phases (excluding loops and template sub-workflows)

**Total Sub-Steps** (including template workflows): ~130+ steps

### Complexity Assessment

**HIGH COMPLEXITY AREAS** (time-consuming):
1. **Phase 2 Research** (First Run):
   - Multiple research agents launched in parallel
   - Codebase integration analysis
   - Technology, API, and pattern research
   - Research consolidation
   - **Estimated time**: 5-15 minutes (depends on agent count and research depth)

2. **Phase 2 Tech Architecture** (Second Run):
   - User review required between runs
   - Deep context loading (Research.md, Spec.md, Context.md, Guidelines)
   - Architecture design with compliance gates
   - Complexity assessment
   - **Estimated time**: 3-8 minutes (depends on architecture complexity)

3. **Phase 3 Steps Generation**:
   - Deep analysis of all planning files
   - Task breakdown with S### enumeration
   - Dependency analysis
   - Parallel marker application
   - **Estimated time**: 3-7 minutes (depends on feature complexity)

4. **Phase 4 Development Execution**:
   - Deep context loading from all planning files
   - Sequential task execution (loops through ALL tasks)
   - Quality agent integration
   - Progress tracking
   - **Estimated time**: Highly variable (10 minutes to multiple hours depending on task count)

**MEDIUM COMPLEXITY AREAS**:
1. **Phase 1 Spec Generation**:
   - Interactive user input
   - Name generation and confirmation
   - Template execution
   - **Estimated time**: 2-5 minutes

**LOW COMPLEXITY AREAS**:
1. **Phase 5 Commit**:
   - Simple agent delegation
   - **Estimated time**: 30 seconds - 1 minute

### User Interaction Points

**Required User Input** (workflow stops until user responds):
1. **Phase 1 - Spec**:
   - Git status confirmation (if uncommitted changes)
   - Feature/app description input
   - Affected components selection (multi-component projects)
   - Name confirmation
   - Clarification resolution (if any 🚨 markers)

2. **Phase 2 - Research** (First Run):
   - User review of Research.md (HALT point)
   - Must manually re-run command to continue

3. **Phase 2 - Tech** (Second Run):
   - Clarification resolution (if any 🚨 markers in Research.md or Tech.md)

4. **Phase 3 - Steps**:
   - Clarification resolution (if any 🚨 markers in Steps.md)

5. **Phase 4 - Development**:
   - Feature branch confirmation (if not on feature branch)
   - Uncommitted changes confirmation
   - Task execution confirmation (for automated tasks)
   - Manual task delegation (for manual tasks)
   - Manual testing validation (Phase 6 in Steps.md)

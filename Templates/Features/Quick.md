# Quick Task Template
<!-- Template Version: 3 | ContextKit: 0.1.0 | Updated: 2025-01-17 -->

## Description
Quick task planning template for smaller tasks, bug fixes, and focused improvements that need planning but don't require the full multi-file workflow (Spec/Tech/Steps). Includes interactive validation, codebase analysis, and may include online research.

════════════════════════════════════════════════════════════════════════════════
║ 🤖 SYSTEM INSTRUCTIONS - QUICK TASK TEMPLATE
════════════════════════════════════════════════════════════════════════════════
║
║ PURPOSE: This template guides AI assistants in creating quick task plans for
║ smaller tasks, bug fixes, and improvements that don't require the full
║ feature planning workflow. These tasks are substantial enough to need planning
║ but don't require separate Spec/Tech/Steps files.
║
║ EXECUTION FLOW:
║
║ Phase 1: Template Population (called by /ctxk:plan:quick)
║ ─────────────────────────────────────────────────────────────────────────────
║ This template is populated by the /ctxk:plan:quick command after interactive
║ validation with the user. The command handles:
║ - Gathering user input
║ - Analyzing codebase (may include online research)
║ - Interactive understanding validation
║ - Generating this file with confirmed understanding
║
║ 2. Populate Input section
║    - Use Edit to replace "[User's original description - verbatim]"
║    - Keep the original description exactly as provided
║    - Use triple quotes to preserve formatting
║
║ 3. Populate Understanding section
║    - Use Edit to replace summary with confirmed understanding
║    - Be as detailed as necessary - these tasks are smaller but substantial
║    - Fill In Scope items (as many as needed for clarity)
║    - Fill Out of Scope items (clearly define boundaries)
║    - Fill Edge Cases (all relevant edge cases to consider)
║    - This section was already validated with user in chat
║
║ 4. Populate Code Context section
║    - Use Edit to add relevant file paths with line numbers
║    - Document current patterns found in codebase
║    - Note integration points and dependencies
║    - Include as much context as needed for understanding
║    - **If online research was conducted**: Populate Research Sources subsection with:
║      - Technology/framework names with URLs and versions
║      - Documentation or article URLs with access dates
║    - **If NO online research was needed**: Remove Research Sources subsection entirely
║
║ 5. Populate Implementation Approach section
║    - Use Edit to add detailed technical approach
║    - Document key decisions and rationale
║    - Reference architectural patterns from Context.md
║    - Include any research findings or online resources consulted
║    - Be thorough - if the task needed ContextKit, it needs proper planning
║
║ 6. Populate Tasks section
║    - Use Edit to generate specific tasks (as many as needed)
║    - Each task should be actionable with clear acceptance criteria
║    - Include file paths where applicable
║    - Optionally add build validation task (using Task tool with build-project agent)
║
║ 7. Clean up template
║    - Use Edit to remove this entire boxed section
║    - Leave only the content sections
║
║ Phase 2: Manual Execution (User-driven)
║ ─────────────────────────────────────────────────────────────────────────────
║ Users work through the task list manually:
║ - Check off tasks as completed
║ - Add notes to the Notes section as needed
║ - Optionally use Task tool with build-project agent to verify compilation
║ - Commit changes manually with git
║
║ VALIDATION CHECKLIST:
║ ─────────────────────────────────────────────────────────────────────────────
║ Before removing this section, verify:
║ - [ ] Input section filled with verbatim user description
║ - [ ] Understanding section filled with confirmed scope (as detailed as needed)
║ - [ ] In Scope clearly defines what will be addressed
║ - [ ] Out of Scope clearly defines boundaries
║ - [ ] Edge Cases identifies relevant considerations
║ - [ ] Code Context includes relevant files and patterns
║ - [ ] Implementation Approach is thorough and clear
║ - [ ] Tasks section has actionable items with clear criteria
║ - [ ] All placeholder text replaced
║ - [ ] This boxed section removed
║
════════════════════════════════════════════════════════════════════════════════

# Quick Task: [TaskName]

---

## 📋 Input

"""
[User's original description - verbatim]
"""

---

## 🎯 Understanding (Confirmed)

[Summary of what needs to be done - as detailed as necessary]

### In Scope ✅

- [Item that will be addressed]
- [Item that will be addressed]
- [Item that will be addressed]

### Out of Scope ❌

- [Related item that won't be addressed in this task]
- [Future consideration that's excluded]
- [Aspect that's intentionally not included]

### Edge Cases 🔍

- [Potential edge case to consider during implementation]
- [Edge case that might occur]
- [Boundary condition to watch for]

---

## 🔍 Code Context

**Relevant Files:**
- `path/to/file.swift:123` - [Why this file is relevant]
- `path/to/another.swift:45` - [Why this file is relevant]

**Current Patterns:**
- [How the relevant code currently works]
- [Existing patterns to follow or avoid]

**Integration Points:**
- [Where this change connects to other parts of the codebase]
- [Dependencies or impacts to be aware of]

**Research Sources** (if online research was conducted):
- [Technology/Framework Name]: [URL] - [Version/Date if applicable]
- [Documentation/Article]: [URL] - [Date accessed]
(Remove this subsection entirely if no online research was needed)

---

## 💡 Implementation Approach

[Technical approach description - as detailed as needed]

[Key technical decisions and their rationale]

[Any relevant research findings or considerations]

---

## ✅ Tasks

- [ ] Task 1: [Specific action with file path if applicable]
- [ ] Task 2: [Specific action with file path if applicable]
- [ ] Task 3: [Specific action with file path if applicable]
- [ ] Build validation (optional: Use Task tool with build-project agent)

---

## 📝 Notes

[Optional section for additional context, links, or observations during implementation]

---

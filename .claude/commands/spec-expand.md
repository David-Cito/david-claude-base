---
description: Expand analyzed spec into 3-document structure (specs, tasks, progress)
---

Expand the analyzed specification into a complete documentation structure for implementation.

## Input

$ARGUMENTS

If no arguments provided, read `PROJECT-SPEC.md` or `stretchflow-spec.md` from the project root.

**Prerequisites:**
- Run `/spec-analyze` first to ensure no gaps remain
- Spec should have DO/DO NOT sections for each feature

## Output Structure

Generate three categories of documentation:

```
docs/
├── specs/                    # Feature specifications
│   ├── 00-overview.md        # Project overview and scope
│   ├── 01-tech-stack.md      # Technology decisions
│   ├── 02-data-model.md      # Data structures and storage
│   ├── 03-feature-name.md    # Per-feature detailed spec
│   └── ...
│
├── tasks/                    # Implementation task lists
│   ├── PROGRESS.md           # Central tracking + parallel order
│   ├── phase-1-foundation.md # Phase task files
│   ├── phase-2-feature.md
│   └── ...
│
└── future/
    └── POST-MVP.md           # Deferred features (DO NOT BUILD)
```

---

## Document 1: Feature Specs (docs/specs/)

### 00-overview.md

Include:
- **Project Summary**: One paragraph description
- **MVP Scope**: What's IN and what's OUT
- **User Flows**: High-level user journeys
- **Routes/Pages**: Application navigation structure
- **Data Limits**: Constraints (max items, file sizes, etc.)
- **Design Principles**: Key UX/technical guidelines

### 01-tech-stack.md

Include:
- **Frontend**: Framework, styling, state management
- **Backend/Storage**: Database, APIs, auth
- **Build Tools**: Bundler, testing, linting
- **Third-Party**: External services and SDKs
- **Why These Choices**: Brief rationale

### 02-data-model.md

Include:
- **Entity Definitions**: All data types with fields
- **Relationships**: How entities connect
- **Storage Strategy**: Where data lives (localStorage, IndexedDB, etc.)
- **Validation Rules**: Required fields, constraints
- **Migration Strategy**: How to handle schema changes

### Per-Feature Specs (03-xxx.md, 04-xxx.md, ...)

For each major feature:
- **Overview**: What this feature does
- **User Stories**: As a user, I want to...
- **Acceptance Criteria**: Specific testable requirements
- **UI/UX Details**: Screens, interactions, states
- **Data Requirements**: What data is needed
- **Edge Cases**: Explicitly handled scenarios
- **DO NOT**: Out of scope items
- **Dependencies**: What must be built first

---

## Document 2: Task Files (docs/tasks/)

### Task File Format

Each phase file (phase-X-name.md) contains tasks in this format:

```markdown
# Phase X: Phase Name

## Overview
Brief description of what this phase accomplishes.

## Prerequisites
- [ ] What must be complete before starting this phase

---

## Task X.1: Task Name

**Agent**: frontend-architect | backend-architect
**Depends On**: Task IDs that must complete first
**Blocks**: Task IDs that wait on this

### Objective
One sentence describing the goal.

### Steps
- [ ] Step 1: Specific action
- [ ] Step 2: Specific action
- [ ] Step 3: Specific action

### DO NOT
- Don't do X
- Don't add Y
- Keep it simple

### Verification
How to confirm this task is complete:
- [ ] Verification step 1
- [ ] Verification step 2

### Post-Completion
- [ ] Run code-reviewer for quality check
- [ ] Run test-engineer to write tests

---

## Task X.2: Next Task Name
...
```

### Task ID Format

Use format: `[Phase Letter][Task Number]`
- F1, F2, F3... = Foundation tasks
- A1, A2, A3... = Feature A tasks (e.g., Spotify)
- B1, B2, B3... = Feature B tasks (e.g., Stretches)
- etc.

### Phase Structure Guidelines

- **Phase 1: Foundation** - Project setup, core infrastructure
- **Phase 2: Features** - Can often be parallel tracks (2A, 2B, 2C)
- **Phase 3: Integration** - Combining features
- **Phase 4: Polish** - UX refinement, edge cases
- **Phase 5: Release** - Testing, security audit, deployment

---

## Document 3: Progress Tracker (docs/tasks/PROGRESS.md)

### Format

```markdown
# Build Progress

## Overall Status
🟡 In Progress | Phase X of Y

## Phase Status

| Phase | Status | Progress | Blocking |
|-------|--------|----------|----------|
| Phase 1: Foundation | ✅ Complete | 5/5 | - |
| Phase 2A: Feature A | 🟡 In Progress | 2/4 | - |
| Phase 2B: Feature B | ⏳ Waiting | 0/3 | 2A.1 |
| Phase 3: Integration | ⏸️ Not Started | 0/5 | 2A, 2B |

## Parallel Execution

Phases that can run simultaneously:
- Phase 2A and 2B (both depend only on Phase 1)

Phases that must be sequential:
- Phase 3 requires all Phase 2 tracks complete

## Dependency Graph

```
Phase 1 ──┬── Phase 2A ──┐
          │              ├── Phase 3 ── Phase 4 ── Phase 5
          └── Phase 2B ──┘
```

## Current Focus
Next task to work on: [Task ID] - [Task Name]

## Completed Tasks
- [x] F1: Project setup
- [x] F2: Core components
```

---

## Document 4: Post-MVP (docs/future/POST-MVP.md)

### Format

```markdown
# Post-MVP Features

> ⚠️ **DO NOT BUILD THESE** during MVP development.
> This file exists to explicitly defer scope.

## Deferred Features

### Feature Name
**Why Deferred**: Reason it's not in MVP
**Prerequisites**: What MVP work enables this
**Estimated Effort**: Rough complexity
**Notes**: Any relevant context

### Another Feature
...

## Nice-to-Haves (If Time Permits)
- Small enhancement 1
- Small enhancement 2

## Future Considerations
Long-term features to keep in mind for architecture decisions.
```

---

## Generation Process

1. **Read the analyzed spec** with DO/DO NOT sections
2. **Identify features** and their dependencies
3. **Group into phases** based on dependencies
4. **Generate spec files** with detailed requirements
5. **Generate task files** with actionable checklists
6. **Generate progress tracker** with parallel execution diagram
7. **Generate POST-MVP** with explicitly deferred features

## Key Principles

- **Tasks are atomic**: Each can be completed in one session
- **Dependencies are explicit**: No hidden prerequisites
- **DO NOT sections prevent scope creep**: What NOT to build
- **Quality gates are built-in**: code-reviewer + test-engineer after each task
- **Parallel work is identified**: What can run simultaneously

## After Running This Command

1. Review generated documentation for accuracy
2. Adjust phase organization if needed
3. Begin implementation with Phase 1
4. Run `/phase-gate` between phases
5. Update PROGRESS.md as tasks complete

---
description: Analyze spec, ask clarifying questions, then expand into docs/tasks/progress structure
---

Analyze the specification, ask clarifying questions until all gaps are resolved, then expand into a complete documentation structure for implementation.

## Input

$ARGUMENTS

If no arguments provided, read `PROJECT-SPEC.md` or `stretchflow-spec.md` from the project root.

---

# STEP 0: CREATE SELF-TRACKING PROGRESS FILE

**FIRST**, create `spec-expand-progress.md` in the **same folder as the spec file** to track your progress.

Example:
- Spec at `docs/plans/my-feature/spec.md` → Create `docs/plans/my-feature/spec-expand-progress.md`
- Spec at `PROJECT-SPEC.md` (root) → Create `spec-expand-progress.md` (root)

All generated docs (specs/, tasks/, future/) will also be created relative to this same folder.

```markdown
# Spec Expand Progress

> This file tracks the spec-expand command execution.
> Check off items as you complete them. Delete nothing until all items are checked.
> This file will be automatically deleted when /auto-build starts.

## Spec Location
- Spec file: [full path to spec file]
- Output folder: [folder where spec file lives]

## Phase 1: Clarification
- [ ] Read spec file
- [ ] Read CLAUDE.md for project context
- [ ] Scan for existing implementations
- [ ] Identify all gaps (list categories found)
- [ ] Ask Question 1 (using AskUserQuestion tool)
- [ ] Ask Question 2
- [ ] Ask Question 3
- [ ] Ask Question 4
- [ ] Ask Question 5
- [ ] Ask additional questions until confident (list count)
- [ ] Announce "Clarification Complete" with total question count

## Phase 2: Document Generation
- [ ] Generate specs/00-diagrams.md (use system-architect)
- [ ] Generate specs/01-overview.md
- [ ] Generate specs/02-tech-stack.md
- [ ] Generate specs/03-data-model.md
- [ ] Generate specs/04+ feature spec files
- [ ] Generate tasks/phase-1-foundation.md
- [ ] Generate tasks/phase-2+ files
- [ ] Generate tasks/PROGRESS.md with build path diagram
- [ ] Generate future/POST-MVP.md
- [ ] Run completeness verification
- [ ] Display coverage report

## Metadata
- Started: [timestamp]
- Questions asked: [count]
- Status: 🟡 IN PROGRESS
```

**Update this file as you complete each step.** Mark items with `[x]` when done.

---

# PHASE 1: ANALYSIS & CLARIFICATION (REQUIRED)

**DO NOT generate any documentation until this phase is complete.**

```
┌─────────────────────────────────────────────────────────────────┐
│                  CLARIFICATION LOOP                             │
├─────────────────────────────────────────────────────────────────┤
│  1. Read spec + existing files                                  │
│  2. Identify ALL gaps, ambiguities, undefined behaviors         │
│  3. Ask user 3-5 clarifying questions                           │
│  4. User answers                                                │
│  5. AI evaluates: "Are there still gaps that could cause        │
│     me to hallucinate or build unwanted features?"              │
│     ├── YES → Ask more questions (loop back to step 3)          │
│     └── NO  → Announce ready, proceed to Phase 2                │
└─────────────────────────────────────────────────────────────────┘
```

## Minimum Questions: 5

You MUST ask at least 5 clarifying questions **one at a time** before proceeding.

Use the **AskUserQuestion tool** for each question with selectable options.

Ask about:

- **Unclear requirements** - Features mentioned but not fully specified
- **Missing edge cases** - What happens when things fail? Empty states?
- **Ambiguous terminology** - Terms that could be interpreted multiple ways
- **Undefined error handling** - How should errors be displayed/handled?
- **Scope boundaries** - What's explicitly IN vs OUT of scope?
- **Data validation** - Required fields, max lengths, formats?
- **User flows** - Complete steps from start to finish?
- **Success criteria** - How do we know when it's "done"?

## Gap Analysis Framework

Systematically identify:

### Missing Requirements
- Features mentioned but not fully specified
- User flows without complete steps
- Data models with undefined fields
- Edge cases not addressed

### Undefined Behaviors
- What happens when things fail?
- Empty states and zero-data scenarios
- Maximum limits not specified
- Error handling not defined

### Unclear Acceptance Criteria
- How do we know when it's "done"?
- What does success look like?
- How do we test this works?

### Ambiguous Terminology
- Terms used inconsistently
- Technical jargon without definitions
- Concepts that could be interpreted multiple ways

## Question Format

**USE THE AskUserQuestion TOOL** to ask questions one at a time with selectable options.

### How to Ask Questions

Use the AskUserQuestion tool with:
- **question**: The specific question to ask
- **options**: 2-4 selectable choices (user can also type custom answer)
- **header**: Short label (e.g., "Error Handling", "Scope", "Data")

### Ask Questions in Series

Ask ONE question at a time. Wait for the answer before asking the next question.

```
Question 1 → Wait for answer →
Question 2 → Wait for answer →
Question 3 → Wait for answer →
... continue until confident
```

### Example Questions with Options

**Question 1:**
- Header: "File Upload"
- Question: "What should happen when a user uploads an image larger than 10MB?"
- Options:
  - "Show error, reject upload"
  - "Auto-compress to under 10MB"
  - "Allow up to 25MB"
  - "No file uploads needed"

**Question 2:**
- Header: "Error Display"
- Question: "When login fails, how should errors be displayed?"
- Options:
  - "Generic 'Invalid credentials' message"
  - "Specific field errors (email/password)"
  - "Toast notification"
  - "Inline form errors"

**Question 3:**
- Header: "Scope"
- Question: "Should user profiles include avatar uploads?"
- Options:
  - "Yes, required feature"
  - "Yes, but optional for MVP"
  - "No, out of scope"

### After Each Answer

After receiving each answer:
1. Update your understanding of the spec
2. Check if the answer revealed new gaps
3. Ask the next question OR announce ready if confident

## Continuous Loop

Keep asking questions ONE AT A TIME until:
- You've asked at least 5 questions
- No remaining areas where you might hallucinate
- Every feature is clear enough to implement without guessing

If ANY uncertainty remains → Ask another question.

## Anti-Drift Detailing

For each feature, ensure the spec includes (or you've clarified):

**Explicit "DO" List**
- Specific behaviors to implement
- Exact data to capture/display
- Precise user interactions

**Explicit "DO NOT" List**
- Features explicitly out of scope
- Over-engineering to avoid
- Future enhancements to defer

**Exact Behavior Descriptions**
- "When X happens, Y should occur"
- Specific UI states and transitions
- Error messages and handling

**Boundary Conditions**
- Minimum/maximum values
- Required vs. optional fields
- Supported formats and types

## Ready to Proceed

Only when you are confident there are NO remaining gaps, announce:

```
╔══════════════════════════════════════════════════════════════════╗
║  ✅ CLARIFICATION COMPLETE                                       ║
╠══════════════════════════════════════════════════════════════════╣
║  Questions asked: [X]                                            ║
║  Gaps resolved: [list key clarifications]                        ║
║                                                                  ║
║  I am confident there are no remaining areas where I could       ║
║  hallucinate or build unwanted features.                         ║
║                                                                  ║
║  Proceeding to document generation...                            ║
╚══════════════════════════════════════════════════════════════════╝
```

---

# PHASE 2: DOCUMENT GENERATION

## Working with Existing Files

Before generating new documentation:
1. **Scan for existing implementations** - Check for setup files, partial implementations, or config files related to the spec
2. **Inventory what exists** - List files that are already created or partially complete
3. **Build on top, don't duplicate** - Mark existing work as complete in generated tasks
4. **Reference existing code** - Link tasks to files that need modification vs. creation

## Output Structure

Generate three categories of documentation **in the same folder as the spec file**:

```
[spec-file-folder]/
├── spec-expand-progress.md   # Self-tracking (deleted by /auto-build)
│
├── specs/                    # Feature specifications
│   ├── 00-diagrams.md        # ASCII architecture/flow diagrams
│   ├── 01-overview.md        # Project overview and scope
│   ├── 02-tech-stack.md      # Technology decisions
│   ├── 03-data-model.md      # Data structures and storage
│   ├── 04-feature-name.md    # Per-feature detailed spec
│   └── ...
│
├── tasks/                    # Implementation task lists
│   ├── PROGRESS.md           # Central tracking + build path diagram
│   ├── phase-1-foundation.md # Phase task files
│   ├── phase-2-feature.md
│   └── ...
│
└── future/
    └── POST-MVP.md           # Deferred features (DO NOT BUILD)
```

**Example**: If spec is at `docs/plans/sentry-setup/spec.md`, output goes to:
- `docs/plans/sentry-setup/specs/00-diagrams.md`
- `docs/plans/sentry-setup/tasks/PROGRESS.md`
- `docs/plans/sentry-setup/future/POST-MVP.md`

---

## Document 1: Feature Specs (docs/specs/)

### 00-diagrams.md

**Agent**: system-architect (REQUIRED to create these diagrams)

Create ASCII diagrams for quick visual understanding of the system. Use these as reference examples:

#### System Architecture Diagram Example

```
┌─────────────────────────────────────────────────────────────────┐
│                         SYSTEM OVERVIEW                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────┐      ┌──────────────┐      ┌──────────────────┐   │
│  │  Client  │      │   Next.js    │      │    Supabase      │   │
│  │ (React)  │─────▶│   API Routes │─────▶│   PostgreSQL     │   │
│  │          │◀─────│              │◀─────│                  │   │
│  └──────────┘      └──────────────┘      └──────────────────┘   │
│       │                   │                       │              │
│       │                   │                       │              │
│       ▼                   ▼                       ▼              │
│  ┌──────────┐      ┌──────────────┐      ┌──────────────────┐   │
│  │   Auth   │      │   External   │      │     Storage      │   │
│  │  (MSAL)  │      │    APIs      │      │    (Buckets)     │   │
│  └──────────┘      └──────────────┘      └──────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### Feature Flow Diagram Example

```
USER LOGIN FLOW
═══════════════

┌────────┐    ┌────────────┐    ┌────────────┐    ┌───────────┐
│  Form  │───▶│  Validate  │───▶│  Auth API  │───▶│  Session  │
│ Input  │    │   Client   │    │   Call     │    │  Created  │
└────────┘    └────────────┘    └────────────┘    └───────────┘
                   │                  │                  │
                   ▼                  ▼                  ▼
              ┌────────┐        ┌──────────┐      ┌───────────┐
              │ Show   │        │  401/403 │      │ Redirect  │
              │ Errors │        │  Handle  │      │ Dashboard │
              └────────┘        └──────────┘      └───────────┘
```

#### Data Flow Diagram Example

```
DATA FLOW: CREATE ITEM
══════════════════════

     User Input          Validation           API              Database
         │                   │                 │                   │
         ▼                   │                 │                   │
    ┌─────────┐              │                 │                   │
    │  Form   │──────────────┼────────────────▶│                   │
    │  Data   │              │                 │                   │
    └─────────┘              │                 │                   │
         │                   ▼                 │                   │
         │              ┌─────────┐            │                   │
         │              │ Zod     │            │                   │
         │              │ Schema  │────────────┼──────────────────▶│
         │              └─────────┘            │                   │
         │                   │                 ▼                   ▼
         │                   │            ┌─────────┐        ┌─────────┐
         │                   │            │ INSERT  │───────▶│  Row    │
         │                   │            │ Query   │        │ Created │
         │                   │            └─────────┘        └─────────┘
         │                   │                 │                   │
         ◀───────────────────┴─────────────────┴───────────────────┘
                              Response / Error
```

#### State Machine Diagram Example

```
ITEM STATUS STATE MACHINE
═════════════════════════

                    ┌─────────────────────────────────┐
                    │                                 │
                    ▼                                 │
    ┌─────────┐   create   ┌─────────┐   submit   ┌─────────┐
    │  DRAFT  │───────────▶│ PENDING │───────────▶│ ACTIVE  │
    └─────────┘            └─────────┘            └─────────┘
         │                      │                      │
         │ delete               │ reject               │ complete
         ▼                      ▼                      ▼
    ┌─────────┐            ┌─────────┐            ┌─────────┐
    │ DELETED │            │REJECTED │───────────▶│COMPLETED│
    └─────────┘            └─────────┘   retry    └─────────┘
```

#### Component Hierarchy Example

```
COMPONENT TREE
══════════════

App
 ├── Layout
 │    ├── Header
 │    │    ├── Logo
 │    │    ├── Navigation
 │    │    └── UserMenu
 │    ├── Sidebar
 │    │    ├── NavLinks
 │    │    └── QuickActions
 │    └── Main (content area)
 │
 ├── Pages
 │    ├── Dashboard
 │    │    ├── StatsCards
 │    │    └── RecentActivity
 │    ├── Items
 │    │    ├── ItemList
 │    │    ├── ItemCard
 │    │    └── ItemForm
 │    └── Settings
 │
 └── Shared
      ├── Button
      ├── Modal
      ├── Toast
      └── LoadingSpinner
```

#### Guidelines for Diagrams

- **One diagram per major feature** OR one combined system diagram
- **Keep diagrams scannable** - fit within ~80 characters width
- **Use consistent symbols**:
  - `───▶` for data/control flow
  - `│` and `├──` for hierarchy/trees
  - `┌─┐ └─┘` for boxes/containers
  - `═══` for section headers
- **Label everything clearly**
- **Include error/alternate paths** when relevant
- **Show direction** - arrows indicate flow

---

### 01-overview.md

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

## Phase Gate
- [ ] Run `/phase-gate phase-X-name` after all tasks complete

---

## Task X.1: Task Name

**Agent**: frontend-architect | backend-architect | test-engineer | security-auditor
**REQUIRED** - Every task MUST specify an agent. Choose based on:
- `frontend-architect`: UI, components, pages, client-side logic
- `backend-architect`: API, database, server-side logic, integrations
- `test-engineer`: Writing and running tests
- `security-auditor`: Security reviews and audits

**Depends On**: Task IDs that must complete first
**Blocks**: Task IDs that wait on this
**Parallel Group**: Tasks with same group letter can run simultaneously (e.g., "A", "B")

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

**IMPORTANT**: When tasks have no dependencies between them, launch multiple agents simultaneously using parallel Task tool calls in a single message.

Phases that can run simultaneously:
- Phase 2A and 2B (both depend only on Phase 1)

Tasks within a phase that can run in parallel:
- Tasks with same "Parallel Group" letter
- Tasks with no shared dependencies

Phases that must be sequential:
- Phase 3 requires all Phase 2 tracks complete

## Build Path Diagram

**REQUIRED**: Visual representation of the entire build showing parallel vs sequential execution.

```
PHASE 1: FOUNDATION
┌─────────────────────────────────────────────────────────────────┐
│  ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐           │
│  │ F1  │───▶│ F2  │───▶│ F3  │───▶│ F4  │───▶│ F5  │           │
│  │Setup│    │Config│   │Core │    │Layout│   │Route│           │
│  └─────┘    └─────┘    └─────┘    └─────┘    └─────┘           │
└─────────────────────────────────────────────────────────────────┘
                                   │
                    ┌──────────────┴──────────────┐
                    ▼                             ▼
PHASE 2A: AUTH                    PHASE 2B: API (PARALLEL TRACK)
┌───────────────────────────┐     ┌───────────────────────────┐
│  ┌─────┐ ┌─────┐ ┌─────┐  │     │  ┌─────┐ ┌─────┐ ┌─────┐  │
│  │ A1  │▶│ A2  │▶│ A3  │  │     │  │ B1  │▶│ B2  │▶│ B3  │  │
│  │Login│ │Token│ │Guard│  │     │  │Endpt│ │Valid│ │Error│  │
│  └─────┘ └─────┘ └─────┘  │     │  └─────┘ └─────┘ └─────┘  │
└───────────────────────────┘     └───────────────────────────┘
            │                                 │
            └─────────────┬───────────────────┘
                          ▼
PHASE 3: INTEGRATION
┌─────────────────────────────────────────────────────────────────┐
│  ┌─────┐         ┌─────┐         ┌─────┐                       │
│  │ I1  │────────▶│ I2  │────────▶│ I3  │                       │
│  │Wire │         │Test │         │Verify│                      │
│  └─────┘         └─────┘         └─────┘                       │
└─────────────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 4: POLISH ────▶ PHASE 5: RELEASE ────▶ 🚀 SHIP
```

### Reading the Build Path Diagram

| Symbol | Meaning |
|--------|---------|
| `───▶` or `▶` | Sequential: must complete before next |
| Side-by-side boxes | Parallel: run simultaneously |
| `│` with `▼` | Phase dependency: wait for above |
| `┌─────┐` boxed groups | Tasks within same execution context |

### Parallel Execution Visual

Tasks that can run in parallel are shown **side-by-side at the same level**:

```
PARALLEL TASKS (run in ONE message with multiple Task calls):
┌─────────────────────────────────────────────────────────────┐
│  ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐                  │
│  │ T1  │    │ T2  │    │ T3  │    │ T4  │  ◀── ALL AT ONCE │
│  └─────┘    └─────┘    └─────┘    └─────┘                  │
└─────────────────────────────────────────────────────────────┘
                          │
                          ▼
SEQUENTIAL TASK (runs after all above complete):
┌─────────────────────────────────────────────────────────────┐
│                       ┌─────┐                               │
│                       │ T5  │  ◀── WAITS FOR T1-T4          │
│                       └─────┘                               │
└─────────────────────────────────────────────────────────────┘
```

## Phase Gates (DO NOT SKIP)

After completing all tasks in a phase, run the gate before proceeding:

- [ ] `/phase-gate phase-1-foundation` - Run after Phase 1 complete
- [ ] `/phase-gate phase-2a-feature-a` - Run after Phase 2A complete
- [ ] `/phase-gate phase-2b-feature-b` - Run after Phase 2B complete
- [ ] `/phase-gate phase-3-integration` - Run after Phase 3 complete
- [ ] `/phase-gate phase-4-polish` - Run after Phase 4 complete
- [ ] `/phase-gate phase-5-release` - FINAL gate before ship

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

## Full Process (Both Phases)

### Phase 1: Analysis & Clarification
1. **Read spec and CLAUDE.md** - Understand project context and constraints
2. **Scan for existing files** - Check what's already implemented
3. **Identify all gaps** - Missing requirements, undefined behaviors, ambiguities
4. **Ask clarifying questions** - Minimum 5, in batches of 3-5
5. **Loop until confident** - Keep asking until no areas remain where AI could drift
6. **Announce ready** - Display completion message, proceed to Phase 2

### Phase 2: Document Generation
7. **Identify features** and their dependencies
8. **Group into phases** based on dependencies
9. **Assign agents to every task** - No task without an agent
10. **Identify parallel groups** - Mark tasks that can run simultaneously
11. **Generate 00-diagrams.md** - Use system-architect to create ASCII diagrams:
    - System architecture overview
    - Feature flow diagrams for each major feature
    - Data flow or state machine diagrams as needed
12. **Generate spec files** with detailed requirements
13. **Generate task files** with actionable checklists
14. **Generate progress tracker** with:
    - Build path diagram showing parallel vs sequential
    - Embedded phase gates
    - Parallel execution notes
15. **Generate POST-MVP** with explicitly deferred features
16. **Run completeness verification** (see below)

## Completeness Verification

After generating all documentation, verify nothing was missed:

```markdown
## Coverage Report

### Spec Items → Task Mapping
| Spec Requirement | Task ID | Status |
|-----------------|---------|--------|
| User authentication | F2, F3 | ✅ Covered |
| API integration | A1, A2 | ✅ Covered |
| Error handling | B3 | ✅ Covered |
| [Requirement] | [Task] | ✅ Covered / ❌ Missing |

### Verification Checklist
- [ ] Every spec requirement has at least one task
- [ ] Every task has an assigned agent
- [ ] Every phase has a gate checkpoint in PROGRESS.md
- [ ] Parallel groups are identified for independent tasks
- [ ] Existing files are referenced (not recreated)
```

If any items show ❌ Missing, add tasks before proceeding.

## Key Principles

- **Clarify before building**: Ask questions until no ambiguity remains
- **AI decides readiness**: The AI determines when clarification is complete, not the user
- **Minimum 5 questions**: Never skip the clarification phase
- **Tasks are atomic**: Each can be completed in one session
- **Dependencies are explicit**: No hidden prerequisites
- **DO NOT sections prevent scope creep**: What NOT to build
- **Quality gates are built-in**: code-reviewer + test-engineer after each task
- **Parallel work is maximized**: Run independent tasks simultaneously
- **Agents are mandatory**: Every task specifies which agent executes it
- **Completeness is verified**: Cross-reference spec → tasks before starting

## Final Step: Mark Self-Tracking Complete

After all documents are generated, update `docs/tasks/spec-expand-progress.md`:

```markdown
## Metadata
- Started: [timestamp]
- Completed: [timestamp]
- Spec file: [filename]
- Questions asked: [count]
- Documents generated: [count]
- Status: ✅ COMPLETE
```

This file will be automatically deleted when `/auto-build` starts.

---

## After Running This Command

1. Answer all clarifying questions from Phase 1
2. Wait for AI to announce "Clarification Complete"
3. Review generated documentation for accuracy
4. Adjust phase organization if needed
5. Begin implementation with `/auto-build` or manually
6. Run `/phase-gate` between phases
7. Update PROGRESS.md as tasks complete

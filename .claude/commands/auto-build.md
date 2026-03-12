---
description: Automated build - runs tasks with parallel execution and phase gates
---

# Auto-Build

Run the entire build automatically with maximum parallelization.

## Arguments

$ARGUMENTS

Options:
- `--dry-run` - Show next 5 tasks without executing
- `--sequential` - Force one-by-one execution (default is parallel)
- (no args) - Start or resume automated build with parallel execution

---

## Process Overview

```
┌─────────────────────────────────────────────────────────┐
│                    AUTO-BUILD LOOP                      │
├─────────────────────────────────────────────────────────┤
│  0. CLEANUP   → Delete spec-expand tracking file        │
│  1. READ      → Parse PROGRESS.md for current state     │
│  2. FIND      → Get ALL uncompleted tasks               │
│  3. ANALYZE   → Identify tasks that can run in parallel │
│  4. EXECUTE   → Run parallel tasks simultaneously       │
│                 (single message, multiple Task calls)   │
│  5. UPDATE    → Mark tasks complete in files            │
│  6. CHECK     → If phase complete, run /phase-gate      │
│  7. CONTINUE  → If gate passes, next batch              │
│  8. STOP      → If gate fails, report issues            │
│  9. LOOP      → Repeat until done or failure            │
└─────────────────────────────────────────────────────────┘
```

## Parallel Execution (Default Mode)

**CRITICAL**: When tasks have no dependencies between them, launch multiple agents simultaneously.

To run tasks in parallel:
1. Identify tasks with no blocking dependencies
2. Check for same "Parallel Group" letter or independent tasks
3. Use a **single message with multiple Task tool calls**
4. Wait for all parallel tasks to complete
5. Then proceed to dependent tasks

Example parallel execution:
```
Task A1 (no deps) ──┐
Task A2 (no deps) ──┼── Run simultaneously in ONE message
Task A3 (no deps) ──┘
                    ↓
Task A4 (depends on A1, A2, A3) ── Run after all above complete
```

---

## Step 0: Cleanup Spec-Expand Tracking

**FIRST**, delete the spec-expand self-tracking file if it exists:

```bash
rm -f .claude/spec-expand-progress.md
```

This cleans up the tracking file from the `/spec-expand` command since we're now moving to build phase.

---

## Step 1: Read Current State

Read `docs/tasks/PROGRESS.md` and extract:
- Current phase (the first phase with uncompleted tasks)
- All task statuses across phases
- Any noted blockers or dependencies

Parse format:
```
## Phase N: [Name]
- [x] Task 1 (completed)
- [ ] Task 2 (next to do)
- [ ] Task 3 (pending)
```

---

## Step 2: Handle --dry-run Mode

If `$ARGUMENTS` contains `--dry-run`:

1. Parse all phases and tasks from PROGRESS.md
2. Identify the next 5 uncompleted tasks in order
3. For each task, read its details from the phase file
4. Display preview:

```
╔══════════════════════════════════════════════════════════╗
║               AUTO-BUILD DRY RUN                         ║
╠══════════════════════════════════════════════════════════╣
║  Current Phase: Phase N - [Name]                         ║
║  Completed: X/Y tasks                                    ║
╠══════════════════════════════════════════════════════════╣
║  NEXT 5 TASKS:                                           ║
║                                                          ║
║  1. [Task Name]                                          ║
║     Agent: frontend-architect | backend-architect        ║
║     File: docs/tasks/phase-N-name.md                     ║
║                                                          ║
║  2. [Task Name]                                          ║
║     Agent: ...                                           ║
║     ...                                                  ║
║                                                          ║
║  [PHASE GATE after task X]                               ║
║                                                          ║
║  3. [Task Name] (Phase N+1)                              ║
║     ...                                                  ║
╚══════════════════════════════════════════════════════════╝
```

5. **STOP after displaying preview** - do not execute any tasks

---

## Step 3: Find Executable Tasks

If NOT dry-run, find ALL tasks that can execute now:

1. Parse PROGRESS.md for all uncompleted tasks (`- [ ]`)
2. For each task, check its dependencies (Depends On / Blocked By)
3. Build a list of tasks with NO unmet dependencies
4. Group tasks by "Parallel Group" letter if specified
5. Read corresponding phase files for task details

For each executable task, extract:
- Task description
- Acceptance criteria
- **Agent** (REQUIRED - must be specified in task)
- Dependencies and blockers

**Agent Selection Rules (MANDATORY):**

Every task MUST have an agent. If missing from task file, assign based on:

| Task Type | Agent |
|-----------|-------|
| UI, components, pages, styling | `frontend-architect` |
| API, database, server logic | `backend-architect` |
| Writing/running tests | `test-engineer` |
| Security review, auth, audits | `security-auditor` |
| System design, architecture | `system-architect` |
| Documentation | `technical-writer` |

**NEVER skip agent assignment. ALWAYS use the correct agent for the task type.**

---

## Step 4: Execute Tasks (Parallel When Possible)

### Parallel Execution (Default)

When multiple tasks have no dependencies, execute them simultaneously:

```
Send a SINGLE message with MULTIPLE Task tool calls:

<Task 1>
- subagent_type: frontend-architect
- prompt: [Task A1 details...]
- description: "Task A1 - Phase 1"

<Task 2>
- subagent_type: backend-architect
- prompt: [Task A2 details...]
- description: "Task A2 - Phase 1"

<Task 3>
- subagent_type: frontend-architect
- prompt: [Task A3 details...]
- description: "Task A3 - Phase 1"
```

All three tasks run simultaneously. Wait for ALL to complete before proceeding.

### Sequential Execution (When Dependent)

When tasks have dependencies, execute in order:

```
Execute Task A1 → Wait → Execute Task A2 (depends on A1) → Wait → ...
```

### Task Prompt Template

Each Task tool call should include:
- Task name and description from phase file
- Acceptance criteria
- Reference to relevant spec files in docs/specs/
- Reference to existing files to modify (not create new)
- Instruction to follow project standards in CLAUDE.md

**On Success:** Proceed to Step 5
**On Failure:** Report error and STOP

---

## Step 5: Update Progress

After successful task completion:

1. **Update phase file** (`docs/tasks/phase-N-[name].md`):
   - Mark task as completed with timestamp if format supports it

2. **Update PROGRESS.md**:
   - Change `- [ ] Task Name` to `- [x] Task Name`
   - Add completion note if needed

3. **Check if phase is complete**:
   - If all tasks in current phase are `[x]` → Run Phase Gate
   - If more tasks remain → Continue to next task

---

## Step 6: Phase Gate Check

When a phase is complete:

1. Display phase completion notice:
```
╔══════════════════════════════════════════════════════════╗
║         PHASE COMPLETE - RUNNING GATE CHECK              ║
╠══════════════════════════════════════════════════════════╣
║  Phase: [Phase Name]                                     ║
║  Tasks Completed: X/X                                    ║
║  Running: /phase-gate                                    ║
╚══════════════════════════════════════════════════════════╝
```

2. Execute `/phase-gate` using the Skill tool

3. **On PASS:**
   - Update PROGRESS.md to mark phase as complete
   - Display success message
   - Continue to next phase

4. **On FAIL:**
   - Display failure details
   - List specific issues to fix
   - **STOP auto-build** - manual intervention required

---

## Step 7: Continue Loop

After successful task or phase gate:

1. Check if more tasks exist
2. If yes → Return to Step 3 (Find Next Task)
3. If no → Build Complete!

---

## Step 8: Build Complete

When all phases and tasks are done:

```
╔══════════════════════════════════════════════════════════╗
║              🎉 AUTO-BUILD COMPLETE 🎉                   ║
╠══════════════════════════════════════════════════════════╣
║                                                          ║
║  All phases completed successfully!                      ║
║                                                          ║
║  Summary:                                                ║
║  ├── Phase 1: ✅ Complete (X tasks)                      ║
║  ├── Phase 2: ✅ Complete (Y tasks)                      ║
║  └── Phase N: ✅ Complete (Z tasks)                      ║
║                                                          ║
║  Total Tasks: XX                                         ║
║  All Gates: PASSED                                       ║
║                                                          ║
║  Next Steps:                                             ║
║  - Run /code-optimize for performance                    ║
║  - Run /docs-generate for documentation                  ║
║  - Final security audit with security-auditor            ║
║                                                          ║
╚══════════════════════════════════════════════════════════╝
```

---

## Stopping Conditions

Auto-build will STOP when:

| Condition | Action |
|-----------|--------|
| Phase gate fails | Report failures, require manual fix |
| Task execution fails | Report error, require manual fix |
| No PROGRESS.md found | Error: run `/spec-expand` first |
| No tasks found | Error: PROGRESS.md may be empty |
| All tasks complete | Success! Display completion summary |

---

## Resuming After Stop

To resume after fixing issues:

1. Fix the reported issues
2. Run `/auto-build` again
3. It will automatically pick up from the next uncompleted task

---

## Progress Tracking

During execution, display progress after each task:

```
[AUTO-BUILD] Phase 2 - Task 3/5 complete
[AUTO-BUILD] Overall: 8/15 tasks (53%)
```

---

## Error Handling

### Missing Files
```
ERROR: docs/tasks/PROGRESS.md not found
ACTION: Run /spec-expand to generate task structure
```

### Unparseable Progress
```
ERROR: Could not parse PROGRESS.md format
ACTION: Check file format matches expected structure
```

### Agent Failure
```
ERROR: Task execution failed
TASK: [Task Name]
AGENT: [Agent Used]
DETAILS: [Error message]
ACTION: Fix issue manually, then re-run /auto-build
```

### Gate Failure
```
GATE FAILED: Phase [N]
FAILURES:
- Testing: 2 tests failing
- Security: 1 vulnerability found
ACTION: Fix issues, then re-run /auto-build
```

---

## Integration with Workflow

```
/spec-analyze → /spec-expand → /auto-build → ship
                                    │
                    ┌───────────────┴───────────────┐
                    ↓                               ↓
              Task Loop                        Phase Gate
                    │                               │
              ┌─────┴─────┐                   ┌─────┴─────┐
              ↓           ↓                   ↓           ↓
           Success     Failure              PASS        FAIL
              │           │                   │           │
         Next Task      STOP            Next Phase      STOP
```

---

## Example Session

```
> /auto-build

[AUTO-BUILD] Reading PROGRESS.md...
[AUTO-BUILD] Current: Phase 1 - Foundation (2/5 tasks complete)
[AUTO-BUILD] Analyzing dependencies...
[AUTO-BUILD] Found 2 tasks with no blockers - running in PARALLEL

[AUTO-BUILD] Executing simultaneously:
  ├── Task F3: Set up routing (frontend-architect)
  └── Task F4: Create base layout (frontend-architect)

... (both agents run in parallel) ...

[AUTO-BUILD] ✅ Parallel batch complete:
  ├── F3: Set up routing - DONE
  └── F4: Create base layout - DONE
[AUTO-BUILD] Phase 1 - Tasks 4/5 complete
[AUTO-BUILD] Overall: 4/15 tasks (27%)

[AUTO-BUILD] Next task: F5 (depends on F3, F4)
[AUTO-BUILD] Executing with frontend-architect...

... (agent runs) ...

[AUTO-BUILD] ✅ Task complete: F5
[AUTO-BUILD] ✅ Phase 1 complete - Running gate check...
[AUTO-BUILD] /phase-gate phase-1-foundation

... (gate runs) ...

[AUTO-BUILD] ✅ Gate PASSED - Proceeding to Phase 2

[AUTO-BUILD] Phase 2 has parallel tracks: 2A and 2B
[AUTO-BUILD] Executing Phase 2A and 2B simultaneously...

  ├── Task 2A.1 (frontend-architect)
  ├── Task 2A.2 (frontend-architect)
  ├── Task 2B.1 (backend-architect)
  └── Task 2B.2 (backend-architect)

... (4 agents run in parallel) ...

[AUTO-BUILD] ✅ Parallel batch complete
... (continues until done or failure) ...
```

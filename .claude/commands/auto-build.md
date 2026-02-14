---
description: Automated sequential build - runs tasks one by one with phase gates
---

# Auto-Build

Run the entire build automatically, task by task.

## Arguments

$ARGUMENTS

Options:
- `--dry-run` - Show next 5 tasks without executing
- (no args) - Start or resume automated build

---

## Process Overview

```
┌─────────────────────────────────────────────────────────┐
│                    AUTO-BUILD LOOP                      │
├─────────────────────────────────────────────────────────┤
│  1. READ      → Parse PROGRESS.md for current state     │
│  2. FIND      → Get next uncompleted task               │
│  3. EXECUTE   → Run task with specified agent           │
│  4. UPDATE    → Mark task complete in files             │
│  5. CHECK     → If phase complete, run /phase-gate      │
│  6. CONTINUE  → If gate passes, next task               │
│  7. STOP      → If gate fails, report issues            │
│  8. LOOP      → Repeat until done or failure            │
└─────────────────────────────────────────────────────────┘
```

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

## Step 3: Find Next Task

If NOT dry-run, find the next task to execute:

1. Parse PROGRESS.md for first uncompleted task (`- [ ]`)
2. Identify which phase it belongs to
3. Read the corresponding phase file: `docs/tasks/phase-N-[name].md`
4. Extract task details:
   - Task description
   - Acceptance criteria
   - Specified agent (look for `Agent:` or infer from task type)
   - Any dependencies or prerequisites

**Agent Selection Rules:**
- UI/component/page tasks → `frontend-architect`
- API/database/backend tasks → `backend-architect`
- If task specifies an agent, use that agent
- If unclear, default to `frontend-architect` for most web projects

---

## Step 4: Execute Task

Use the Task tool to run the appropriate agent:

```
Task tool parameters:
- subagent_type: [selected agent]
- prompt: [Full task context including:
    - Task name and description from phase file
    - Acceptance criteria
    - Reference to relevant spec files in docs/specs/
    - Instruction to follow project standards in CLAUDE.md
  ]
- description: "[Task name] - [phase]"
```

Wait for agent completion.

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
[AUTO-BUILD] Next task: Set up routing structure

[AUTO-BUILD] Executing with frontend-architect...
... (agent runs) ...

[AUTO-BUILD] ✅ Task complete: Set up routing structure
[AUTO-BUILD] Phase 1 - Task 3/5 complete
[AUTO-BUILD] Overall: 3/15 tasks (20%)

[AUTO-BUILD] Next task: Create base layout component

[AUTO-BUILD] Executing with frontend-architect...
... (agent runs) ...

[AUTO-BUILD] ✅ Task complete: Create base layout component
[AUTO-BUILD] Phase 1 - Task 4/5 complete

... (continues) ...

[AUTO-BUILD] ✅ Phase 1 complete - Running gate check...
[AUTO-BUILD] /phase-gate phase-1-foundation

... (gate runs) ...

[AUTO-BUILD] ✅ Gate PASSED - Proceeding to Phase 2

... (continues until done or failure) ...
```

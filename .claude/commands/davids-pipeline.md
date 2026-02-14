---
description: Quick reference for David's Pipeline - shows steps, commands, and agents
---

# David's Pipeline Reference

## The 9-Step Workflow

```
1. SPEC      → Write rough spec in PROJECT-SPEC.md
2. ANALYZE   → /spec-analyze → Answer questions until no gaps
3. EXPAND    → /spec-expand → Generates docs/specs/, docs/tasks/, PROGRESS.md
4. BUILD     → /auto-build → Automated sequential execution
5. GATE      → (automatic) Phase gates run between phases
6. REPEAT    → (automatic) Continues until done or failure
7. DEPLOY    → /deploy staging → verify → /deploy production
8. MONITOR   → Watch error rates, verify health
9. ROLLBACK  → /rollback if issues → fix → redeploy
```

**Streamlined:** `/spec-analyze` → `/spec-expand` → `/auto-build` → `/deploy` → ship

## Key Commands

| Command | When to Use |
|---------|-------------|
| `/spec-analyze` | Find gaps in your spec, get clarifying questions |
| `/spec-expand` | Generate task structure from analyzed spec |
| `/auto-build` | Automated build - runs tasks sequentially with gates |
| `/phase-gate` | Quality checkpoint - must pass before next phase |
| `/deploy` | Deploy to staging/production with verification |
| `/rollback` | Emergency rollback with health checks |
| `/lint` | Fix code quality issues |

## Key Agents

| Agent | Use For |
|-------|---------|
| `frontend-architect` | UI components, pages, React work |
| `backend-architect` | APIs, databases, data models |
| `code-reviewer` | Quality check after completing tasks |
| `test-engineer` | Writing tests for features |
| `security-auditor` | Security scans at phase gates |

> **Tip:** Use the Context7 MCP server for looking up library documentation.

## Pipeline Diagram

```
IDEATION ──→ /spec-analyze ──→ /spec-expand ──→ /auto-build
                  ↓                  ↓                ↓
            (questions)         (docs/tasks/)    (automated)
                  ↓                  ↓                ↓
            (answers)           PROGRESS.md      Task Loop
                  ↓                               ↓     ↓
            (no gaps)                         Success  Fail
                                                 ↓      ↓
                                            Gate    STOP
                                             ↓ ↓
                                         PASS  FAIL
                                           ↓    ↓
                                         Next  STOP
                                        Phase
                                           ↓
                                    (all phases)
                                           ↓
                              /deploy staging ──→ verify
                                                    ↓
                              /deploy production ←──┘
                                           ↓
                                       MONITOR
                                        ↓   ↓
                                      OK   Issue
                                       ↓    ↓
                                    DONE  /rollback
                                           ↓
                                      fix → redeploy
```

## What Do I Do Next?

| Current State | Next Action |
|---------------|-------------|
| Have a rough idea | Write PROJECT-SPEC.md |
| Have a spec | Run `/spec-analyze` |
| Answered all questions | Run `/spec-expand` |
| Have task files | Run `/auto-build` (or manual: pick task, use agent) |
| Auto-build stopped | Fix reported issues, re-run `/auto-build` |
| Want to preview tasks | Run `/auto-build --dry-run` |
| All phases done | Run `/deploy staging` |
| Staging verified | Run `/deploy production` |
| Production issues | Run `/rollback`, then investigate |

---

*Full reference: `.claude/METHODOLOGY.md`*

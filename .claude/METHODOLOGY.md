# Claude Code Methodology Reference

A quick reference guide for David's Pipeline - the project planning and quality gate process.

---

## Quick Start for New Projects

```
1. Clone your project template
           ↓
2. Write rough spec → PROJECT-SPEC.md
           ↓
3. Run /spec-analyze → Answer questions until no gaps
           ↓
4. Run /spec-expand → Generates docs/ structure
           ↓
5. Build using task files → Run agents as specified
           ↓
6. Run /phase-gate between phases
           ↓
7. Polish and ship
```

---

## Your Agents (8 Total)

### Build Agents (Day-to-Day Coding)

| Agent | Use When | Expertise |
|-------|----------|-----------|
| `frontend-architect` | Building UI, components, pages | React, accessibility, performance |
| `backend-architect` | Building APIs, databases | REST, data modeling, security |

### Quality Agents (Checkpoints)

| Agent | Use When | Expertise |
|-------|----------|-----------|
| `code-reviewer` | After each task | 6-point review framework |
| `test-engineer` | After tasks + phase gates | Unit, integration, E2E tests |
| `security-auditor` | Phase gates + final audit | OWASP, vulnerability scanning |

### Planning Agents (Before Coding)

| Agent | Use When | Expertise |
|-------|----------|-----------|
| `system-architect` | Complex architecture decisions | Scalability, patterns |
| `tech-stack-researcher` | Evaluating new technologies | Ecosystem knowledge |
| `technical-writer` | Documentation needs | Developer docs, API refs |

---

## Your Commands (14 Total)

### Planning Commands

| Command | Purpose |
|---------|---------|
| `/spec-analyze` | Gap analysis + clarifying questions |
| `/spec-expand` | Generate task structure from spec |

### Quality Commands

| Command | Purpose |
|---------|---------|
| `/phase-gate` | Quality checkpoint between phases |
| `/lint` | Code quality check |

### Development Commands

| Command | Purpose |
|---------|---------|
| `/component-new` | Create React component |
| `/page-new` | Create Next.js page |
| `/api-new` | Create API endpoint |
| `/api-protect` | Add security to API |
| `/api-test` | Generate API tests |

### Polish Commands

| Command | Purpose |
|---------|---------|
| `/code-optimize` | Performance optimization |
| `/code-cleanup` | Refactoring |
| `/docs-generate` | Generate documentation |

### Deployment Commands

| Command | Purpose |
|---------|---------|
| `/deploy` | Deploy to staging or production with verification |
| `/rollback` | Emergency rollback with health checks |

---

## David's Pipeline

```
IDEATION
   └── Conversation → rough PROJECT-SPEC.md
         │
ANALYSIS
   └── /spec-analyze → gaps found, questions asked
         │
EXPANSION
   └── /spec-expand → docs/specs/, docs/tasks/, PROGRESS.md
         │
BUILD (per task)
   ├── Agent: frontend-architect or backend-architect
   ├── Helpers: /component-new, /api-new, etc.
   └── Quality: code-reviewer + test-engineer
         │
PHASE GATE (between phases)
   └── /phase-gate → tests + security scan → pass/fail
         │
POLISH
   ├── /code-optimize, /code-cleanup
   ├── /docs-generate + technical-writer
   └── security-auditor (comprehensive)
         │
DEPLOY
   ├── /deploy staging → verify manually
   ├── /deploy production → monitor
   └── /rollback if issues → fix → redeploy
```

---

## How Commands Invoke Agents

Commands reference agents for reusable behavior:

```markdown
# /phase-gate says:
"Apply test-engineer methodology to run all tests"
"Apply security-auditor methodology for security scan"
```

Claude reads both the command AND the agent files, then follows the combined instructions.

---

## Agent Context Awareness

All agents read your project's CLAUDE.md to understand:
- Tech stack (React, Vue, Next.js, etc.)
- Project structure conventions
- Coding standards
- What NOT to do
- **Context7 MCP server** for looking up library documentation

This makes agents reusable across different projects.

---

## Documentation Structure

```
docs/
├── specs/                    # Feature specifications
│   ├── 00-overview.md        # Project overview and scope
│   ├── 01-tech-stack.md      # Technology decisions
│   ├── 02-data-model.md      # Data structures
│   └── XX-feature.md         # Per-feature specs
│
├── tasks/                    # Implementation task lists
│   ├── PROGRESS.md           # Central tracking
│   └── phase-X-name.md       # Per-phase task files
│
└── future/
    └── POST-MVP.md           # Deferred features (DO NOT BUILD)
```

---

## Task File Format

```markdown
## Task X.1: Task Name

**Agent**: frontend-architect | backend-architect
**Depends On**: F1, F2
**Blocks**: A3, A4

### Objective
One sentence goal.

### Steps
- [ ] Step 1
- [ ] Step 2

### DO NOT
- Don't over-engineer
- Don't add unused features

### Verification
- [ ] How to confirm done

### Post-Completion
- [ ] Run code-reviewer
- [ ] Run test-engineer
```

---

## Phase Gate Checklist

When running `/phase-gate`:

1. **Testing** - All tests pass
2. **Security** - No vulnerabilities (npm audit, secret scan)
3. **TypeScript** - No type errors
4. **Linting** - No lint errors
5. **Documentation** - PROGRESS.md updated

**Result:**
- ✅ PASS → Proceed to next phase
- ❌ FAIL → Fix issues, re-run gate

---

## Key Principles

### Scope Control
- POST-MVP.md explicitly defers features
- "DO NOT" sections prevent over-engineering
- Better to build less, correctly

### Quality Built-In
- code-reviewer after every task
- test-engineer writes tests as you build
- phase-gate verifies before proceeding

### Parallel Work
- Phase 2 often has parallel tracks (2A, 2B, 2C)
- PROGRESS.md shows what can run simultaneously
- Dependencies are explicit

### Resumability
- PROGRESS.md tracks exactly where you stopped
- Any session can pick up and continue
- Context is in the docs, not your head

---

## Remember

- **Agents** = expert personas with 15-20 years experience
- **Commands** = automation that orchestrates agents
- **CLAUDE.md** = project context that agents read
- **/phase-gate** = quality checkpoint, must pass before next phase
- **DO NOT** sections are as important as DO sections

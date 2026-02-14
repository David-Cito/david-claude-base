# CLAUDE.md - Project Instructions

This file provides Claude Code with context about the project structure and coding standards.

> **See also:** `.claude/METHODOLOGY.md` for the complete David's Pipeline reference.

## Quick Reference

### David's Pipeline

```
1. Write rough spec → PROJECT-SPEC.md
2. /spec-analyze → Find gaps, ask questions
3. /spec-expand → Generate docs/ structure
4. /auto-build → Automated sequential execution
5. (automatic) Phase gates run between phases
6. (automatic) Repeat until done or failure
7. Polish and ship
```

**Streamlined:** `/spec-analyze` → `/spec-expand` → `/auto-build` → ship

### Key Commands

| Command | Purpose |
|---------|---------|
| `/spec-analyze` | Gap analysis + clarifying questions |
| `/spec-expand` | Generate task structure from spec |
| `/auto-build` | Automated build with phase gates |
| `/phase-gate` | Quality checkpoint between phases |
| `/deploy` | Deploy to staging/production |
| `/rollback` | Emergency rollback |
| `/davids-pipeline` | Quick pipeline reference |
| `/lint` | Fix linting issues |

### Key Agents

| Agent | Use When |
|-------|----------|
| `frontend-architect` | Building UI, components, pages |
| `backend-architect` | Building APIs, databases |
| `code-reviewer` | Quality check after tasks |
| `test-engineer` | Writing tests for features |
| `security-auditor` | Security checks at gates |

---

## Prompt Structure

When giving tasks to Claude, use this format for best results:

**Context:** Background info, feature goal, libraries to use
**Task:** What to do, reference specific files/docs
**Constraints:** What NOT to do (prevent over-engineering)

### Example Prompt

```
Context: We're building a user dashboard. Using React + Tailwind. The auth system is already set up in src/auth/.

Task: Add a "last login" timestamp to the user profile card in src/components/ProfileCard.tsx

Constraints: Don't refactor existing code. Don't add new dependencies. Keep it simple.
```

---

## Coding Standards

- **Type Safety**: Never use `any` types. Always define proper interfaces.
- **Error Handling**: Always handle errors gracefully with informative messages.
- **Security**: Validate all inputs. Never expose secrets. Follow OWASP guidelines.
- **Performance**: Avoid N+1 queries. Use appropriate caching strategies.
- **Testing**: Write tests for critical paths. Cover edge cases.

---

## Project Structure

```
src/
├── components/     # Reusable UI components
├── pages/          # Page components / routes
├── lib/            # Utility functions and helpers
├── hooks/          # Custom React hooks
├── types/          # TypeScript type definitions
├── api/            # API route handlers
└── styles/         # Global styles and themes

docs/
├── specs/          # Feature specifications
├── tasks/          # Phase task files + PROGRESS.md
└── future/         # POST-MVP.md (deferred features)
```

---

## Available Agents

### Build Agents (Day-to-Day Coding)

| Agent | Use Case |
|-------|----------|
| `frontend-architect` | UI components, pages, accessibility |
| `backend-architect` | APIs, data models, databases |

### Quality Agents (Checkpoints)

| Agent | Use Case |
|-------|----------|
| `code-reviewer` | Comprehensive 6-point review |
| `test-engineer` | Unit, integration, E2E tests |
| `security-auditor` | Security scans at phase gates |

### Planning Agents (Before Coding)

| Agent | Use Case |
|-------|----------|
| `system-architect` | High-level architecture decisions |
| `tech-stack-researcher` | Technology evaluation |
| `technical-writer` | Documentation |

---

## Available Commands

### Planning & Quality
- `/spec-analyze` - Gap analysis and clarifying questions
- `/spec-expand` - Generate task structure from spec
- `/auto-build` - Automated build - runs tasks sequentially with gates
- `/phase-gate` - Quality checkpoint between phases
- `/davids-pipeline` - Quick reference for David's Pipeline
- `/lint` - Fix linting issues

### Development
- `/component-new` - Create React component
- `/page-new` - Create new page
- `/api-new` - Create new API endpoint
- `/api-protect` - Add security & validation
- `/api-test` - Test API endpoints

### Polish
- `/code-optimize` - Performance optimization
- `/code-cleanup` - Refactoring
- `/code-explain` - Code explanation and analysis
- `/docs-generate` - Generate documentation

### Deployment
- `/deploy` - Deploy to staging or production with verification
- `/rollback` - Emergency rollback with health checks

---

## David's Pipeline

For complex features, follow this sequence:

### Planning Phase
1. **Ideation** → Conversation to flesh out idea → rough spec
2. **Analysis** → `/spec-analyze` → clarifying questions answered
3. **Expansion** → `/spec-expand` → docs/specs/, docs/tasks/, PROGRESS.md

### Build Phase (automated)
4. **Run `/auto-build`** → Executes tasks sequentially with specified agents
5. **Automatic gates** → Phase gates run automatically between phases
6. **On failure** → Fix issues, re-run `/auto-build`

### Polish Phase
7. **Optimization** → `/code-optimize`, `/code-cleanup`
8. **Security** → `security-auditor` (comprehensive mode)
9. **Documentation** → `technical-writer` + `/docs-generate`

### Deployment Phase
10. **Deploy** → `/deploy staging` → verify → `/deploy production`
11. **Monitor** → Watch error rates, verify health
12. **If issues** → `/rollback` → investigate → fix → redeploy

---

## Quality Gates

Run `/phase-gate` between every phase:

**Gate checks:**
- ✅ All tests pass
- ✅ No security vulnerabilities
- ✅ No TypeScript errors
- ✅ No linting errors
- ✅ PROGRESS.md updated

**Gate result:**
- **PASS** → Proceed to next phase
- **FAIL** → Fix issues, re-run gate

---

## Safety Rules

- Never commit `.env` files or secrets
- Always validate user input
- Use parameterized queries for database operations
- Follow the principle of least privilege
- Review security implications before deploying
- Run `/phase-gate` before proceeding to new phases

---

## Notes

- This setup works with any modern web stack
- All agents read this file for project context
- Customize agents in `.claude/agents/`
- Customize commands in `.claude/commands/`
- Full David's Pipeline reference in `.claude/METHODOLOGY.md`

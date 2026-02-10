# CLAUDE.md - Project Instructions

This file provides Claude Code with context about the project structure and coding standards.

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

## Coding Standards

- **Type Safety**: Never use `any` types. Always define proper interfaces.
- **Error Handling**: Always handle errors gracefully with informative messages.
- **Security**: Validate all inputs. Never expose secrets. Follow OWASP guidelines.
- **Performance**: Avoid N+1 queries. Use appropriate caching strategies.
- **Testing**: Write tests for critical paths. Cover edge cases.

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
```

## Available Agents

Use these specialized agents for specific tasks:

| Phase | Agent | Use Case |
|-------|-------|----------|
| Planning | `requirements-analyst` | Turn vague ideas into specs |
| Research | `tech-stack-researcher` | Evaluate technology choices |
| Architecture | `system-architect` | Design overall structure |
| Backend | `backend-architect` | Design APIs and data models |
| Frontend | `frontend-architect` | Design UI components |
| Security | `security-engineer` | Vulnerability audit |
| Performance | `performance-engineer` | Optimization review |
| Quality | `refactoring-expert` | Code cleanup during dev |
| Review | `code-reviewer` | Comprehensive final review |
| Docs | `technical-writer` | Documentation |

## Available Commands

### Development
- `/new-task` - Break down tasks
- `/code-explain` - Understand code
- `/code-optimize` - Performance optimization
- `/code-cleanup` - Refactoring
- `/feature-plan` - Plan implementation
- `/lint` - Fix linting issues
- `/docs-generate` - Generate documentation

### API Development
- `/api-new` - Create new API endpoint
- `/api-test` - Test API endpoints
- `/api-protect` - Add security & validation

### UI Development
- `/component-new` - Create React component
- `/page-new` - Create new page

## Large Project Workflow

For complex features, follow this sequence:

1. **Requirements** → `requirements-analyst` - Clarify what needs to be built
2. **Research** → `tech-stack-researcher` - Choose the right tools
3. **Architecture** → `system-architect` - Design the solution
4. **Planning** → `/feature-plan` - Break into tasks
5. **Build Backend** → `backend-architect` + `/api-new`
6. **Build Frontend** → `frontend-architect` + `/component-new`
7. **Security Audit** → `security-engineer`
8. **Performance** → `performance-engineer`
9. **Code Cleanup** → `/code-optimize`, `/code-cleanup`
10. **Final Review** → `code-reviewer` (comprehensive 6-point review)
11. **Documentation** → `technical-writer` + `/docs-generate`

## Safety Rules

- Never commit `.env` files or secrets
- Always validate user input
- Use parameterized queries for database operations
- Follow the principle of least privilege
- Review security implications before deploying

## Notes

- This setup is optimized for Next.js + React + TypeScript projects
- Works with any modern web stack
- Customize agents and commands in `.claude/agents/` and `.claude/commands/`

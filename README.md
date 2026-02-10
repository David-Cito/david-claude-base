# David's Claude Code Base

My personal Claude Code configuration for productive web development. This plugin provides **12 slash commands** and **12 specialized AI agents** to supercharge your development workflow.

## Quick Install

```bash
# Step 1: Add the marketplace
/plugin marketplace add davidsalter1/david-claude-base

# Step 2: Install the plugin
/plugin install david-claude-base
```

## What's Inside

### Development Commands (7)

- `/new-task` - Analyze code for performance issues
- `/code-explain` - Generate detailed explanations
- `/code-optimize` - Performance optimization
- `/code-cleanup` - Refactoring and cleanup
- `/feature-plan` - Feature implementation planning
- `/lint` - Linting and fixes
- `/docs-generate` - Documentation generation

### API Commands (3)

- `/api-new` - Create new API endpoints
- `/api-test` - Test API endpoints
- `/api-protect` - Add protection & validation

### UI Commands (2)

- `/component-new` - Create React components
- `/page-new` - Create Next.js pages

### Specialized AI Agents (12)

**Architecture & Planning**
- **tech-stack-researcher** - Technology choice recommendations with trade-offs
- **system-architect** - Scalable system architecture design
- **backend-architect** - Backend systems with data integrity & security
- **frontend-architect** - Performant, accessible UI architecture
- **requirements-analyst** - Transform ideas into concrete specifications

**Code Quality & Performance**
- **refactoring-expert** - Systematic refactoring and clean code
- **performance-engineer** - Measurement-driven optimization
- **security-engineer** - Vulnerability identification and security standards
- **code-reviewer** - Comprehensive 6-point pre-merge review (NEW)

**Documentation & Research**
- **technical-writer** - Clear, comprehensive documentation
- **learning-guide** - Teaching programming concepts progressively
- **deep-research-agent** - Comprehensive research with adaptive strategies

## The Code Reviewer Difference

The `code-reviewer` agent provides a comprehensive 6-point review framework:

1. **Spec Compliance** - Does it match requirements?
2. **Code Quality** - Architecture, patterns, errors, performance, security
3. **Maintainability** - Readability, DRY, comments, modularity
4. **Testing** - Adequate coverage and quality
5. **Risks** - Critical/High/Medium/Low issue classification
6. **Recommendations** - Actionable next steps

Use specialized agents (`refactoring-expert`, `security-engineer`, `performance-engineer`) during development, and `code-reviewer` for final pre-merge review.

## Installation

### From GitHub (Recommended)

```bash
# Add marketplace
/plugin marketplace add davidsalter1/david-claude-base

# Install plugin
/plugin install david-claude-base
```

### From Local Clone (for development)

```bash
git clone https://github.com/davidsalter1/david-claude-base.git
cd david-claude-base

# Add as local marketplace
/plugin marketplace add /path/to/david-claude-base

# Install plugin
/plugin install david-claude-base
```

## Large Project Workflow

| Phase | Tool | What It Does |
|-------|------|--------------|
| 1. Requirements | `requirements-analyst` | Turn vague ideas into specs |
| 2. Research | `tech-stack-researcher` | Evaluate technology choices |
| 3. Architecture | `system-architect` | Design overall structure |
| 4. Planning | `/feature-plan` | Break into actionable tasks |
| 5. Backend | `backend-architect` + `/api-new` | Design & scaffold APIs |
| 6. Frontend | `frontend-architect` + `/component-new` | Design & scaffold UI |
| 7. Security | `security-engineer` | Vulnerability audit |
| 8. Performance | `performance-engineer` | Optimization review |
| 9. Cleanup | `/code-optimize`, `/code-cleanup` | Refine the code |
| 10. Review | `code-reviewer` | Comprehensive 6-point review |
| 11. Docs | `technical-writer` + `/docs-generate` | Document everything |

## Safety Features

This setup includes safety hooks that block dangerous commands:
- Prevents destructive file system operations
- Blocks fork bombs and system-damaging commands
- Denies access to `.env` files

Configure in `.claude/settings.template.json`.

## Best For

- Next.js developers
- TypeScript projects
- React developers
- Full-stack engineers
- Any modern web stack

## Philosophy

This setup emphasizes:
- **Type Safety**: Never uses `any` types
- **Best Practices**: Follows modern Next.js/React patterns
- **Productivity**: Reduces repetitive scaffolding
- **Security**: Built-in safety hooks and security-focused agents
- **Quality**: Comprehensive code review before deployment

## Requirements

- Claude Code 2.0.13+
- Works with any project (optimized for Next.js + TypeScript)

## Customization

After installation, customize any command or agent by editing files in:
- `.claude/commands/` - Slash commands
- `.claude/agents/` - AI agent personas

## Credits

Based on [Edmund's Claude Code](https://github.com/edmund-io/edmunds-claude-code) with custom additions.

## License

MIT - Use freely in your projects

## Author

Created by David

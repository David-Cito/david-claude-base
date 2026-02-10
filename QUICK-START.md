# Quick Start Guide

## Installation

```bash
# Add the marketplace
/plugin marketplace add davidsalter1/david-claude-base

# Install the plugin
/plugin install david-claude-base
```

## First Steps

### 1. Configure Safety Hooks

Copy the settings template to enable safety features:

```bash
cp .claude/settings.template.json .claude/settings.json
```

### 2. Try a Command

```bash
# Plan a feature
/feature-plan

# Explain some code
/code-explain

# Create a new API endpoint
/api-new
```

### 3. Use an Agent

Just start typing naturally and mention the agent:

```
@code-reviewer review the changes in this PR
@tech-stack-researcher should I use Redis or PostgreSQL for caching?
@system-architect design the architecture for a real-time chat feature
```

## Common Workflows

### Starting a New Feature

1. `/feature-plan` - Break down the feature into tasks
2. Start coding
3. `/code-optimize` - Optimize when needed
4. `@code-reviewer` - Final review before merge

### Code Review

```
@code-reviewer perform a comprehensive review of src/components/
```

The code reviewer will analyze:
- Spec compliance
- Code quality (architecture, patterns, errors, performance, security)
- Maintainability
- Testing considerations
- Potential risks
- Recommendations

### API Development

```bash
/api-new           # Scaffold the endpoint
/api-protect       # Add validation and security
/api-test          # Generate tests
```

### UI Development

```bash
/component-new     # Create a new component
/page-new          # Create a new page
```

## Tips

- Use specific agents for focused work during development
- Use `code-reviewer` for comprehensive final reviews
- The `/feature-plan` command is great for breaking down complex features
- All agents follow your project's coding standards from `CLAUDE.md`

## Troubleshooting

### Commands not working?

Make sure the plugin is installed:
```bash
/plugin list
```

### Need to customize?

Edit files in:
- `.claude/agents/` - AI agent behaviors
- `.claude/commands/` - Slash command prompts

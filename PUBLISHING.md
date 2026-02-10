# Publishing Guide: David's Claude Code Plugin

Complete step-by-step instructions for publishing your Claude Code plugin to GitHub and making it available for others to install.

## Prerequisites

- [ ] GitHub account
- [ ] Git installed locally
- [ ] Repository named `david-claude-base`
- [ ] All configuration files updated

## Step 1: Create GitHub Repository

### 1.1 Create New Repository on GitHub

1. Go to https://github.com/new
2. Fill in the details:
   - **Repository name**: `david-claude-base`
   - **Description**: "David's personal Claude Code setup with 12 productivity commands and 12 specialized AI agents for modern web development"
   - **Visibility**: Public (so others can install it)
   - **Initialize**: Don't add README, .gitignore, or license (we already have these)
3. Click "Create repository"

### 1.2 Push Your Local Repository

Once the GitHub repository is created, run these commands:

```bash
cd C:/Users/David/Documents/GitHub/david-claude-base

# Add the GitHub remote
git remote add origin https://github.com/davidsalter1/david-claude-base.git

# Push your code
git push -u origin main
```

If you encounter authentication issues:
- Use a Personal Access Token instead of password
- Or set up SSH keys (recommended): https://docs.github.com/en/authentication/connecting-to-github-with-ssh

## Step 2: Enable Template Repository

1. Go to your repo: https://github.com/davidsalter1/david-claude-base
2. Click "Settings"
3. Check the box for "Template repository"
4. This allows others to create their own copies easily

## Step 3: Verify Installation Works

Test that your plugin can be installed:

```bash
# Add marketplace
/plugin marketplace add davidsalter1/david-claude-base

# Install plugin
/plugin install david-claude-base

# Verify commands are available
/code-explain
/feature-plan

# Verify agents are available (they'll activate automatically based on context)
```

To uninstall and test again:
```bash
/plugin uninstall david-claude-base
```

## Step 4: Share Your Plugin

### Option A: Share Direct Installation Command

Share this command with others:

```bash
/plugin marketplace add davidsalter1/david-claude-base
/plugin install david-claude-base
```

### Option B: Submit to Community Marketplaces

#### Claude Code Plugins Marketplace
1. Visit https://claudecodemarketplace.com/
2. Follow their submission guidelines
3. Share your plugin details

#### CC Plugins Curated Marketplace
1. Visit https://github.com/ccplugins/marketplace
2. Fork the repository
3. Add your plugin to their `marketplace.json`
4. Create a Pull Request with this format:

```json
{
  "name": "david-claude-base",
  "source": "davidsalter1/david-claude-base",
  "description": "Personal Claude Code configuration with 12 productivity commands and 12 specialized AI agents for modern web development",
  "version": "1.0.0",
  "author": "David",
  "tags": ["productivity", "nextjs", "typescript", "react", "development", "code-review"]
}
```

### Option C: Share on Social Media

Example post:

```
Just published my Claude Code setup as a plugin!

12 slash commands + 12 specialized AI agents for productive web development

Install with:
/plugin marketplace add davidsalter1/david-claude-base
/plugin install david-claude-base

Features:
- API scaffolding (/api-new)
- Code optimization (/code-optimize)
- Feature planning (/feature-plan)
- Comprehensive code reviewer agent (6-point review)
- Tech research agent
- Architecture agents
- Security & performance agents

Perfect for Next.js, React, and TypeScript projects!

GitHub: https://github.com/davidsalter1/david-claude-base
```

## Step 5: Maintain Your Plugin

### Updating Your Plugin

When you make changes to your local setup:

```bash
cd C:/Users/David/Documents/GitHub/david-claude-base

# Make your changes to commands/agents
# Then commit and push

git add .
git commit -m "Add new command: /new-command-name"

# Update version in plugin.json
# Bump version: 1.0.0 -> 1.1.0

git add .claude-plugin/plugin.json
git commit -m "Bump version to 1.1.0"

git push
```

Users can update to the latest version:
```bash
/plugin update david-claude-base
```

### Versioning Guidelines

- **1.0.x** - Bug fixes and minor tweaks
- **1.x.0** - New commands or agents added
- **x.0.0** - Major restructuring or breaking changes

## Troubleshooting

### Issue: Plugin Won't Install

Check:
- Repository is public on GitHub
- `.claude-plugin/plugin.json` exists in the repo root
- JSON files have valid syntax (no trailing commas, proper quotes)

### Issue: Commands Don't Appear

Check:
- Command file paths in `plugin.json` match actual file locations
- Command files have `.md` extension
- Command files are not empty

### Issue: Agents Don't Activate

Check:
- Agent file paths in `plugin.json` match actual file locations
- Agent files have proper frontmatter with `name` and `description`
- Agents activate based on context, not commands

## Advanced: Creating Releases

For major versions, create GitHub releases:

1. Go to your repo: https://github.com/davidsalter1/david-claude-base
2. Click "Releases" → "Create a new release"
3. Tag version: `v1.0.0`
4. Release title: `v1.0.0 - Initial Release`
5. Description: List of features/changes
6. Click "Publish release"

Users can install specific versions:
```bash
/plugin install davidsalter1/david-claude-base@v1.0.0
```

## Success Metrics

Track your plugin's success:
- GitHub stars
- GitHub watchers
- GitHub forks
- Issues and discussions
- Clone/download counts (GitHub Insights)

## Getting Help

If you run into issues:
- Claude Code Docs: https://docs.claude.com/en/docs/claude-code/plugin-marketplaces
- GitHub Issues: https://github.com/anthropics/claude-code/issues
- Community: Search for Claude Code plugins on GitHub

---

**Congratulations!** Once published, your plugin will be available for the Claude Code community to use and learn from.

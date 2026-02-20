# MCP Server Setup Guides

Quick reference for setting up MCP servers with Claude Code.

## Available Guides

| Server | File | Description |
|--------|------|-------------|
| Playwright | [playwright.md](./playwright.md) | Browser automation for E2E testing |

## General Setup

MCP servers are configured in `.mcp.json` at your project root (not in .claude/).

## Troubleshooting MCP Servers

If an MCP server isn't connecting:
1. Check `.mcp.json` syntax is valid JSON
2. Verify the package name exists on npm
3. Test package manually: `npx <package-name> --help`
4. Restart Claude Code after any config changes
5. Check Claude Code output/logs for errors

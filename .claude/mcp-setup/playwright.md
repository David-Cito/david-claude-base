# Playwright MCP Server Setup

Browser automation for E2E testing with Claude Code.

---

## Quick Setup

1. Create `.mcp.json` in your **project root** (not inside .claude/):

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

2. **Restart Claude Code** (required after any .mcp.json changes)

3. Verify by asking Claude: "Can you access Playwright MCP tools?"

---

## CRITICAL: Correct Package Name

| Status | Package Name | Notes |
|--------|--------------|-------|
| **WRONG** | `@anthropic-ai/mcp-server-playwright` | Does NOT exist on npm |
| **CORRECT** | `@playwright/mcp@latest` | Official Microsoft/Playwright package |

### Why This Matters
If you use the wrong package name, you'll see this error when testing:
```
npm error 404 Not Found - GET https://registry.npmjs.org/@anthropic-ai%2fmcp-server-playwright - Not found
```

And Claude will restart multiple times without ever connecting to the MCP server because the package doesn't exist.

---

## Verification Steps

### Step 1: Test the package exists
```bash
npx @playwright/mcp@latest --help
```

If this fails with a 404, you have the wrong package name.

### Step 2: Check .mcp.json is valid
```bash
# Should output valid JSON without errors
cat .mcp.json | jq .
```

### Step 3: After restarting Claude Code
Ask Claude: "List your available MCP tools" or "Can you access Playwright?"

You should see tools like:
- `browser_navigate`
- `browser_screenshot`
- `browser_click`
- `browser_type`
- `browser_snapshot`

If Claude says it doesn't have Playwright tools, the MCP server isn't connected.

---

## Common Issues We've Encountered

### Issue 1: MCP not connecting after multiple restarts
**Symptom:** Restarted Claude Code 4+ times, still no Playwright tools available.

**Cause:** Wrong package name in `.mcp.json`. The package `@anthropic-ai/mcp-server-playwright` does not exist.

**Fix:** Use `@playwright/mcp@latest` (the official package).

### Issue 2: 404 error when running npx
**Symptom:**
```
npm error 404 Not Found - GET https://registry.npmjs.org/@anthropic-ai%2fmcp-server-playwright
```

**Cause:** Package doesn't exist on npm.

**Fix:** Change to `@playwright/mcp@latest`.

### Issue 3: Claude doesn't mention MCP tools
**Symptom:** Claude responds but doesn't list any browser/Playwright tools.

**Causes:**
- MCP server failed to start
- Wrong package name
- `.mcp.json` not in project root
- Syntax error in `.mcp.json`

**Fix:** Run through all verification steps above.

---

## Alternative Packages

If the official `@playwright/mcp` has issues, these alternatives exist:

| Package | Notes |
|---------|-------|
| `@executeautomation/playwright-mcp-server` | Community alternative |
| `playwright-mcp` | Another community option |

---

## Available Tools After Setup

Once connected, Claude will have access to:

| Tool | Description |
|------|-------------|
| `browser_navigate` | Navigate to a URL |
| `browser_screenshot` | Take a screenshot |
| `browser_click` | Click an element |
| `browser_type` | Type text into an input |
| `browser_snapshot` | Get accessibility tree snapshot |
| `browser_hover` | Hover over an element |
| `browser_select` | Select from dropdown |
| `browser_scroll` | Scroll the page |

---

## Example .mcp.json with Multiple Servers

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-context7"]
    }
  }
}
```

# MCP Servers Included

This plugin includes 4 pre-configured MCP servers that enhance Claude Code's capabilities.

## Included Servers

### 1. **Context7** (`@upstash/context7-mcp`)
**Purpose**: Access up-to-date, version-specific documentation for any library

**Usage**: Just mention "use context7" in your prompt when you need current library documentation

**Benefits**:
- Always up-to-date docs
- Version-specific information
- Works with thousands of libraries
- No manual searching required

### 2. **Playwright** (`@playwright/mcp`)
**Purpose**: Browser automation and web testing

**Capabilities**:
- Navigate websites
- Take screenshots
- Interact with web elements
- Generate test code
- Access accessibility trees

**Use Cases**:
- E2E testing
- Web scraping
- Browser automation
- Visual testing

### 3. **Git** (`@cyanheads/git-mcp-server`)
**Purpose**: Git operations and repository management

**Capabilities**:
- View git status and history
- Create and manage branches
- Stage, commit, and push changes
- View diffs and logs
- Manage remotes

**Use Cases**:
- Version control
- Code history exploration
- Branch management
- Commit workflows

### 4. **Supabase** (HTTP-based)
**Purpose**: Supabase database operations

**Capabilities**:
- Query databases
- Manage tables and migrations
- Execute SQL
- Deploy Edge Functions
- Manage branches
- View logs and advisors

**Use Cases**:
- Database management
- Schema exploration
- Data queries
- Admin operations

**Setup**: Uses Supabase's hosted MCP endpoint (`https://mcp.supabase.com/mcp`) with Bearer token authentication. Get your access token from [Supabase Dashboard](https://supabase.com/dashboard/account/tokens).

## Using MCP Servers

After installing this plugin:

1. **Automatic Activation**: MCP servers start automatically when you use the plugin
2. **Restart Required**: Restart Claude Code after plugin installation
3. **Tool Access**: MCP tools appear in Claude's available tools list

## Environment Variables

Some servers use environment variables:

```bash
# For Git server (optional - restricts operations to this directory)
GIT_BASE_DIR=/path/to/your/repos

# For Git server on Windows (required - adds Git to PATH)
PATH=C:\Program Files\Git\cmd;C:\Program Files\Git\bin;%PATH%
```

## Adding More MCP Servers

You can add custom MCP servers to your local `.mcp.json`.

**Command-based (npx):**
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "package-name"],
      "env": {
        "API_KEY": "your-key"
      }
    }
  }
}
```

**HTTP-based (hosted endpoint):**
```json
{
  "mcpServers": {
    "server-name": {
      "type": "http",
      "url": "https://example.com/mcp",
      "headers": {
        "Authorization": "Bearer your-token"
      }
    }
  }
}
```

## Troubleshooting

**MCP servers not loading?**
1. Restart Claude Code
2. Check that npm/npx is installed
3. Verify network connection (MCP servers download on first use)

**Performance issues?**
- MCP servers run on-demand
- First use may be slower (package download)
- Subsequent uses are fast

## Learn More

- Official MCP Documentation: https://modelcontextprotocol.io
- Claude Code MCP Guide: https://docs.claude.com/en/docs/claude-code/mcp
- MCP Server Directory: https://mcpcat.io

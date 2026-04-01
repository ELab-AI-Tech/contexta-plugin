---
name: setup
description: Connect this workspace to ELab Contexta — the hosted AI capabilities server. Creates or updates .mcp.json with the Contexta server entry and verifies the connection. Triggers on "set up Contexta", "connect to ELab", "add the MCP server", "/setup", first run.
allowed-tools: Read, Write, mcp__elab-contexta__elab_features
---

## When to Use

- User wants to connect their workspace to Contexta for the first time
- User says "set up Contexta", "connect to ELab", "add the MCP server"
- The `elab_features` tool is not yet available (server not yet connected)

## How to Execute

### Step 1 — Check for existing connection

Read `.mcp.json` in the current working directory (or `~/.claude/mcp.json` for global config).

If `elab-contexta` is already present in `mcpServers`, skip to Step 3.

### Step 2 — Create or update .mcp.json

Ask the user for their ELab API key if not provided.

Add the Contexta server entry:

```json
{
  "mcpServers": {
    "elab-contexta": {
      "type": "http",
      "url": "https://contexta.elab.co.nz/mcp",
      "headers": {
        "Authorization": "Bearer <their-api-key>"
      }
    }
  }
}
```

If `.mcp.json` already exists with other servers, merge — do not overwrite existing entries.

Save the file and tell the user:
> "I've added the Contexta server to `.mcp.json`. You'll need to restart Claude Code for the connection to take effect. Once restarted, run setup again to verify."

### Step 3 — Verify connection

Call `elab_features` with no arguments.

If successful, present the enabled capabilities:
> "Connected to ELab Contexta. Your enabled capabilities:
> - **pipeline** — process meeting notes, transcripts, and briefs into structured documents
> [list each enabled feature]
>
> Say 'process this document' or '/pipeline [file]' to get started."

If the call fails with an auth error, tell the user their API key may be incorrect and ask them to check with ELab.

## Notes

- The server name `elab-contexta` in `.mcp.json` must match exactly — it determines how tool names appear in `allowed-tools` frontmatter (`mcp__elab-contexta__elab_pipeline`).
- Do not create vault structure, folders, or config files during setup. Setup is scoped to MCP connection only.
- If the user is on a team, each team member needs their own API key and their own `.mcp.json`.

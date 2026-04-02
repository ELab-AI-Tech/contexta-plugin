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

The `user-elab-contexta` MCP server is pre-configured in Cursor. Do **not** ask the user for an API key — skip directly to Step 2 to verify the connection.

Only fall back to manual `.mcp.json` setup if the `elab_features` tool call in Step 2 fails with a "tool not found" or connection error, indicating the MCP is not available at all.

### Step 2 — Verify connection

Call `elab_features` with no arguments.

If successful, present the enabled capabilities:
> "Connected to ELab Contexta. Your enabled capabilities:
> - **pipeline** — process meeting notes, transcripts, and briefs into structured documents
> [list each enabled feature]
>
> Say 'process this document' or '/pipeline [file]' to get started."

If the call fails with an auth error, tell the user their API key may be incorrect and ask them to check with ELab.

## Notes

- In Cursor, the ELab Contexta MCP is pre-configured as `user-elab-contexta` — never ask the user for an API key during setup.
- Do not create vault structure, folders, or config files during setup. Setup is scoped to MCP connection only.
- If running outside Cursor (e.g. Claude Code CLI), the `.mcp.json` approach with a Bearer token is the fallback — but only use it if `elab_features` fails to call.

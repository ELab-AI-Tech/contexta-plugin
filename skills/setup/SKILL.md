---
name: setup
description: Set up the ELab knowledge base in this workspace. Verifies the MCP connection, then reads and follows the setup instructions from the Contexta server. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, mcp__elab-contexta__elab_features, mcp__elab-contexta__elab_setup_kb, mcp__elab-contexta__elab_org_config
---

## Step 1 — Verify Connection

Call `elab_features` with no arguments.

- If successful: proceed to Step 2.
- If it fails with a connection or "tool not found" error: tell the user the Contexta server is not reachable and ask them to check their MCP configuration with ELab. Do not proceed.
- If it fails with an auth error: tell the user their API key may be incorrect and ask them to check with ELab. Do not proceed.

## Step 2 — Read and Follow the Server Setup Skill

Fetch the resource `skill://setup/SKILL.md` from the Contexta MCP server.

Read it fully, then follow its instructions exactly. The server skill drives the entire setup process — the dry-run conversation, folder creation, README files, and org config.

Do not improvise or shortcut the process defined in that resource.

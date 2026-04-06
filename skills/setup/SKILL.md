---
name: setup
description: Set up the ELab knowledge base in this workspace. Verifies the MCP connection, then fetches the full setup process from the Contexta server and follows it step by step. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, mcp__elab-contexta__elab_features, mcp__elab-contexta__elab_setup_kb, mcp__elab-contexta__elab_org_config
---

## Critical Rule

Do NOT call `elab_setup_kb`, `elab_org_config`, or write any files until you have completed Steps 1 and 2 below AND are following the instructions from the server skill. The server skill defines the entire process — including a mandatory dry-run conversation with the user before any files are created. You must not skip or compress that conversation.

---

## Step 1 — Verify Connection

Call `elab_features` with no arguments.

- If successful: proceed to Step 2.
- If it fails with a connection or "tool not found" error: tell the user the Contexta server is not reachable and ask them to check their MCP configuration with ELab. Do not proceed.
- If it fails with an auth error: tell the user their API key may be incorrect and ask them to check with ELab. Do not proceed.

---

## Step 2 — Fetch and Follow the Server Setup Skill

Fetch the MCP resource `skill://setup/SKILL.md` from the `elab-contexta` server.

Read the full content of the resource. It contains a multi-phase process with a dry-run conversation, a summary, user confirmation gates, and then the actual folder creation. Follow every phase in order. Do not summarise, compress, or skip any phase — especially the conversation phases that happen before any files are created.

The server skill is the single source of truth for this process. This plugin skill only verifies the connection and points you to it.

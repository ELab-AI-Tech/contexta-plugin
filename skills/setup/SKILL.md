---
name: setup
description: Set up the Contexta knowledge base in this workspace. Verifies the MCP connection, fetches the full setup process from the Contexta server, then follows it step by step. Triggers on "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, Glob, Grep, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_org_config, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_setup
---

## Critical Rule

Do NOT call `contexta_setup`, `contexta_org_config`, or write any files until you have completed Step 1 below AND are executing the instructions returned by `contexta_get_skill`. The server skill defines the entire process — including writing the instruction file at the home root and a mandatory dry-run conversation before any folders are created.

---

## Step 1 — Verify Connection

Call `contexta_capabilities` with no arguments and read the `health` block.

- If successful: proceed to Step 2.
- If it fails with a connection, "tool not found", or auth error: tell the user:

  > Contexta isn't signed in yet. Settings → Customize → Connectors → Contexta → Connect, then say continue.

  Do not proceed until `contexta_capabilities` succeeds. Do not write an instruction file from this client skill.

---

## Step 2 — Fetch and Follow the Server Setup Skill

Call `contexta_get_skill` with `skill_name: "setup/setup"`.

Read the full content returned. It contains a multi-phase process — home-root lock, instruction file write with read-back, conversation, staged folder creation with confirmation gates. Follow every phase in order. Do not summarise, skip, or compress any phase.

The content returned by `contexta_get_skill` is the single source of truth for this process.

When the server skill finishes by writing org config via `contexta_org_config` (`action: "write"`, `instruction_file_written_at_root: true`), that write marks dashboard onboarding as complete. Do not skip the finalize write.

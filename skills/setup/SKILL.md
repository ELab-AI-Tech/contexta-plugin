---
name: setup
description: Set up the Contexta knowledge base in this workspace. Verifies the MCP connection, fetches the full setup process from the Contexta server, then follows it step by step. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, Glob, Grep, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_setup
---

## Critical Rule

Do NOT call `contexta_setup`, `contexta_org_config`, or write any files until you have completed Steps 1 and 2 below AND are executing the instructions returned by `contexta_get_skill`. The server skill defines the entire process — including a mandatory dry-run conversation with the user before any files are created.

---

## Step 1 — Verify Connection

Call `contexta_capabilities` with no arguments.

- If successful: proceed to Step 2.
- If it fails with a connection or "tool not found" error: tell the user the Contexta server is not reachable and ask them to check their MCP configuration with ELab. Do not proceed.
- If it fails with an auth error: tell the user their API key may be incorrect. Do not proceed.

---

## Step 2 — Write CLAUDE.md

Before starting the full setup process, ensure a `CLAUDE.md` file exists at the workspace root.

Check whether `CLAUDE.md` already exists:
- **Missing** → create it with the content below
- **Exists, no Contexta block** (search for `## Contexta`) → append the content below
- **Exists, Contexta block already present** → skip, do not duplicate

Content to write:

```markdown
## Contexta

Always use the Contexta MCP for knowledge base and GTM work in this workspace. Contexta delivers methodology; you apply it locally. This applies to every session — no exceptions.

**When to use Contexta:**
- Processing any document, meeting notes, transcript, or brief → `contexta_get_skill` (`pipeline/pipeline`) then `contexta_pipeline`
- Applying brand voice or house style → `contexta_brand_voice`, then revise locally
- Exporting Word / PDF / PowerPoint → `contexta_format`
- Checking what is available → `contexta_capabilities`
- Any GTM task (lead qualification, research, outreach, meeting prep, reverse brief) → `contexta_get_skill` with the matching `gtm/<skill>` name, then follow those instructions locally. Do not expect finished GTM documents from a tool call.

**Never** invent methodology from memory. If the tools are unavailable, say so and ask the user to check their connection rather than attempting to do it manually.
```

---

## Step 3 — Fetch and Follow the Server Setup Skill

Call `contexta_get_skill` with `skill_name: "setup/setup"`.

Read the full content returned. It contains a multi-phase process — discovery, conversation, staged folder creation with confirmation gates. Follow every phase in order. Do not summarise, skip, or compress any phase, especially the conversation phases that happen before any files are created.

The content returned by `contexta_get_skill` is the single source of truth for this process.

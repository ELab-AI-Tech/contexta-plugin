---
name: setup
description: Set up the ELab knowledge base in this workspace. Verifies the MCP connection, fetches the full setup process from the Contexta server, then follows it step by step. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, Glob, Grep, mcp__elab-contexta__elab_features, mcp__elab-contexta__elab_get_skill, mcp__elab-contexta__elab_org_config
---

## Critical Rule

Do NOT call `elab_setup_kb`, `elab_org_config`, or write any files until you have completed Steps 1 and 2 below AND are executing the instructions returned by `elab_get_skill`. The server skill defines the entire process — including a mandatory dry-run conversation with the user before any files are created.

---

## Step 1 — Verify Connection

Call `elab_features` with no arguments.

- If successful: proceed to Step 2.
- If it fails with a connection or "tool not found" error: tell the user the Contexta server is not reachable and ask them to check their MCP configuration with ELab. Do not proceed.
- If it fails with an auth error: tell the user their API key may be incorrect. Do not proceed.

---

## Step 2 — Write CLAUDE.md

Before starting the full setup process, ensure a `CLAUDE.md` file exists at the workspace root.

Check whether `CLAUDE.md` already exists:
- **Missing** → create it with the content below
- **Exists, no Contexta block** (search for `## ELab Contexta`) → append the content below
- **Exists, Contexta block already present** → skip, do not duplicate

Content to write:

```markdown
## ELab Contexta

Always use the ELab Contexta MCP tools and the `contexta` skill for all knowledge base operations in this workspace. This applies to every session, every request — no exceptions.

**When to use Contexta tools:**
- Processing any document, meeting notes, transcript, or brief → `elab_pipeline`
- Applying brand voice or house style to any text → `elab_brand_voice`
- Exporting any document as Word, PDF, or PowerPoint → `elab_format`
- Checking what capabilities are available → `elab_features`
- Any GTM task (lead qualification, research, outreach, meeting prep) → `elab_gtm`

**Never** create, move, or edit knowledge base content manually without going through the Contexta MCP tools first. If the tools are unavailable, say so and ask the user to check their connection rather than attempting to do it manually.
```

---

## Step 3 — Fetch and Follow the Server Setup Skill

Call `elab_get_skill` with `skill_name: "setup"`.

Read the full content returned. It contains a multi-phase process — discovery, conversation, staged folder creation with confirmation gates. Follow every phase in order. Do not summarise, skip, or compress any phase, especially the conversation phases that happen before any files are created.

The content returned by `elab_get_skill` is the single source of truth for this process.

---
name: setup
description: Set up the Contexta knowledge base in this workspace. Verifies the MCP connection, fetches the full setup process from the Contexta server, then follows it step by step. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, Glob, Grep, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_org_config, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_setup
---

## Critical Rule

Do NOT call `contexta_setup`, `contexta_org_config`, or write any files until you have completed Steps 1 and 2 below AND are executing the instructions returned by `contexta_get_skill`. The server skill defines the entire process — including a mandatory dry-run conversation with the user before any files are created.

---

## Step 1 — Verify Connection

Call `contexta_capabilities` with no arguments.

- If successful: proceed to Step 2.
- If it fails with a connection, "tool not found", or auth error: the Contexta MCP server is bundled with this plugin but requires OAuth sign-in. Tell the user:

  > "Contexta isn't signed in yet. Run `/mcp`, select **contexta**, and complete the browser sign-in. Then say 'set up Contexta' again."

  Do not proceed until `contexta_capabilities` succeeds.

---

## Step 2 — Write the platform instruction file

Before starting the full setup process, ensure the correct root instruction file exists for this host client:

| Host client | File to write |
|---|---|
| ChatGPT (web or desktop) | `AGENTS.md` |
| Cursor | `AGENTS.md` |
| Claude Code / Claude CoWork / Claude Desktop | `CLAUDE.md` |

If the host is unclear, prefer `AGENTS.md` when running inside ChatGPT, otherwise ask which AI tool the team primarily uses.

Check whether that file already exists:
- **Missing** → create it with the content below
- **Exists, no Contexta block** (search for `## Contexta`) → append the content below
- **Exists, Contexta block already present** → skip, do not duplicate

In every user-facing message, name the actual file (for ChatGPT say `AGENTS.md`, never `CLAUDE.md`).

Content to write:

```markdown
## Contexta

Always use the Contexta MCP for knowledge base and GTM work in this workspace. Contexta delivers methodology; you apply it locally. This applies to every session — no exceptions.

**When to use Contexta:**
- Processing any document, meeting notes, transcript, or brief → `contexta_get_skill` (`pipeline/pipeline`) then `contexta_pipeline`
- Applying brand voice or house style → `contexta_brand_voice`, then revise locally
- Exporting Word / PDF / PowerPoint / Excel → `contexta_format` with the target `format` only (do not send file content); follow the returned skill locally
- Checking what is available → `contexta_capabilities`
- Any GTM task (lead qualification, research, outreach, meeting prep, reverse brief) → `contexta_get_skill` with the matching `gtm/<skill>` name, then follow those instructions locally. Do not expect finished GTM documents from a tool call.

**Never** invent methodology from memory. If the tools are unavailable, say so and ask the user to connect Contexta and complete sign-in rather than attempting to do it manually.
```

---

## Step 3 — Fetch and Follow the Server Setup Skill

Call `contexta_get_skill` with `skill_name: "setup/setup"`.

Read the full content returned. It contains a multi-phase process — discovery, conversation, staged folder creation with confirmation gates. Follow every phase in order. Do not summarise, skip, or compress any phase, especially the conversation phases that happen before any files are created.

The content returned by `contexta_get_skill` is the single source of truth for this process.

When the server skill finishes by writing org config via `contexta_org_config` (`action: "write"`), that write marks dashboard onboarding as complete. Do not skip the finalize write.

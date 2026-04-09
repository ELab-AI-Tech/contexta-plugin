---
name: health
description: Orient the session — load org rules, check what Contexta capabilities are enabled, surface documents waiting in Incoming/, and confirm the workspace is healthy. Triggers on "/health", "what can you do", "where were we", "catch me up", "let's start", "what should I work on".
allowed-tools: mcp__elab-contexta__elab_capabilities, mcp__elab-contexta__elab_org_config, Read, Glob
---

## When to Use

Triggered at the start of a session or whenever the user wants to know what's available, what to do next, or wants a quick context load.

## Steps

### 1 — Load org config

Call `elab_org_config(action="read")`.

This loads the org's workspace rules — folder names, naming conventions, pipeline settings, brand notes. All subsequent actions in this session must follow these rules. Keep them in context.

If `rules` is `"(no rules configured yet)"`, note this and suggest running `/setup` to configure.

### 2 — Get enabled capabilities

Call `elab_capabilities`. Parse `available_tools` to know what this org has active.

### 3 — Scan for unprocessed documents

Check the `Incoming/` folder (or whatever the org's rules specify as the intake folder). If it exists, list its files.

### 4 — Quick KB health check

Count documents across core folders (SOPs/, Decisions/, Lessons/, Frameworks/, Policies/ — or org-specific equivalents). Note any that appear empty.

### 5 — Respond

Present a concise, conversational summary:

> **ELab Contexta — [org name]**
>
> **Enabled:**
> - **Pipeline** — process documents into SOPs, decisions, lessons, frameworks
> - **Brand Voice** — apply ELab house style to any text
> - **Format** — export documents as Word, PDF, or PowerPoint
>
> **Incoming/ — 2 files waiting:**
> - meeting-notes-2026-04-01.md
> - q4-brief.md
>
> **KB:** 14 documents across 4 folders.
>
> Workspace rules loaded — using [org name]'s folder conventions.
>
> Want me to start with the meeting notes?

Adapt the list to only what `elab_capabilities` returns. Omit KB health line if folders don't exist yet.

If no rules are configured:
> "No workspace rules configured yet. Run `/setup` to set your folder structure and naming conventions — an admin on your account will need to do this."

If `Incoming/` is empty or missing:
> "Nothing waiting in Incoming/ — drop a file there whenever you're ready."

## Notes

- Always call `elab_org_config` first so the session has correct conventions loaded before any work begins.
- If the user then runs `/pipeline`, `/brand-voice`, etc., those skills will also call `elab_org_config` themselves — this is fine and ensures consistency even if health wasn't called first.
- If the MCP server is unreachable, tell the user: "Contexta isn't connected — check your MCP configuration or run `/setup` to reconfigure."

# ELab Contexta Plugin

**The client-facing Claude Code / Cursor plugin for ELab Contexta.**

This plugin connects your AI agent to ELab's hosted capabilities server — giving you document processing, brand voice, and formatting tools powered by ELab's methodology, without any implementation leaving ELab's servers.

---

## Installation

You need a GitHub account that has been added as a collaborator on this repo by ELab.

```
/plugin install elab-contexta@ELab-AI-Tech
```

Then run the setup skill to connect your workspace:

```
set up Contexta
```

---

## What You Need

- An ELab API key (provided during onboarding)
- Claude Code v1.0.33+ or Cursor with plugin support

---

## Available Skills

| Skill | Trigger | What it does |
|---|---|---|
| `setup` | "set up Contexta", "connect to ELab", "/setup" | Writes `.mcp.json` and verifies the server connection |
| `help` | "/help", "what can you do", "where were we" | Session-orient: shows enabled capabilities and documents waiting in `Incoming/` |
| `pipeline` | "/pipeline [file]", "process this document", "extract from meeting notes" | Extracts SOPs, decisions, lessons, frameworks from source documents |
| `brand-voice` | "/brand-voice [file]", "apply brand voice", "make this sound like us" | Applies ELab house style — removes filler, tightens language, switches passive to active |
| `format` | "/format [file] as docx", "export as PDF", "save as PowerPoint" | Exports any markdown document as Word, PDF, or PowerPoint |

---

## How It Works

This plugin contains only orchestration skills — no ELab methodology or processing logic is stored here. When you ask Claude to process a document, the plugin instructs Claude to:

1. Read your local file
2. Send the content to ELab's hosted MCP server
3. Receive structured output back
4. Write results to your knowledge base

The extraction logic, brand voice guidelines, quality rules, and ELab methodology run entirely on ELab's server and are never exposed to the client.

---

## MCP Server

The plugin connects to:

```
https://contexta.elab.co.nz/mcp
```

Authentication uses a per-org API key passed as a Bearer token. Each team member needs their own key configured in `.mcp.json`.

---

## File Structure (After Setup)

The pipeline skill writes to a structured knowledge base:

```
Incoming/          ← drop documents here to process
SOPs/              ← extracted standard operating procedures
Decisions/         ← decision records
Lessons/           ← lessons learned
Frameworks/        ← reusable models and frameworks
Policies/          ← organisational policies
Archive/           ← processed source documents
```

---

## Support

Contact ELab for API key issues, feature upgrades, or onboarding support.

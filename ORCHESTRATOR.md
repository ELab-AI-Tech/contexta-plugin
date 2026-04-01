# ELab Contexta — Orchestrator

Read this file first whenever the Contexta plugin is active. It defines how to route requests to the correct skill, what each skill produces, and how they chain together.

---

## The Golden Rule

**Always call `elab_features` before running any capability skill.**

It takes one second and tells you exactly what this client's org has enabled. Never assume a feature is available — orgs are on different plans.

---

## Skill Routing Table

| Trigger | Skill to Run | MCP Tool Called | Notes |
|---|---|---|---|
| "set up Contexta", "connect to ELab", "/setup", first run | `setup` | `elab_features` | Only needed once per workspace |
| "/help", "what can you do", "where were we", "let's start" | `help` | `elab_features` | Session-orient — always safe to run |
| "/pipeline [file]", "process this document", "extract from meeting notes" | `pipeline` | `elab_pipeline` | Core extraction workflow |
| "apply brand voice", "make this sound like us", "/brand-voice" | `brand-voice` | `elab_brand_voice` | Applies ELab house style to text or file |
| "export as Word", "make a PDF", "save as PowerPoint", "/format" | `format` | `elab_format` | Returns binary file — use Bash to write |

---

## Session Workflow

A typical Contexta session follows this path:

```
1. help (orient — what's available, what's in Incoming/)
      ↓
2. pipeline (process source documents → structured knowledge)
      ↓
3. brand-voice (refine any draft outputs for tone and style)
      ↓
4. format (export final documents as DOCX / PDF / PPTX)
```

Steps 2–4 can repeat independently. The `help` skill can be called at any point to re-orient.

---

## What Each Skill Produces

### `setup`
Writes or updates `.mcp.json` with the Contexta server entry. Verifies the connection by calling `elab_features`. Run once per workspace.

### `help`
No files written. Returns a conversational summary of:
- Enabled features for this org
- Files waiting in `Incoming/` (if any)
- Suggested next action

### `pipeline`
Input: a source document (meeting notes, transcript, brief, report)
Output: one or more structured documents written to the knowledge base:
- `SOPs/` — Standard Operating Procedures
- `Decisions/` — Decision records
- `Lessons/` — Lessons learned
- `Frameworks/` — Reusable models and frameworks
- `Policies/` — Organisational policies

Source file is archived to `Archive/` after processing.

### `brand-voice`
Input: a file path or inline text
Output: revised text with ELab house style applied
- Removes corporate filler, tightens language, switches passive to active voice
- Writes to `[filename]-bv.md` by default (or overwrites on request)

### `format`
Input: a markdown file path + target format (`docx`, `pdf`, `pptx`)
Output: binary file written via Bash decode of base64 response
- DOCX — for Word documents (editing, sharing)
- PDF — for read-only sharing
- PPTX — for slide presentations from structured content

---

## Feature Gating

All capability tools check org features server-side. If a feature is not in the org's plan, the tool returns a clear error message. Do not try to work around this — tell the user to contact ELab to upgrade.

| Tool | Feature flag required |
|---|---|
| `elab_pipeline` | `pipeline` |
| `elab_brand_voice` | `brand-voice` |
| `elab_format` | `format` |
| `elab_features` | none (always available) |

---

## MCP Tool Naming

All tools follow the naming convention `mcp__elab-contexta__<tool_name>`. This depends on the MCP server being registered as `elab-contexta` in `.mcp.json`.

If tools are not available, ask the user to run `setup` first.

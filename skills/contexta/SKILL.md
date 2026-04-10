---
name: contexta
description: Route all knowledge base, GTM, brand voice, and document operations through ELab Contexta. Any time the user creates, processes, queries, archives, exports, or styles a document — or runs any GTM pipeline step — read the relevant Contexta skill resource for instructions, then call the MCP tool. Never handle knowledge base content or GTM steps manually. Triggers on any file, document, or GTM operation in the workspace.
allowed-tools: mcp__elab-contexta__elab_capabilities, mcp__elab-contexta__elab_get_skill, mcp__elab-contexta__elab_org_config, mcp__elab-contexta__elab_pipeline, mcp__elab-contexta__elab_brand_voice, mcp__elab-contexta__elab_format, mcp__elab-contexta__elab_gtm
---

## Rule

Any operation on the knowledge base or GTM pipeline goes through ELab Contexta. Do not write, move, style, or process documents manually — delegate to the MCP.

## Step 1 — Check What's Available

At the start of any session (or when the user asks "what can you do"), call `elab_capabilities`. This returns the set of tools enabled for this org's plan. Only offer the capabilities that are enabled.

## Step 2 — Get Instructions From the Server

Each capability has a skill resource on the Contexta server. Read it before executing:

| Intent | Resource to read | Tool to call |
|---|---|---|
| Session start / what's available / workspace health | `skill://knowledge-base/health/SKILL.md` | `elab_capabilities`, `elab_org_config` |
| Process a document into structured knowledge | `skill://knowledge-base/pipeline/SKILL.md` | `elab_pipeline` |
| Capture friction, corrections, or learnings into the KB | `skill://knowledge-base/remember/SKILL.md` | _(local writes only)_ |
| Apply ELab brand voice to text or a file | `skill://brand-voice/SKILL.md` | `elab_brand_voice` |
| Export a document as Word, PDF, or PowerPoint | `skill://format/SKILL.md` | `elab_format` |
| View or manage task stack | `skill://workspace/tasks/SKILL.md` | _(local reads/writes only)_ |
| Surface next recommended action | `skill://workspace/next/SKILL.md` | _(local reads only)_ |
| Qualify a lead (Go / No-Go / Needs More Info) | `skill://gtm/qualify/SKILL.md` | `elab_gtm` |
| Research a prospect company and contacts | `skill://gtm/research/SKILL.md` | `elab_gtm` |
| Draft any pipeline communication (outreach, follow-up, etc.) | `skill://gtm/outreach/SKILL.md` | `elab_gtm` |
| Prepare a meeting briefing | `skill://gtm/meeting-prep/SKILL.md` | `elab_gtm` |
| Generate a reverse brief from a discovery transcript | `skill://gtm/reverse-brief/SKILL.md` | `elab_gtm` |
| Analyse client feedback and recommend a response strategy | `skill://gtm/negotiation/SKILL.md` | `elab_gtm` |
| Assemble SOW and MSA from a confirmed reverse brief | `skill://gtm/contract/SKILL.md` | `elab_gtm` |

Read the resource using `elab_get_skill`, follow its steps, then call the tool.

## If Tools Are Not Available

The Contexta server is not connected. Ask the user to run setup:

> "The Contexta server isn't connected. Say 'set up Contexta' and I'll configure it."

## If a Tool Returns a Feature Error

The org's plan does not include that capability. Tell the user:

> "That feature isn't enabled for your plan — contact ELab to upgrade."

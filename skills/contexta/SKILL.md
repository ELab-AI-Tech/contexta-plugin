---
name: contexta
description: Route all knowledge base, GTM, brand voice, and document operations through Contexta. Any time the user creates, processes, queries, archives, exports, or styles a document — or runs any GTM pipeline step — read the relevant Contexta skill resource for instructions, then call the MCP tool. Never handle knowledge base content or GTM steps manually. Triggers on any file, document, or GTM operation in the workspace.
allowed-tools: mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_pipeline, mcp__contexta__contexta_brand_voice, mcp__contexta__contexta_format, mcp__contexta__contexta_gtm, mcp__contexta__contexta_setup
---

## Rule

Any operation on the knowledge base or GTM pipeline goes through Contexta. Do not write, move, style, or process documents manually — delegate to the MCP.

## Step 1 — Check What's Available

At the start of any session (or when the user asks "what can you do"), call `contexta_capabilities`. This returns the set of tools and skills enabled for this org. Only offer the capabilities that are enabled.

## Step 2 — Get Instructions From the Server

Each capability has a skill resource on the Contexta server. Read it before executing using `contexta_get_skill`. Skill names use the format `<capability>/<skill>`:

| Intent | Skill to fetch | Tool to call |
|---|---|---|
| Session start / workspace health / what's available | `workspace/health` | `contexta_capabilities`, `contexta_org_config` |
| Process a document into structured knowledge | `pipeline/pipeline` | `contexta_pipeline` |
| Capture friction, corrections, or learnings into the KB | `pipeline/remember` | _(local writes only)_ |
| Apply brand voice and house style to text or a file | `brand-voice/brand-voice` | `contexta_brand_voice` |
| Export a document as Word, PDF, or PowerPoint | `format/format` | `contexta_format` |
| Set up the knowledge base workspace | `setup/setup` | `contexta_setup` |
| View or manage task stack | `workspace/tasks` | _(local reads/writes only)_ |
| Surface next recommended action | `workspace/next` | _(local reads only)_ |
| Search the knowledge base | `query/query` | _(local search only)_ |
| Qualify a lead (Go / No-Go / Needs More Info) | `gtm/qualify` | `contexta_gtm` |
| Research a prospect company and contacts | `gtm/research` | `contexta_gtm` |
| Draft any pipeline communication (outreach, follow-up, etc.) | `gtm/outreach` | `contexta_gtm` |
| Prepare a meeting briefing | `gtm/meeting-prep` | `contexta_gtm` |
| Generate a reverse brief from a discovery transcript | `gtm/reverse-brief` | `contexta_gtm` |
| Analyse client feedback and recommend a response strategy | `gtm/negotiation` | `contexta_gtm` |
| Assemble SOW and MSA from a confirmed reverse brief | `gtm/contract` | `contexta_gtm` |

Read the resource using `contexta_get_skill`, follow its steps, then call the tool.

> **Note:** Skill availability depends on org capabilities. `contexta_capabilities` returns the exact set enabled for your org — including any org-specific skills (standup, runbook, pitch, etc.) that your org has configured.

## If Tools Are Not Available

The Contexta server is not connected. Ask the user to run setup:

> "The Contexta server isn't connected. Say 'set up Contexta' and I'll configure it."

## If a Tool Returns a Feature Error

The org's plan does not include that capability. Tell the user:

> "That feature isn't enabled for your plan — contact ELab to upgrade."

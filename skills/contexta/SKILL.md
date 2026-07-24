---
name: contexta
description: Route all knowledge base, GTM, brand voice, and document operations through Contexta. Any time the user creates, processes, queries, archives, exports, or styles a document — or runs any GTM pipeline step — read the relevant Contexta skill resource for instructions, then apply them locally (and call a contexta_* tool only when the table says to). Never handle knowledge base content or GTM steps from memory. Triggers on any file, document, or GTM operation in the workspace.
allowed-tools: mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_org_config, mcp__plugin_contexta_contexta__contexta_pipeline, mcp__plugin_contexta_contexta__contexta_brand_voice, mcp__plugin_contexta_contexta__contexta_format, mcp__plugin_contexta_contexta__contexta_gtm, mcp__plugin_contexta_contexta__contexta_governance, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_pipeline, mcp__contexta__contexta_brand_voice, mcp__contexta__contexta_format, mcp__contexta__contexta_gtm, mcp__contexta__contexta_governance, mcp__contexta__contexta_setup
---

## Rule

Any operation on the knowledge base or GTM pipeline goes through Contexta. Do not invent methodology from memory — fetch the server skill, then execute it in your own context.

## Step 1 — Check What's Available

At the start of any session (or when the user asks "what can you do"), call `contexta_capabilities`. This returns the set of tools and skills enabled for this org. Only offer the capabilities that are enabled.

## Step 2 — Get Instructions From the Server

Each capability has a skill resource on the Contexta server. Read it before executing using `contexta_get_skill`. Skill names use the format `<capability>/<skill>`:

| Intent | Skill to fetch | Then |
|---|---|---|
| Session start / workspace health / what's available | `workspace/health` | `contexta_capabilities`, `contexta_org_config` |
| Process a document into structured knowledge | `pipeline/pipeline` | Call `contexta_pipeline` for methodology, then extract locally |
| Capture friction, corrections, or learnings into the KB | `pipeline/remember` | Follow skill locally (writes only) |
| Update an existing knowledge document | `pipeline/update` | Follow skill locally |
| Produce professional documentation from notes or drafts | `pipeline/professional-documentation` | Follow skill locally |
| QA a deliverable before sending | `pipeline/deliverable-qa` | Follow skill locally |
| Apply brand voice and house style to text or a file | `brand-voice/brand-voice` | Call `contexta_brand_voice` for methodology, then revise locally |
| Build or refine the company voice profile | `brand-voice/brand-voice-builder` | Follow skill locally |
| Build a personal voice profile | `personal-voice/personal-voice-builder` | Follow skill locally |
| QA voice-profiled content | `voice-qa/content-qa` | Follow skill locally |
| Export a document as Word, PDF, PowerPoint, or Excel | `format/format` | Call `contexta_format` with `format` only (no file content) for skill instructions, then build locally — or `contexta_get_skill` (`format/docx`, `format/pptx`, `format/pdf`, `format/xlsx`) |
| Set up the knowledge base workspace | `setup/setup` | Follow skill; call `contexta_setup` when it says to |
| View or manage task stack | `workspace/tasks` | Follow skill locally |
| Surface next recommended action | `workspace/next` | Follow skill locally |
| Search the knowledge base | `query/query` | Follow skill locally |
| Assess a Google Drive → Office migration | `drive-migration/assess` | Follow skill locally |
| Run a Google Drive → Office migration | `drive-migration/migrate` | Follow skill locally |
| Board meeting pipeline | `governance/board` | Call `contexta_governance` when the skill says to |
| Qualify a lead (Go / No-Go / Needs More Info) | `gtm/lead-qualifier` | Follow skill locally — do not expect a finished scorecard from a tool |
| Research a prospect company and contacts | `gtm/client-deep-research` | Follow skill locally |
| Draft any pipeline communication (outreach, follow-up, etc.) | `gtm/communications-drafter` | Follow skill locally |
| Prepare a meeting briefing | `gtm/meeting-prep` | Follow skill locally |
| Generate a reverse brief from a discovery transcript | `gtm/reverse-brief-generator` | Follow skill locally |
| Analyse client feedback and recommend a response strategy | `gtm/negotiation-advisor` | Follow skill locally |
| Assemble SOW and MSA from a confirmed reverse brief | `gtm/contract-assembler` | Follow skill locally |
| Manage pipeline / CRM deal state | `gtm/pipeline-manager` | Follow skill locally |
| Review pipeline / follow-up sequences | `gtm/pipeline-review` | Follow skill locally |

**How to execute:**

1. Call `contexta_get_skill` with the **full** skill name from the table (e.g. `gtm/reverse-brief-generator`). Always use `<capability>/<skill>` — never the bare skill slug alone (e.g. use `internal/compliance-calendar`, not `compliance-calendar`).
2. Follow the returned instructions in your own context using the files/notes already in scope.
3. Call a `contexta_*` tool only when the "Then" column names one, or when the fetched skill explicitly tells you to.

`contexta_gtm` is an optional shortcut that returns the same GTM skill body for a given `action`. Prefer `contexta_get_skill`. Never treat either call as producing the finished deliverable — you write the output locally.

> **Note:** Skill availability depends on org capabilities. `contexta_capabilities` returns the exact set enabled for your org — including any org-specific skills under the `internal` capability (e.g. `internal/standup`, `internal/compliance-calendar`, `internal/runbook`) that your org has configured. Always fetch those as `internal/<skill>`.

## If Tools Are Not Available

The Contexta MCP server is bundled with this plugin but requires OAuth sign-in. Tell the user:

> "Contexta isn't signed in yet. Run `/mcp`, select **contexta**, and complete the browser sign-in. Then say 'set up Contexta' or retry your request."

## If a Tool Returns a Feature Error

The org's plan does not include that capability. Tell the user:

> "That feature isn't enabled for your plan — contact ELab to upgrade."

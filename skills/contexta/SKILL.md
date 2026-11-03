---
name: contexta
description: Use the organization's Contexta skills, company context and knowledge base. Use when the user asks to use, find or follow one of their organization's skills, asks how their company does a job such as an estimate, proposal, brief, deck, report or pipeline step, mentions Contexta, or is working in a folder set up as a Contexta space.
allowed-tools: mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_get_org_config, mcp__plugin_contexta_contexta__contexta_update_org_config, mcp__plugin_contexta_contexta__contexta_read_skills, mcp__plugin_contexta_contexta__contexta_create_skill, mcp__plugin_contexta_contexta__contexta_pipeline, mcp__plugin_contexta_contexta__contexta_brand_voice, mcp__plugin_contexta_contexta__contexta_format, mcp__plugin_contexta_contexta__contexta_gtm, mcp__plugin_contexta_contexta__contexta_governance, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_get_org_config, mcp__contexta__contexta_update_org_config, mcp__contexta__contexta_read_skills, mcp__contexta__contexta_create_skill, mcp__contexta__contexta_pipeline, mcp__contexta__contexta_brand_voice, mcp__contexta__contexta_format, mcp__contexta__contexta_gtm, mcp__contexta__contexta_governance, mcp__contexta__contexta_setup
---

## Purpose

Contexta holds the organization's own skills, company context and knowledge links. This skill finds the one that fits the user's task and applies it, so the work follows the organization's method instead of a generic one.

## Step 1: Check the Connection

The first time the user asks for Contexta work in a session, call `contexta_capabilities` with `open_folders` set to the folders currently open, and read the `health` block. State one line, using the response's top-level `name`: `Connected to Contexta for <name>. Using <health.active_space>. Saving to <health.write_destination>.` That line is how the user knows they're connected to the right organization. If they say it's the wrong one, tell them to reconnect Contexta with the right account.

If `contexta_capabilities` isn't available in this chat, or fails twice, make no workspace changes and tell the user in one line:

> Contexta isn't connected in this chat. Settings → Customize → Connectors → Contexta → Connect, then start a new chat.

Pass `space` (the active space slug) on later `contexta_get_org_config` and `contexta_get_skill` calls.

Compare `health` with the local workspace. Make a repair only where the table says so, and tell the user what you changed:

| Actual state | Repair | Customer sees |
|---|---|---|
| No instruction file (`health.instruction_file`) at the top of the folder open in this chat | Write it there, as a direct child of that folder, from the server setup template. Never inside a context folder or any other subfolder. If the only copy is inside a subfolder, move it to that open-folder root and do not leave the copy. Knowledge files still go to `health.write_destination` (alias `health.home_root`). That is the only write this check makes. | nothing, or one line |
| Instruction file titled for another org, or missing the Contexta block | Correct the block, keep the rest | one line |
| `health.setup_completed` is false for the active space | Fetch `setup/setup` and run it for that space home only | one question |
| A plugin in `health.deprecated_client_plugins` is installed | Use the hosted skill from `health.published_skills`. Mention once that the older plugin can be removed in Settings → Plugins. | one line, once |
| User intent matches a `health.skill_catalog` entry | Fetch that skill with `contexta_get_skill`. Org-specific entries win over generic ones. | nothing |
| User intent matches a name in `health.published_skills` | Fetch that skill. Do not invent a local skill with the same job. | nothing |
| Open folder matches another space's home | Announce the switch. Start a fresh context for that space. Do not mix writes. | one line |
| The open folder does not match any space home | Work read-only. Ask once which space this folder belongs to. | one line |
| Requested skill is not in `health.published_skills` | Say the skill isn't published yet, and ask whether to continue without it. | one line |

Then call `contexta_get_org_config` with `space` set to the active space slug.

## Step 2: Find the Right Skill

Before writing a client-facing file (estimate, brief, proposal, deck, spreadsheet, document or outreach), check `health.skill_catalog` for a skill that covers the job and fetch it with `contexta_get_skill`. Org-specific catalog entries win over the intent table below. When a catalog skill covers the job, use it rather than a general template.

If nothing in the catalog covers the job, say so and ask the user before building from scratch.

Skill **names** come from `health.published_skills`. `health.skill_catalog` is the routing list (name, summary, triggers). The table below is an intent map only. If an intent's skill isn't in `published_skills`, say it isn't available rather than fetching it.

Each capability has a skill on the Contexta server. Skill names use the format `<capability>/<skill>`. The generic GTM rows apply only when `health.skill_catalog` has no org-specific skill for the same job:

| Intent | Skill to fetch | Then |
|---|---|---|
| Workspace health / what's available | `workspace/health` | `contexta_capabilities`, `contexta_get_org_config` |
| Workspace audit / conflicting native skills or MCPs | `workspace/audit` | Follow skill locally; change nothing until the user confirms a fix |
| Product FAQ / how do I… / troubleshooting Contexta | `setup/faq` | Answer from skill corpus; no tool call |
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
| Set up the knowledge base workspace | `setup/setup` | Follow skill; it calls `contexta_setup` when needed |
| View or manage task stack | `workspace/tasks` | Follow skill locally |
| Surface next recommended action | `workspace/next` | Follow skill locally |
| Search the knowledge base | `query/query` | Follow skill locally |
| Assess a Google Drive → Office migration | `drive-migration/assess` | Follow skill locally |
| Run a Google Drive → Office migration | `drive-migration/migrate` | Follow skill locally |
| Board meeting pipeline | `governance/board` | Call `contexta_governance` when the skill says to |
| Qualify a lead (Go / No-Go / Needs More Info) | `gtm/lead-qualifier` | Follow skill locally; the tool returns the method, not a finished scorecard |
| Research a prospect company and contacts | `gtm/client-deep-research` | Follow skill locally |
| Draft any pipeline communication (outreach, follow-up, etc.) | `gtm/communications-drafter` | Follow skill locally |
| Prepare a meeting briefing | `gtm/meeting-prep` | Follow skill locally |
| Generate a reverse brief from a discovery transcript | `gtm/reverse-brief-generator` | Follow skill locally |
| Analyze client feedback and recommend a response strategy | `gtm/negotiation-advisor` | Follow skill locally |
| Assemble SOW and MSA from a confirmed reverse brief | `gtm/contract-assembler` | Follow skill locally |
| Manage pipeline / CRM deal state | `gtm/pipeline-manager` | Follow skill locally |
| Review pipeline / follow-up sequences | `gtm/pipeline-review` | Follow skill locally |

**How to run a skill:**

1. Confirm the full skill name is in `health.published_skills` (or is `setup/faq`). Call `contexta_get_skill` with that name (for example `gtm/reverse-brief-generator`) and `space` set to the active space slug. Use `<capability>/<skill>`, not the bare skill slug.
2. Follow the returned instructions using the files and notes already in scope.
3. Call another `contexta_*` tool only when the "Then" column names one, or when the fetched skill says to.

`contexta_gtm` returns the same GTM skill body for a given `action`; `contexta_get_skill` is the usual route. Neither call produces the finished deliverable. You write the output.

> **Note:** Skill availability depends on the organization's capabilities. `health.published_skills` is the exact set for this organization, including org-specific skills. `health.skill_catalog` is how you match the user's job to those names.

## If Contexta Disconnects Mid-Task

Retry `contexta_capabilities` once. If it still fails, tell the user in one line, and ask whether to reconnect and continue with their organization's skill or carry on without it:

> Contexta got disconnected. Settings → Customize → Connectors → Contexta → Connect, then say continue.

After they reconnect, resume the same job by fetching the skill again.

## If a Capability Is Missing

If an error names a capability this organization doesn't have, and the work is specific to this organization, offer to create it. With the user's confirmation, and only when an admin or editor is signed in, call `contexta_create_skill` to create the organization-owned capability with a kebab-case slug and a one-line description, then create the skill in it.

A product capability that isn't included for this organization can't be created that way. Say so in one line and ask how the user wants to proceed.

---
name: contexta
description: Route all knowledge base, GTM, brand voice, and document operations through Contexta. Any time the user creates, processes, queries, archives, exports, or styles a document — or runs any GTM pipeline step — read the relevant Contexta skill resource for instructions, then apply them locally (and call a contexta_* tool only when the table says to). Never handle knowledge base content or GTM steps from memory. Triggers on any file, document, or GTM operation in the workspace.
allowed-tools: mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_org_config, mcp__plugin_contexta_contexta__contexta_pipeline, mcp__plugin_contexta_contexta__contexta_brand_voice, mcp__plugin_contexta_contexta__contexta_format, mcp__plugin_contexta_contexta__contexta_gtm, mcp__plugin_contexta_contexta__contexta_governance, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config, mcp__contexta__contexta_pipeline, mcp__contexta__contexta_brand_voice, mcp__contexta__contexta_format, mcp__contexta__contexta_gtm, mcp__contexta__contexta_governance, mcp__contexta__contexta_setup
---

## Rule

Any operation on the knowledge base or GTM pipeline goes through Contexta. Do not invent methodology from memory — fetch the server skill, then execute it in your own context.

## Step 1 — Reconcile

At the start of every session (and when the user asks what you can do), call `contexta_capabilities` and read the `health` block. Compare it to the local workspace and repair before doing any other work. Do not ask the user to run a command.

| Actual state | Repair | Customer sees |
|---|---|---|
| No instruction file (`health.instruction_file`) at the home root | Write it at `health.home_root` from the server setup template. That is the only write allowed at session start. | nothing, or one line |
| Instruction file titled for another org, or missing the Contexta block | Correct the block, keep the rest | one line |
| `health.setup_completed` is false | Fetch `setup/setup` and run it for the home root only | one question |
| A plugin in `health.deprecated_client_plugins` is installed | Ignore it. Use the hosted skill from `health.published_skills`. Say once it is safe to remove (Settings → Plugins). | one line, once |
| User intent matches a name in `health.published_skills` | Fetch that skill. Do not invent a local skill with the same job. | nothing |
| The open folder is not the home root | Work read-only. Name the home folder to open for writes. | one line |
| Requested skill is not in `health.published_skills` | Stop. Say ELab is finishing this skill. Do not invent a replacement. | one line |

Then call `contexta_org_config` (`action: "read"`).

Skill **names** come from `health.published_skills`. The table below is an intent map only. If an intent's skill is not in `published_skills`, stop rather than fetching it.

## Step 2 — Get Instructions From the Server

Each capability has a skill resource on the Contexta server. Read it before executing using `contexta_get_skill`. Skill names use the format `<capability>/<skill>`:

| Intent | Skill to fetch | Then |
|---|---|---|
| Session start / workspace health / what's available | `workspace/health` | `contexta_capabilities`, `contexta_org_config` |
| Workspace audit / conflicting native skills or MCPs | `workspace/audit` | Follow skill locally — reconcile already ran; do not write until the user confirms a fix |
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

1. Confirm the full skill name is in `health.published_skills` (or is `setup/faq`). Call `contexta_get_skill` with that name (e.g. `gtm/reverse-brief-generator`). Always use `<capability>/<skill>` — never the bare skill slug alone.
2. Follow the returned instructions in your own context using the files/notes already in scope.
3. Call a `contexta_*` tool only when the "Then" column names one, or when the fetched skill explicitly tells you to.

`contexta_gtm` is an optional shortcut that returns the same GTM skill body for a given `action`. Prefer `contexta_get_skill`. Never treat either call as producing the finished deliverable — you write the output locally.

> **Note:** Skill availability depends on org capabilities. `health.published_skills` is the exact set for this org — including org-specific skills. Always fetch those as `<capability>/<skill>`.

## If Tools Vanish Mid-Task

Retry `contexta_capabilities` once.

If it still fails, **stop the job**. Do not finish the work with Drive, Gmail, Python, or a local skill. Do not offer to save a replacement skill.

Tell the user, in one line:

> Contexta got disconnected. Settings → Customize → Connectors → Contexta → Connect, then say continue.

Wait. After they reconnect, resume the same job by fetching the hosted skill again.

## If a Tool Returns a Feature Error

That capability is not on this plan. Say so in one line and wait. Do not invent a local substitute.

---
name: contexta
description: Route all knowledge base operations through ELab Contexta. Any time the user creates, processes, updates, archives, exports, or styles a document — read the relevant Contexta skill resource for instructions, then call the MCP tool. Never handle knowledge base content manually. Triggers on any file or document operation in the workspace.
allowed-tools: mcp__elab-contexta__elab_features, mcp__elab-contexta__elab_pipeline, mcp__elab-contexta__elab_brand_voice, mcp__elab-contexta__elab_format
---

## Rule

Any operation on the knowledge base goes through ELab Contexta. Do not write, move, or style documents manually — delegate to the MCP.

## How to Get Instructions

Each capability has a skill resource on the Contexta server. Read it before executing:

| Intent | Resource to read | Tool to call |
|---|---|---|
| What's available / session start | `skill://help/SKILL.md` | `elab_features` |
| Process a document into structured knowledge | `skill://pipeline/SKILL.md` | `elab_pipeline` |
| Apply ELab brand voice to text or a file | `skill://brand-voice/SKILL.md` | `elab_brand_voice` |
| Export a document as Word, PDF, or PowerPoint | `skill://format/SKILL.md` | `elab_format` |

Read the resource, follow its steps, then call the tool.

## If Tools Are Not Available

The Contexta server is not connected. Ask the user to run setup:

> "The Contexta server isn't connected. Say 'set up Contexta' and I'll configure it."

## If a Tool Returns a Feature Error

The org's plan does not include that capability. Tell the user:

> "That feature isn't enabled for your plan — contact ELab to upgrade."

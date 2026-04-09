---
name: pipeline
description: Process a source document end-to-end — read the file locally, get ELab's extraction methodology, apply it, write extracted documents to the knowledge base following org rules, archive the source. Triggers on "/pipeline", "/pipeline [file]", "process this document", "extract from meeting notes", "process this transcript".
allowed-tools: Read, Write, Glob, Grep, Bash, mcp__elab-contexta__elab_get_skill, mcp__elab-contexta__elab_org_config, mcp__elab-contexta__elab_pipeline
---

## When to Use

User has a document to process (meeting notes, transcript, brief, report) and wants structured knowledge extracted from it.

---

## Steps

### 1 — Fetch process instructions

Call `elab_get_skill` with `skill_name: "knowledge-base/pipeline"`.

Read the full content returned — it contains the complete step-by-step extraction process, org config handling, content type detection, writing instructions, and archive rules. Follow every step in order.

The content returned by `elab_get_skill` is the single source of truth for this process.

---

## Errors

- Capability not enabled → "Pipeline isn't included in your current plan. Contact ELab to upgrade."
- Server unreachable → "Couldn't connect to the Contexta server right now. Try again, or contact ELab if it persists."
- No rules configured → proceed with defaults and note: "No workspace rules are configured yet. Run `/setup` to configure naming conventions and folder structure."

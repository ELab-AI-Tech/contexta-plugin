---
name: pipeline
description: Process source documents end-to-end using ELab's extraction methodology. Reads a local file, sends it to the Contexta server, and writes the extracted documents (SOPs, decisions, lessons, frameworks, policies) to the knowledge base. Triggers on "/pipeline", "/pipeline [file]", "process this document", "extract from meeting notes", "process this transcript", "full pipeline".
allowed-tools: Read, Write, Glob, mcp__elab-contexta__elab_pipeline
---

## When to Use

- User has a source document to process (meeting notes, transcript, brief, or any text)
- User wants to extract structured outputs from a document
- User says "/pipeline", "process this", "extract from meeting notes", "full pipeline"

## How to Execute

### Step 1 — Identify the source file

If the user specified a file path, use it.

If no file was specified, list files in `Incoming/` (or the root if `Incoming/` doesn't exist) and ask which to process:
> "I found these documents in Incoming/: [list]. Which would you like to process?"

Read the full content of the source file.

### Step 2 — Determine content type

Map the file to a content type:
- Files in `meeting-notes/` or named `*meeting*`, `*standup*`, `*call*` → `meeting-notes`
- Files named `*transcript*`, `*interview*`, `*recording*` → `transcript`
- Files named `*brief*`, `*scope*`, `*spec*`, `*proposal*` → `brief`
- Everything else → `general`

### Step 3 — Call elab_pipeline

Call `elab_pipeline` with:
- `content`: full text of the source file
- `content_type`: determined above

### Step 4 — Write the extracted documents

Parse the returned `documents` array.

For each document, determine the output path using the folder conventions:
- `sop` → `Documents/SOPs/`
- `decision` → `Documents/Decisions/`
- `lesson` → `Documents/Lessons/`
- `framework` → `Documents/Frameworks/`
- `policy` → `Documents/Policies/`

If the `Documents/` subfolder doesn't exist, create it.

Format each document as a markdown file with YAML frontmatter:

```markdown
---
type: [frontmatter.type]
title: [frontmatter.title]
status: [frontmatter.status]
date: [frontmatter.date]
tags: [frontmatter.tags]
ai_summary: [frontmatter.ai_summary]
---

[body]
```

Filename: `YYYY-MM-DD-[slugified-title].md`

Write each file to its output path.

### Step 5 — Archive the source

Move the source file to `Archive/` with a datestamp prefix:
`Archive/YYYY-MM-DD-[original-filename]`

If `Archive/` doesn't exist, create it.

### Step 6 — Present summary

Tell the user what was produced:
> "Extracted [N] documents from [filename]:
> - SOP: [title] → Documents/SOPs/...
> - Decision: [title] → Documents/Decisions/...
> [list each]
>
> Source moved to Archive/."

If the response includes a `_signal` field, surface it naturally at the end as a considered observation — not a system message.

## If elab_pipeline Returns an Error

- **Feature not enabled**: "Pipeline processing isn't included in your current plan. Contact ELab to upgrade."
- **API error**: "I couldn't process this document right now. Please try again, or contact ELab if the issue persists."

## Notes

- Do not decide what to extract or apply schema rules yourself — that is `elab_pipeline`'s responsibility on the server.
- Always archive the source after successful extraction. Never delete source documents.
- If the org has custom folder conventions, use those instead of the defaults above.

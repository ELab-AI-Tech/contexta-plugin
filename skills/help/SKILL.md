---
name: help
description: Show available ELab Contexta capabilities and orient the session. Scans for unprocessed documents and surfaces what needs attention. Triggers on "/help", "what can you do", "where were we", "what should I work on", "good morning", "catch me up", "let's start", "what ELab tools do I have".
allowed-tools: Read, Glob, mcp__elab-contexta__elab_features
---

## When to Use

- User starts a session and wants to know what's available or what to work on
- User asks "what can you do", "where were we", "what should I work on"
- User wants to see their Contexta capabilities
- Natural session-start phrases: "good morning", "let's start", "catch me up"

## How to Execute

### Step 1 — Get enabled capabilities

Call `elab_features` with no arguments.

Parse the returned `available_tools` to understand what this org has enabled.

### Step 2 — Scan for unprocessed documents

Check if `Incoming/` exists in the current working directory.

If it exists, list all files in it (non-recursively).

Count the unprocessed files.

### Step 3 — Present a session summary

Combine everything into a single, oriented response. Example format:

> **ELab Contexta — [Org Name]**
>
> **Available capabilities:**
> - **Pipeline** — Extract SOPs, decisions, lessons and frameworks from documents
>   _Trigger: "process this document", "/pipeline [file]"_
> - **Brand Voice** — Apply ELab house style to any text
>   _Trigger: "apply brand voice", "/brand-voice [file]"_
> - **Format** — Export documents as Word, PDF, or PowerPoint
>   _Trigger: "export as Word", "/format [file] as docx"_
>
> **Incoming/ — 2 documents waiting:**
> - meeting-notes-2026-04-01.md
> - q4-brief.md
>
> Want me to start with the meeting notes?

If `Incoming/` is empty or doesn't exist:
> "Nothing waiting in Incoming/. Drop a document there whenever you're ready to process it."

If only one feature is enabled, adapt the list accordingly — don't mention features the org doesn't have.

## Notes

- This skill is the session-orient equivalent. It does not call a health tool (Stage 3 addition).
- Do not fabricate capabilities. Only show what `elab_features` returns.
- Keep the tone conversational — this should feel like a colleague briefing you, not a system status page.

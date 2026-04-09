---
name: remember
description: Capture friction, corrections, and methodology notes about this workspace. Three modes — explicit description, contextual (review recent corrections), or session mining. Triggers on "/remember", "/remember [description]", "capture this friction", "remember this", "note this correction".
allowed-tools: Read, Write, Edit, Grep, Glob, mcp__elab-contexta__elab_org_config
argument-hint: "[description of what to remember]"
---

## When to Use

Use whenever the user wants to capture a correction, a workflow friction point, or a methodology note about how work should be done in this workspace. The goal is to build up institutional memory about how the AI should behave and what patterns to avoid or repeat.

---

## Step 0 — Locate the Memory Folder

Call `elab_org_config(action="read")`. Look for a memory or methodology folder in the org's rules. If none is specified, default to `Memory/` at the workspace root. Create it if it doesn't exist.

---

## Modes

### Explicit Mode
**Triggered by:** `/remember [description]` or "remember this" with specific text

**Step 1 — Parse friction**
Extract:
- What went wrong or what to prevent
- What the user wants instead
- When this applies (scope)

If the input is purely prescriptive ("always do X", "never do Y") without explaining WHY, ask: "Why does this matter? What goes wrong without it?" Do not create the note until the rationale is provided.

**Step 2 — Check for duplicates**
Read existing files in `Memory/`. If overlap > 80% with an existing note, extend that note rather than creating a duplicate.

**Step 3 — Write the note**

Write to `Memory/[kebab-case-title].md`:

```markdown
---
type: methodology
created: YYYY-MM-DD
status: active
---

# [Describe the behaviour to adopt — not the problem]

## What to Do

[Clear, specific guidance]

## What to Avoid

[The specific anti-pattern this prevents]

## Why This Matters

[What goes wrong without this]

## When This Applies

[Scope — always? specific contexts?]
```

**Title pattern:** Describe what SHOULD BE DONE, not what went wrong.
- Bad: "duplicate creation issue"
- Good: "check for semantic duplicates before creating any document"

**Step 4 — Confirm**

> "Captured: [brief description] → Memory/[filename].md"

---

### Contextual Mode
**Triggered by:** `/remember` with no argument

Review the current conversation for corrections and redirections:

| Signal | Detection |
|---|---|
| Direct correction | "no", "that's wrong", "not like that" |
| Redirection | "actually", "instead", "stop" |
| Preference | "I prefer", "always do X", "never do Y" |

Present the most recent correction for confirmation:

> "Detected: [quoted user text]
> Interpreted as: [specific behavioural change]
> Capture this? (yes / no / modify)"

Wait for confirmation. Do not create notes from inferred corrections without approval.

---

### Session Mining Mode
**Triggered by:** `/remember --mine`

Scan recent conversation context for unmined corrections:
1. Look for correction signals (see contextual mode table)
2. Classify each as methodology note vs one-off event
3. Deduplicate against existing Memory/ notes
4. Create notes for clear patterns
5. Report what was captured

---

## Critical Constraints

- Never create notes from inferred corrections without user approval
- Never duplicate when an existing note covers the same friction (extend instead)
- Write titles as desired behaviours, not as problem descriptions
- Always include both "What to Do" AND "What to Avoid"

---
name: next
description: Surface the most valuable next action by combining incoming document pressure, knowledge base state, and workspace goals. Recommends one specific action with rationale. Triggers on "/next", "what should I do", "what's next", "what should I work on", "where should I start".
allowed-tools: Read, Grep, Glob, Bash, mcp__elab-contexta__elab_org_config
---

## Invariant

`/next` recommends. It does not execute.

---

## Step 1 — Load Context

Call `elab_org_config(action="read")` to get the org's folder structure and capability settings.

Then gather workspace signals:

| Signal | How to check |
|---|---|
| Incoming documents | Count files in `Incoming/` (excluding README.md) |
| Unprocessed docs | Age of oldest file in `Incoming/` |
| KB fullness | Count documents across core KB folders |
| Memory notes | Count files in `Memory/` |
| Capabilities enabled | From org config or `elab_capabilities` |

```bash
INCOMING=$(find "Incoming/" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')
OLDEST=$(find "Incoming/" -name "*.md" -not -name "README.md" 2>/dev/null | xargs ls -t 2>/dev/null | tail -1)
```

---

## Step 2 — Classify Priority

**Age-based urgency for Incoming:**

| Age | Priority |
|---|---|
| < 24 hours | Normal |
| 24–72 hours | Elevated |
| > 72 hours | Critical — recommend processing regardless of other signals |

---

## Step 3 — Generate Recommendation

**Priority cascade:**

1. **Critical Incoming** — any document > 72 hours old → recommend `/pipeline [filename]`
2. **Incoming pressure** — if 3+ files in Incoming/ → recommend processing the oldest
3. **KB gaps** — if core folders are empty and pipeline is enabled → suggest first capture
4. **Memory review** — if `Memory/` has recent notes → suggest reviewing and acting on them
5. **Session start** — if no signals → recommend `/health` to orient

**Specificity is mandatory:**
- Good: `/pipeline "Incoming/2026-04-01-team-meeting.md"`
- Bad: "process some incoming items"

---

## Step 4 — Output

```
/next

  Workspace:
    Incoming: [N] files ([oldest age] oldest)
    KB: [N] documents across [N] folders
    Memory: [N] notes

  Recommended: [specific command or action]

  Rationale: [1-2 sentences — why this action, what degrades if deferred]

  After that: [second priority, if clear]
```

---

## Edge Cases

**Everything clean:**
> "All clear — nothing urgent. Consider: capturing a recent decision or lesson in Decisions/ or Lessons/, or running `/health` for a full session orientation."

**No Incoming, no KB:**
> "Workspace is empty. Run `/setup` to configure your knowledge base, then drop a document in `Incoming/` to get started."

**MCP unavailable:**
Recommend local-only actions: review files, check Incoming/, run `/health` once the server reconnects.

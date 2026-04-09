---
name: brand-voice
description: Apply ELab brand voice and house style to text or a file. Removes corporate filler, tightens language, switches passive to active. Triggers on "/brand-voice", "apply brand voice", "make this sound like us", "apply house style", "clean up this writing", "tighten this up".
allowed-tools: Read, Write, mcp__elab-contexta__elab_brand_voice
---

## When to Use

User wants to apply ELab house style to a draft document or inline text before sharing it externally.

## Steps

### 1 — Get the content

- File specified → read it
- Inline text → use directly
- Neither → ask: "Which document or text would you like me to apply brand voice to?"

### 2 — Note style preferences

If the user mentions org-specific preferences ("avoid contractions", "Oxford comma", etc.), capture them as `style_profile`.

### 3 — Call elab_brand_voice

Pass `text` and optional `style_profile`.

### 4 — Present or write the result

**File input:**
Ask whether to overwrite or save as a new file. Default to `[filename]-bv.md` unless the user says to overwrite.

Write the result and confirm:
> "Brand voice applied. Saved as `brief-bv.md`."

**Inline input:**
Return the revised text in the response. Don't write a file unless asked.

## Errors

- Capability not enabled → "Brand voice isn't included in your current plan. Contact ELab to upgrade."
- API error → "Couldn't process this right now. Please try again."

## Notes

- Style and tone only — do not make substantive content changes. Flag to the user if meaning appears to have shifted.
- Preserve structural headings — don't rewrite titles to be "more creative".

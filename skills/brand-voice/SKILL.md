---
name: brand-voice
description: Apply ELab brand voice and house style to text or a document. Removes corporate filler, tightens language, and ensures the writing is direct and precise. Triggers on "/brand-voice", "apply brand voice", "make this sound like us", "apply house style", "clean up this writing", "tighten this up".
allowed-tools: Read, Write, mcp__elab-contexta__elab_brand_voice
---

## When to Use

- User wants to apply ELab's brand voice to text or a document
- User says "apply brand voice", "make this sound like us", "clean up this writing"
- User has a draft document that needs style refinement before sending

## How to Execute

### Step 1 — Get the content

If the user specified a file path, read the file.

If the user provided inline text (quoted or pasted), use that directly.

If neither, ask: "Which document or text would you like me to apply brand voice to?"

### Step 2 — Check for org style preferences

If the user mentions specific style preferences ("avoid contractions", "we use Oxford comma", etc.), note them as the `style_profile`.

### Step 3 — Call elab_brand_voice

Call `elab_brand_voice` with:
- `text`: the content to revise
- `style_profile`: optional — any org-specific preferences the user mentioned

### Step 4 — Present and write the result

**If the input was a file:**
Ask the user whether to overwrite the original or write to a new file:
> "Brand voice applied. Overwrite the original, or save as a new file?"

Default to a new file at the same path with `-bv` suffix (e.g. `brief.md` → `brief-bv.md`) unless the user says to overwrite.

Write the revised text to the chosen path.

Show a brief summary:
> "Brand voice applied to `brief.md`. Revised version saved as `brief-bv.md`."

**If the input was inline text:**
Present the revised text directly in the response. Do not write a file unless the user asks.

## If elab_brand_voice Returns an Error

- **Feature not enabled**: "Brand voice isn't included in your current plan. Contact ELab to upgrade."
- **API error**: "I couldn't process this right now. Please try again."

## Notes

- Do not make substantive content changes — only style and tone. If the brand voice tool changes meaning, flag it to the user.
- Do not rewrite headings to be more "creative" — preserve structural titles.
- For long documents (>2000 words), let the user know it may take a moment.

---
name: format
description: Export a markdown document as a formatted file — Word (DOCX), PDF, or PowerPoint (PPTX). Triggers on "/format", "export as Word", "make a PDF", "export as PDF", "save as PowerPoint", "/format [file] as [docx|pdf|pptx]".
allowed-tools: Read, Bash, mcp__elab-contexta__elab_format
---

## When to Use

User has a final markdown document ready to share externally and wants it as an office format.

## Steps

### 1 — Identify source and format

Parse the request for a file path and target format (`docx`, `pdf`, `pptx`). Ask if either is missing.

Read the full markdown content of the file.

### 2 — Determine output filename

Strip `.md` from the source filename: `Q4-Brief.md` → base name `Q4-Brief`.

### 3 — Call elab_format

Pass `content`, `format`, and `filename`.

### 4 — Write the binary file

The response contains `base64`, `filename`, and `size_bytes`.

Use Bash to decode and write the binary — the Write tool is text-only:

```bash
echo '<BASE64>' | base64 -d > '<OUTPUT_PATH>'
```

Verify with `ls -lh '<OUTPUT_PATH>'`.

### 5 — Confirm

> "Exported to `Q4-Brief.docx` (42 KB)."

If the workspace syncs to SharePoint via OneDrive, add: "It will appear in SharePoint shortly."

## Format Guide

| Format | Best for |
|---|---|
| `docx` | Documents to share and edit in Word |
| `pdf` | Read-only sharing |
| `pptx` | Slide decks from structured content |

## Errors

- Capability not enabled → "Document formatting isn't included in your current plan. Contact ELab to upgrade."
- API error → "Couldn't generate the file right now. Please try again."

## Notes

- Only process markdown files — if the user points to an existing DOCX, use the `docx` skill instead.
- The Bash decode step is required for binary output — do not use the Write tool for this.

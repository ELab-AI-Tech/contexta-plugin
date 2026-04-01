---
name: format
description: Export a document as a formatted file — Word (DOCX), PDF, or PowerPoint (PPTX). Reads a markdown source file, sends it to the Contexta server for conversion, and writes the output file to disk. Triggers on "/format", "export as Word", "make a PDF", "export as PDF", "format as PowerPoint", "save as PPTX", "/format [file] as [docx|pdf|pptx]".
allowed-tools: Read, Write, Bash, mcp__elab-contexta__elab_format
---

## When to Use

- User wants to export a markdown document to an office format
- User says "export as Word", "make a PDF", "save as PowerPoint"
- User has a final document ready to share externally

## How to Execute

### Step 1 — Identify the source file and format

Parse the user's request for:
- **File path** — the markdown document to export
- **Format** — `docx`, `pdf`, or `pptx`

If the file path is missing, ask: "Which file would you like to export?"

If the format is missing, ask: "Which format? Word (DOCX), PDF, or PowerPoint (PPTX)?"

Read the full content of the source file.

### Step 2 — Determine the output filename

Strip the `.md` extension from the source filename and use it as the base:
- `Q4-Strategy-Brief.md` → `Q4-Strategy-Brief` → `Q4-Strategy-Brief.docx`

### Step 3 — Call elab_format

Call `elab_format` with:
- `content`: full markdown content of the source file
- `format`: `docx`, `pdf`, or `pptx`
- `filename`: the base filename (no extension)

### Step 4 — Write the binary file

Parse the JSON response. Extract `base64`, `filename`, and `format`.

Use Bash to decode the base64 and write the binary file to the same directory as the source:

```bash
echo '<BASE64_CONTENT>' | base64 -d > '<OUTPUT_PATH>'
```

Substitute `<BASE64_CONTENT>` with the actual base64 string and `<OUTPUT_PATH>` with the full output file path.

Verify the file was written:
```bash
ls -lh '<OUTPUT_PATH>'
```

### Step 5 — Confirm to the user

> "Exported to `Q4-Strategy-Brief.docx` (42 KB) in the same folder as the source."

If the file will sync to SharePoint via OneDrive, add:
> "It will appear in SharePoint shortly."

## If elab_format Returns an Error

- **Feature not enabled**: "Document formatting isn't included in your current plan. Contact ELab to upgrade."
- **API error**: "I couldn't generate the file right now. Please try again."

## Format Guide

| Format | Best for | File size |
|---|---|---|
| DOCX | Documents to share and edit in Word | Smallest |
| PDF | Documents to share read-only | Medium |
| PPTX | Slide decks from structured content | Largest |

## Notes

- Only convert markdown files. If the user points to a DOCX or other binary, ask them to provide the markdown version.
- The Bash decode step writes a binary file — do not try to use the Write tool for this, it is text-only.
- For very long documents (>5000 words), PPTX export may take 30–60 seconds.

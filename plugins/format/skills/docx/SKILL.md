---
name: docx
description: "Use this skill whenever the user wants to create, read, edit, or manipulate Word documents (.docx files). Triggers include: any mention of 'Word doc', 'word document', '.docx', or requests to produce professional documents with formatting like tables of contents, headings, page numbers, or letterheads. Also use when extracting or reorganizing content from .docx files, inserting or replacing images in documents, performing find-and-replace in Word files, working with tracked changes or comments, or converting content into a polished Word document. If the user asks for a 'report', 'memo', 'letter', 'template', or similar deliverable as a Word or .docx file, use this skill. Do NOT use for PDFs, spreadsheets, Google Docs, or general coding tasks unrelated to document generation."
license: Proprietary. LICENSE.txt has complete terms
---

# DOCX creation, editing, and analysis (OfficeCLI)

**Primary tool:** [OfficeCLI](https://github.com/iOfficeAI/OfficeCLI) — single binary, no Microsoft Office install, path-based editing with `--json` output. Use it for create, read, modify, validate, and batch operations on `.docx` files.

---

## 1. Ensure OfficeCLI is installed

Run this at the start of any docx task if `officecli` is not on `PATH`:

```bash
if ! command -v officecli &> /dev/null; then
  curl -fsSL https://raw.githubusercontent.com/iOfficeAI/OfficeCLI/main/install.sh | bash
  export PATH="$HOME/.local/bin:$PATH"
fi
officecli --version
```

Verify with `officecli --version`. If install fails, see [OfficeCLI releases](https://github.com/iOfficeAI/OfficeCLI/releases) for platform binaries (e.g. `officecli-mac-arm64`).

---

## 2. Quick reference

| Task | OfficeCLI approach |
|------|-------------------|
| Read structure / text | `officecli view <file> text` or `annotated`, `outline`, `stats`, `issues` |
| Inspect an element | `officecli get <file> <path> [--depth N] --json` |
| Find content | `officecli query <file> "<selector>" --json` |
| Create blank file | `officecli create <file.docx>` |
| Add content | `officecli add <file> <parent-path> --type <element> --prop key=value` |
| Edit | `officecli set <file> <path> --prop key=value` |
| Remove / move | `officecli remove …`, `officecli move … --to … --index N` |
| Many edits at once | `officecli batch <file>` (JSON on stdin) |
| Quality check | `officecli validate <file>` and `officecli view <file> issues --json` |
| Escape hatch (rare) | `officecli raw`, `officecli raw-set` (XPath on OOXML parts) |

**Discover properties (do not guess):**

```bash
officecli docx set
officecli docx set paragraph
officecli docx query
```

---

## 3. Reading content

```bash
# Plain text / semantic views
officecli view report.docx text
officecli view report.docx annotated

# Tree of elements under body
officecli get report.docx /body --depth 2 --json
```

Use `query` for CSS-like search (see `officecli docx query` for selector syntax):

```bash
officecli query report.docx "paragraph:contains(TODO)" --json
```

---

## 4. Creating new documents

```bash
officecli create proposal.docx
# Add structure via add/set — use get --json to learn paths after first elements exist
officecli add proposal.docx /body --type paragraph --prop text="Title"
```

Prefer **one** `batch` invocation for many inserts when possible (single open/save).

---

## 5. Editing existing documents

1. `officecli view file.docx outline` or `text` — orient.
2. `officecli get file.docx /body --depth 1 --json` — list children / paths.
3. `officecli set` / `officecli add` / `officecli remove` / `officecli move` as needed.
4. `officecli validate file.docx` and `officecli view file.docx issues --json`.

**Self-healing:** On error with `--json`, inspect parent with `get … --depth 1 --json` and correct the path.

---

## 6. Typography and text quality

When setting text via `--prop text=…`, use proper typography for final deliverables:

- Prefer curly quotes and apostrophes in user-facing copy (e.g. `'` `'` `"` `"`) where appropriate.
- Do not rely on unicode bullet characters for lists — use Word list structures via `add`/`set` as supported by OfficeCLI (check `officecli docx add` help).

---

## 7. Legacy `.doc` and optional tools

**Legacy `.doc` (not OOXML):** Convert before editing, e.g. with LibreOffice headless if available in the environment:

```bash
python scripts/office/soffice.py --headless --convert-to docx document.doc
```

(Path is relative to this skill folder; from repo root use `.claude/skills/docx/scripts/office/soffice.py`.)

**PDF or flat text export:** If the environment has `pandoc`, it remains useful for one-way export (e.g. markdown). **Editing** the canonical `.docx` should go through OfficeCLI.

---

## 8. Fallback: unpack / pack scripts

Only if OfficeCLI cannot perform a specific low-level OOXML fix, the legacy scripts in `scripts/office/` (`unpack.py`, `pack.py`, `validate.py`) may be used. Prefer `officecli raw` / `raw-set` first.

---

## 9. Dependencies

| Dependency | Role |
|------------|------|
| **OfficeCLI** | Primary — create, read, edit, validate `.docx` |
| **LibreOffice** (`soffice`) | Optional — convert `.doc` → `.docx` via `scripts/office/soffice.py` |
| **pandoc** | Optional — export to other formats, not required for core workflow |

---

## 10. Further reading

- Upstream docs: [OfficeCLI README](https://github.com/iOfficeAI/OfficeCLI/blob/main/README.md)
- Remote skill file (optional): `curl -fsSL https://officecli.ai/SKILL.md`

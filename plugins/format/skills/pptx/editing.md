# Editing presentations with OfficeCLI

Use [OfficeCLI](https://github.com/iOfficeAI/OfficeCLI) for all template-based and free-form `.pptx` edits. Ensure the binary is installed (`pptx` SKILL.md install block).

---

## Template-based workflow

When using an existing presentation as a template:

1. **Analyze existing slides**
   ```bash
   officecli view template.pptx outline
   officecli get template.pptx / --depth 2 --json
   ```
   Optionally: `python scripts/thumbnail.py template.pptx` for a visual grid.

2. **Plan slide mapping**: For each content section, choose a template slide.

   **USE VARIED LAYOUTS** — monotonous presentations are a common failure mode. Seek:
   - Multi-column layouts (2-column, 3-column)
   - Image + text combinations
   - Full-bleed images with text overlay
   - Quote or callout slides
   - Section dividers
   - Stat/number callouts
   - Icon grids or icon + text rows

   **Avoid:** Repeating the same text-heavy layout for every slide.

3. **Edit with OfficeCLI** — use `get` / `query` to find slide and shape paths, then `set`, `add`, `remove`, `move`, or `batch` for atomic multi-step updates.

4. **Validate**
   ```bash
   officecli validate output.pptx
   officecli view output.pptx issues --json
   ```

5. **Iterate**: `officecli watch output.pptx` opens a live HTML preview while you adjust (optional).

---

## Commands reference

| Action | Pattern |
|--------|---------|
| List slides | `officecli get deck.pptx / --depth 1 --json` |
| Read slide | `officecli get deck.pptx /slide[N] --depth 2 --json` |
| Change text / fill / font | `officecli set deck.pptx /slide[1]/shape[1] --prop text="..." --prop ...` |
| Add slide | `officecli add deck.pptx / --type slide --prop title="..."` |
| Add shape | `officecli add deck.pptx /slide[1] --type shape --prop ...` |
| Batch | `echo '[{"command":"set","path":"/slide[1]/shape[1]","props":{"text":"Hello"}}]' \| officecli batch deck.pptx --stop-on-error` |

Run `officecli pptx set` and `officecli pptx add` for authoritative property lists.

---

## Legacy unpack/pack (last resort)

If a change cannot be expressed through OfficeCLI L2 commands, use `officecli raw` / `raw-set` on the relevant part, or the legacy `scripts/office/unpack.py` + `pack.py` flow documented in older revisions — prefer OfficeCLI first.

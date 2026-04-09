# Creating presentations from scratch (OfficeCLI)

This file previously documented PptxGenJS. **Use OfficeCLI** for new decks — see [OfficeCLI README](https://github.com/iOfficeAI/OfficeCLI/blob/main/README.md) and run `officecli pptx` help in the terminal.

Ensure `officecli` is installed (see main `pptx` SKILL.md).

---

## Minimal create flow

```bash
officecli create deck.pptx

# Add a slide with title and background colour (hex without #)
officecli add deck.pptx / --type slide --prop title="Q4 Report" --prop background=1A1A2E

# Add a text shape
officecli add deck.pptx /slide[1] --type shape \
  --prop text="Revenue grew 25%" --prop x=2cm --prop y=5cm \
  --prop font=Arial --prop size=24 --prop color=FFFFFF

# Inspect
officecli view deck.pptx outline
officecli validate deck.pptx
```

---

## Layout and coordinates

- Use `officecli get deck.pptx /slide[N] --depth 2 --json` to inspect positions and sizes after creation.
- Prefer **`officecli pptx set shape`** (and related help) for exact property names — do not guess.

---

## Rich decks

For multi-slide decks, prefer **`officecli batch`** with JSON on stdin so all mutations run in one open/save cycle.

---

## Design

Follow the **Design Ideas** section in the main `pptx` SKILL.md (colour, typography, spacing, anti-patterns).

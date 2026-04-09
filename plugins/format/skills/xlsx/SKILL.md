---
name: xlsx
description: "Use this skill any time a spreadsheet file is the primary input or output. This means any task where the user wants to: open, read, edit, or fix an existing .xlsx, .xlsm, .csv, or .tsv file (e.g., adding columns, computing formulas, formatting, charting, cleaning messy data); create a new spreadsheet from scratch or from other data sources; or convert between tabular file formats. Trigger especially when the user references a spreadsheet file by name or path — even casually (like \"the xlsx in my downloads\") — and wants something done to it or produced from it. Also trigger for cleaning or restructuring messy tabular data files (malformed rows, misplaced headers, junk data) into proper spreadsheets. The deliverable must be a spreadsheet file. Do NOT trigger when the primary deliverable is a Word document, HTML report, standalone Python script, database pipeline, or Google Sheets API integration, even if tabular data is involved."
license: Proprietary. LICENSE.txt has complete terms
---

# XLSX creation, editing, and analysis (OfficeCLI + Python)

**Primary tool for `.xlsx` structure and cell edits:** [OfficeCLI](https://github.com/iOfficeAI/OfficeCLI) — path-based addressing (e.g. `$Sheet:A1`), `--json` output, `batch` mode, validation.

**Use pandas** for statistical analysis, reshaping, and bulk reads. **Use `scripts/recalc.py`** after formulas change so cached values and error cells stay trustworthy.

---

## Ensure OfficeCLI is installed

At the start of any xlsx edit/create task if `officecli` is not on `PATH`:

```bash
if ! command -v officecli &> /dev/null; then
  curl -fsSL https://raw.githubusercontent.com/iOfficeAI/OfficeCLI/main/install.sh | bash
  export PATH="$HOME/.local/bin:$PATH"
fi
officecli --version
```

**Discover Excel-specific help:** `officecli xlsx set`, `officecli xlsx add`, `officecli view budget.xlsx text --help` (as available).

---

# Requirements for Outputs

## All Excel files

### Professional Font
- Use a consistent, professional font (e.g., Arial, Times New Roman) for all deliverables unless otherwise instructed by the user

### Zero Formula Errors
- Every Excel model MUST be delivered with ZERO formula errors (#REF!, #DIV/0!, #VALUE!, #N/A, #NAME?)

### Preserve Existing Templates (when updating templates)
- Study and EXACTLY match existing format, style, and conventions when modifying files
- Never impose standardized formatting on files with established patterns
- Existing template conventions ALWAYS override these guidelines

## Financial models

### Color Coding Standards
Unless otherwise stated by the user or existing template

#### Industry-Standard Color Conventions
- **Blue text (RGB: 0,0,255)**: Hardcoded inputs, and numbers users will change for scenarios
- **Black text (RGB: 0,0,0)**: ALL formulas and calculations
- **Green text (RGB: 0,128,0)**: Links pulling from other worksheets within same workbook
- **Red text (RGB: 255,0,0)**: External links to other files
- **Yellow background (RGB: 255,255,0)**: Key assumptions needing attention or cells that need to be updated

### Number Formatting Standards

#### Required Format Rules
- **Years**: Format as text strings (e.g., "2024" not "2,024")
- **Currency**: Use $#,##0 format; ALWAYS specify units in headers ("Revenue ($mm)")
- **Zeros**: Use number formatting to make all zeros "-", including percentages (e.g., "$#,##0;($#,##0);-")
- **Percentages**: Default to 0.0% format (one decimal)
- **Multiples**: Format as 0.0x for valuation multiples (EV/EBITDA, P/E)
- **Negative numbers**: Use parentheses (123) not minus -123

### Formula Construction Rules

#### Assumptions Placement
- Place ALL assumptions (growth rates, margins, multiples, etc.) in separate assumption cells
- Use cell references instead of hardcoded values in formulas
- Example: Use =B5*(1+$B$6) instead of =B5*1.05

#### Formula Error Prevention
- Verify all cell references are correct
- Check for off-by-one errors in ranges
- Ensure consistent formulas across all projection periods
- Test with edge cases (zero values, negative numbers)
- Verify no unintended circular references

#### Documentation Requirements for Hardcodes
- Comment or in cells beside (if end of table). Format: "Source: [System/Document], [Date], [Specific Reference], [URL if applicable]"
- Examples:
  - "Source: Company 10-K, FY2024, Page 45, Revenue Note, [SEC EDGAR URL]"
  - "Source: Company 10-Q, Q2 2025, Exhibit 99.1, [SEC EDGAR URL]"
  - "Source: Bloomberg Terminal, 8/15/2025, AAPL US Equity"
  - "Source: FactSet, 8/20/2025, Consensus Estimates Screen"

---

## Overview

Choose tools by task:

| Task | Tool |
|------|------|
| Inspect workbook / sheet / cell structure | OfficeCLI `view`, `get`, `query` |
| Set values, formulas, formats at known addresses | OfficeCLI `set`, `add`, `batch` |
| Aggregate, clean, analyse tabular data in Python | **pandas** |
| Recalculate after formula writes | **`python scripts/recalc.py`** (LibreOffice) |
| Rare: very specific openpyxl-only formatting | **openpyxl** (fallback) |

**LibreOffice** is assumed available for `scripts/recalc.py` (see script docstring / `soffice` wiring).

---

## CRITICAL: Use Formulas, Not Hardcoded Values

**Always use Excel formulas instead of calculating values in Python and hardcoding them.** This ensures the spreadsheet remains dynamic and updateable.

### Wrong — hardcoding calculated values
```python
# Bad: Calculating in Python and hardcoding result
total = df['Sales'].sum()
sheet['B10'] = total  # Hardcodes 5000
```

### Correct — formulas (via OfficeCLI or openpyxl)
Set the cell to a formula string, e.g. `=SUM(B2:B9)`, using OfficeCLI `set` on the cell path or openpyxl if already in Python.

---

## Reading and analysing data

### Quick inspection with OfficeCLI
```bash
officecli view model.xlsx text --max-lines 200
officecli get model.xlsx '/sheet[1]' --depth 1 --json
```

Use `officecli query` for selectors (see `officecli xlsx query` help).

### Data analysis with pandas
For data analysis, visualization, and bulk table operations:

```python
import pandas as pd

df = pd.read_excel('file.xlsx')
all_sheets = pd.read_excel('file.xlsx', sheet_name=None)

df.head()
df.info()
df.describe()
```

Use pandas for **analysis outputs**; write durable changes to `.xlsx` with **OfficeCLI** (or openpyxl when you need API parity).

---

## Common workflow (OfficeCLI-first)

1. **Orient:** `officecli view file.xlsx text` or `stats`; `officecli validate file.xlsx`
2. **Edit:** `officecli set`, `officecli add`, or `officecli batch file.xlsx` with JSON operations
3. **Recalculate (mandatory if formulas changed):** `python scripts/recalc.py output.xlsx`
4. **Verify:** Parse JSON from recalc script; fix `#REF!`, `#DIV/0!`, etc.; repeat

### Batch example (conceptual)
OfficeCLI supports cell addressing such as `$SheetName:A1` (see `officecli --help` and `officecli xlsx set`). Build batch JSON only after confirming property names:

```bash
officecli xlsx set cell
# Then, e.g. pipe JSON into:
officecli batch model.xlsx --stop-on-error --json < updates.json
```
Exact `path` and `props` keys must match the current CLI — do not guess.

---

## openpyxl (fallback)

Use **openpyxl** when OfficeCLI cannot express a formatting or workbook manipulation you need:

```python
from openpyxl import load_workbook
wb = load_workbook('existing.xlsx')
sheet = wb.active
sheet['A1'] = 'New Value'
wb.save('modified.xlsx')
```

After saving, still run **`scripts/recalc.py`** if formulas were added or changed.

---

## Recalculating formulas

Files modified by libraries often store formulas without fresh calculated values. Always:

```bash
python scripts/recalc.py <excel_file> [timeout_seconds]
```

The script returns JSON with error locations. Interpret `error_summary` and fix cells, then recalc again.

---

## Formula Verification Checklist

### Essential Verification
- [ ] **Test 2-3 sample references**: Verify they pull correct values before building full model
- [ ] **Column mapping**: Confirm Excel columns match (e.g., column 64 = BL, not BK)
- [ ] **Row offset**: Remember Excel rows are 1-indexed (DataFrame row 5 = Excel row 6)

### Common Pitfalls
- [ ] **NaN handling**: Check for null values with `pd.notna()`
- [ ] **Far-right columns**: FY data often in columns 50+
- [ ] **Multiple matches**: Search all occurrences, not just first
- [ ] **Division by zero**: Check denominators before using `/` in formulas (#DIV/0!)
- [ ] **Wrong references**: Verify all cell references point to intended cells (#REF!)
- [ ] **Cross-sheet references**: Use correct format for linking sheets

### Interpreting scripts/recalc.py output
```json
{
  "status": "success",
  "total_errors": 0,
  "total_formulas": 42,
  "error_summary": { "#REF!": { "count": 2, "locations": ["Sheet1!B5"] } }
}
```

---

## Best Practices

### Library selection
- **OfficeCLI**: Default for cell/sheet edits, validation, structured JSON, batch pipelines
- **pandas**: Analysis, cleaning, reading large extracts
- **openpyxl**: Fallback for fine-grained styling when OfficeCLI is insufficient
- **recalc.py**: Mandatory verification after formula changes

### Working with pandas
- Specify dtypes: `pd.read_excel('file.xlsx', dtype={'id': str})`
- Large files: `usecols=[...]`, `read_only` patterns as needed

---

## Code Style Guidelines

**When generating Python code for Excel operations:**
- Write minimal, concise Python code without unnecessary comments
- Avoid verbose variable names and redundant operations
- Avoid unnecessary print statements

**For Excel files themselves:**
- Add comments to cells with complex formulas or important assumptions
- Document data sources for hardcoded values
- Include notes for key calculations and model sections

---

## Dependencies

| Dependency | Role |
|------------|------|
| **OfficeCLI** | Primary editor/validator for `.xlsx` |
| **pandas / openpyxl** | Analysis; openpyxl fallback |
| **LibreOffice** | Used by `scripts/recalc.py` for formula evaluation |

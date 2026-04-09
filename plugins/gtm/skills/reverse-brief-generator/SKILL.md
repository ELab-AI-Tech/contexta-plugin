---
name: reverse-brief-generator
description: "Generate a structured Reverse Brief from a discovery call transcript or meeting notes. Use this skill whenever someone has completed a discovery meeting and needs to create a reverse brief, or when given a Circleback transcript, meeting notes, or call recording summary and asked to produce a brief, proposal, or client-facing summary of what was discussed. Also trigger when someone says 'write up the brief', 'create the reverse brief', 'summarise the discovery call', or references Stage 6 of the pipeline. The skill extracts, structures, and formats the brief — it does NOT send it. Human review is always required before sending."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Reverse Brief Generator

Extract a structured Reverse Brief from a discovery call transcript or meeting notes. The Reverse Brief is ELab's core proposal document — it reflects back what was discussed, proposes the engagement, and once confirmed by the client, becomes the basis for the SOW/MSA.

## When to use this skill

- A discovery meeting (Stage 5) has been completed
- A Circleback transcript, meeting notes, or call summary is available
- Someone asks to write up, draft, or create the reverse brief
- A reverse brief needs refreshing after a follow-up call

## Inputs

| Field | Required | Source |
|---|---|---|
| Meeting transcript or notes | Yes | Circleback, Gemini notes, manual notes, or any text summary of the meeting |
| Client Deep Research dossier | Helpful | Output from the Client Deep Research skill — provides company context, stakeholder map, and pre-meeting hypotheses |
| Persona | Helpful | Industrial / Financial Services / Professional Services — determines which case studies to reference |
| Contact details | Helpful | Client contact name, role, email — for the brief sign-off section |
| Deal record (Notion) | Helpful | If deal exists, pull linked account, contacts, services, and context from Pipeline Manager |

---

## Process

### Stage 1: Extract and structure the Reverse Brief

Read the transcript/notes and produce a prose Reverse Brief covering these 15 sections. Not all sections will be relevant to every engagement — use judgment on which to include, but the first 8 are always required.

**Always required:**

1. **Our Understanding** — who the client is, what they do, scale of operations (2-3 sentences). Then their key challenges as distinct items (4-6 challenges, each with a short title and 1-2 sentence description).

2. **Business Impact** — how the challenges compound operationally. Two paragraphs: first shows understanding of the pain, second transitions to the opportunity.

3. **Proposed Engagement** — the formal engagement name, 4 clear objectives, and a one-sentence value proposition callout.

4. **Standalone Value** — 6 specific outcomes the client gets from this engagement regardless of whether they proceed to further phases.

5. **Phase Details** — break the engagement into phases (typically 2-3). For each: title, description, duration/format, list of topics or activities, and a key outcome.

6. **Investment & Timeline** — exact amount (confirm currency and tax treatment), what's included, duration, delivery model, proposed start date. Never guess figures — use `[CONFIRM: ...]` if not discussed.

7. **Success Criteria** — 8 measurable or observable outcomes that define success for this engagement.

8. **Next Steps** — 4 concrete next steps (Review brief → Schedule follow-up → Confirm SOW → Align stakeholders).

**Include when relevant:**

9. **AI Opportunities** — 6 specific AI use cases identified during discovery. Each with a title, description of what it does, and an impact metric.

10. **Technical Considerations** — regional, infrastructure, or platform constraints discussed (e.g. corporate IT policies, Copilot positioning, data sovereignty).

11. **Corporate IT** — if IT approval or corporate governance is a factor, capture the constraint and what ELab delivers to address it.

12. **Deliverables** — table of 6-8 tangible deliverables with names and descriptions.

13. **Future Phases** — 3 phases beyond the current engagement with indicative pricing and scope.

14. **Why ELab** — 4 differentiators tailored to this client's context.

15. **Relevant Experience** — 2 case studies most relevant to this client. Source from the case study library at `01_Sales_Enablement/Case Studies/_Case_Study_Index.md`. Include company type (not name), location, challenge, solution, and impact metrics. **Never fabricate case study details.**

### Stage 2: Quality check

Before presenting the brief, verify:

- [ ] Every claim traces back to something said in the transcript — nothing fabricated or assumed
- [ ] Challenges are specific to this client, not generic consulting language
- [ ] Investment figures are exact (or marked `[CONFIRM: ...]`)
- [ ] Case studies are real and sourced from the ELab library
- [ ] UK/NZ English spelling throughout (organisation, colour, programme)
- [ ] No em-dashes or en-dashes — use hyphens or rewrite
- [ ] The brief could be sent to the client as-is after human review

### Stage 3: Present for human review

**Always present the prose Reverse Brief to the user for review before any further processing.** This is a required checkpoint.

Ask the user to confirm:
- Content is accurate (especially investment figures, client details, case studies)
- Nothing important is missing from the discovery conversation
- Any `[CONFIRM: ...]` placeholders have been resolved
- Tone and framing are appropriate for this client

Do not proceed to deck generation or document formatting until confirmed.

### Stage 4: Generate structured JSON for branded deck

Once the prose brief is confirmed, extract it into JSON format for the deck generator. This is a **standard step** — the branded deck is a core deliverable, not optional.

Follow the extraction rules in `references/REVERSE_BRIEF_EXTRACTION_GUIDE.md` for:
- Exact word counts and array lengths per field
- Icon assignments from the icon library
- Content compression rules (titles 3-5 words, descriptions 15-25 words, etc.)
- Case study sourcing and formatting

The JSON schema and slide-by-slide specification are in `references/REVERSE_BRIEF_DECK_SYSTEM.md`.

**JSON output is saved alongside the prose brief in the client folder.**

### Stage 5: Generate branded deck and executive summary

Using the confirmed JSON, generate:

1. **Branded deck** — 18-slide HTML/PDF deck following the design system in `references/REVERSE_BRIEF_DECK_SYSTEM.md` (1920x1080, ELab brand colours, Poppins/Inter fonts, base64-embedded logo)
2. **Executive summary** — A4 PDF companion document (same brand, condensed one-pager)

Both are saved to the client folder.

> If the Document Creator skill is available, hand off JSON + design system to it for final rendering. If not, generate directly using the deck system specification.

### Stage 6: Hand off to Pipeline Manager

After all outputs are saved:

1. **Attach summary** to Notion deal page (not the full brief — see Output Destination below)
2. **Advance stage** — Initial Meet → Reverse Brief Sent
3. **Set date** — Date Reverse Brief Sent
4. **Save to client folder** — all files in `ELab AI Advisory/Clients/<Client Name>/`

---

## Output format

The primary output is the prose Reverse Brief in this structure:

```
# Reverse Brief: [Client Name]

> **Engagement:** [Engagement Name]
> **Date:** [Month Year]
> **Prepared by:** [Name], ELab
> **For:** [Client Contact Name], [Client Contact Role]

---

## Our Understanding

[2-3 sentence situation summary — who they are, what they do, scale]

### Key Challenges

**[Challenge Title 1]**
[1-2 sentence description]

**[Challenge Title 2]**
[1-2 sentence description]

(4-6 challenges)

---

## Business Impact

[Paragraph 1: How challenges compound — empathetic, shows understanding. 40-60 words]

[Paragraph 2: The opportunity, transition to solution. 40-60 words]

---

## Proposed Engagement: [Engagement Name]

**Objectives:**
1. [Objective title] — [8-12 word description]
2. [Objective title] — [8-12 word description]
3. [Objective title] — [8-12 word description]
4. [Objective title] — [8-12 word description]

[Value proposition callout — one sentence, 20-35 words]

---

## Standalone Value

Regardless of whether you proceed to further phases, this engagement delivers:

1. **[Value item]** — [10-15 word outcome description]
2. **[Value item]** — [10-15 word outcome description]
(6 items)

---

## Phase Details

### Phase 1: [Title]
[Duration and format]

**Topics/Activities:**
- [item]
- [item]
(6-8 items)

**Key outcome:** [15-25 words]

### Phase 2: [Title]
(same structure)

### Phase 3: [Title] (if applicable)
(same structure)

---

## Investment & Timeline

- **Investment:** [amount] [currency + tax]
- **Includes:** [list what's included]
- **Duration:** [X weeks/months]
- **Delivery:** [model — e.g. remote via video conference]
- **Proposed start:** [date]

---

## Success Criteria

1. [Measurable outcome — 8-15 words]
2. [Measurable outcome]
(8 items)

---

## Next Steps

1. **Review** — Confirm this brief accurately captures your situation
2. **Schedule** — Follow-up call to discuss and refine
3. **Confirm** — Issue Statement of Work for signature
4. **Align** — Involve key stakeholders and confirm kick-off date

---

(Include remaining sections 9-15 as relevant — see Stage 1 above)
```

---

## Content rules

1. **Compress, don't summarise** — keep the meaning, cut the filler
2. **Specific over generic** — keep client-specific details, cut consulting jargon
3. **Do not fabricate** — every field must trace to the transcript or research dossier. If something is missing, use `[CONFIRM: description of what's needed]`
4. **Case studies must be real** — source from the ELab case study library:
   - Industrial: [AI-powered maintenance ops](https://elab.co.nz/resources/case-studies/ai-powered-maintenance-operations-transformation), [Bridge It NZ](https://elab.co.nz/resources/case-studies/de-risking-ai-adoption-for-industrial-operations-a-case-study-with-bridge-it-nz)
   - Financial Services: [AI-driven PE operations](https://elab.co.nz/resources/case-studies/ai-driven-private-equity-operations)
   - Professional Services: [AI-enabled professional services](https://elab.co.nz/resources/case-studies/ai-enabled-professional-services-operations)
5. **UK/NZ English** — organisation, colour, programme
6. **No em-dashes or en-dashes** — use hyphens or rewrite
7. **Include a price range and indicative timeline** — the Reverse Brief should frame the commercial conversation. Exact figures are confirmed at the SOW stage.
8. **Include a high-level scheduling outline** — proposed start window, key milestones, approximate duration. Firm dates are confirmed at SOW stage.

---

## Output destination

### Primary outputs — standalone documents in client folder

All outputs are saved to `ELab AI Advisory/Clients/<Client Name>/`:

| File | Format | Purpose |
|---|---|---|
| `DRAFT_Reverse-Brief_<Client>_<Engagement>.md` | Markdown | Prose brief for human review and editing |
| `Reverse-Brief_<Client>_<Engagement>.json` | JSON | Structured data for deck generator |
| `Reverse-Brief_<Client>_<Engagement>.pdf` | PDF | Branded 18-slide deck (client-facing) |
| `Reverse-Brief_<Client>_Executive-Summary.pdf` | PDF | A4 one-page summary (client-facing) |

### Notion (via Pipeline Manager)

Attach a summary to the deal page — not the full brief:

```
--- Reverse Brief Generator Output ([Date]) ---

Brief: DRAFT_Reverse-Brief_<Client>_<Engagement>.md saved to client folder
Engagement: [Engagement Name]
Investment: [Amount] [Currency + Tax] | Duration: [X weeks]
Deck: [Generated / Pending human review / Not yet generated]
Status: [Draft — pending human review / Confirmed — ready to send]

Full brief and deck in client folder: [path or Drive link]
```

---

## References

These files are included in the `references/` folder within this skill's plugin directory:

- `references/REVERSE_BRIEF_EXTRACTION_GUIDE.md` — field-by-field JSON extraction rules with word counts, array lengths, icon assignments, and content compression examples
- `references/REVERSE_BRIEF_DECK_SYSTEM.md` — complete design system for the branded deck: slide dimensions, CSS, typography, card components, layout grids, logo handling, slide-by-slide specification, and JSON schema

Additional references:
- [Pricing & Commercials Guide](https://docs.google.com/document/d/1whWfBs0oPH5yqUP4cVHi9L2756J_h5OJ2S9zhrr2KoU/edit) — for investment figures and rate card
- [Case Study Index](./01_Sales_Enablement/Case%20Studies/_Case_Study_Index.md) — for sourcing relevant experience

---

## Notes for agents

- This skill works with any LLM. No web search required — the input is the transcript/notes
- The prose Reverse Brief is the primary content output. The JSON extraction and deck generation are standard follow-on steps.
- Human review is mandatory before sending anything to the client
- If the transcript is thin or key information is missing (especially investment figures), flag it explicitly rather than filling gaps with assumptions
- The output feeds into the Contract Assembler skill (Skill 8) once confirmed by the client
- The branded deck is a core deliverable — generate it for every engagement, not just "when asked"
- When the Document Creator skill is available, use it for final rendering. Until then, generate directly from the deck system specification.

---

## Handoff

**After this skill completes:**

1. Save all outputs to client folder (prose brief, JSON, deck PDF, executive summary)
2. Pipeline Manager: attach summary to deal, advance stage Initial Meet → Reverse Brief Sent, set Date Reverse Brief Sent
3. **Suggest next skill: Communications Drafter [3]** — type `reverse_brief_cover` — to send the brief to the client
4. After brief is sent, monitor for client response:
   - Client confirms brief → **Contract Assembler [7]**
   - Client gives feedback/pushback → **Negotiation Advisor [6]**
   - No response after 5+ days → **Communications Drafter [3]** type `followup_no_response`

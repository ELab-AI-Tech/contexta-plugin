---
name: client-deep-research
description: "Run structured deep research on a prospect company and key contacts for ELab's sales pipeline. Use this skill after a lead has been qualified as GO by the Lead Qualifier — not before. Also trigger before a discovery meeting, or when someone explicitly asks to research a prospect ('deep research', 'prospect research', 'what do we know about [company]', 'pre-meeting research'). Do NOT trigger on a new lead mention alone — the lead must be qualified first. This skill produces a structured research dossier that feeds outreach, meeting prep, and the reverse brief."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Client Deep Research

Produce a structured research dossier on a prospect company and its key contacts for ELab's sales pipeline. The dossier is used for lead qualification (Stage 2), discovery meeting prep (Stage 5), and outreach personalisation (Stage 3).

## When to use this skill

- A new lead has been added to the pipeline and needs qualifying
- A discovery meeting has been booked and the sales lead needs prep
- Someone asks to research a company or contact for BD purposes
- The research dossier is older than 2 weeks and a meeting is coming up (refresh)

## Inputs

The minimum required input is a **company name**. Everything else improves quality but isn't mandatory.

| Field | Required | Example | Source |
|---|---|---|---|
| Company name | Yes | "Acme Industrial Ltd" | User or deal record |
| Company website | Helpful | "acmeindustrial.co.nz" | User, deal, or web search |
| Key contact name(s) | Helpful | "John Smith (CEO), Sarah Lee (COO)" | User or Notion Contacts database |
| LinkedIn URL(s) | Optional | LinkedIn profile URLs | User or Notion Contacts |
| Lead source / context | Optional | "Referral from Julian at Potentia" | Deal page body |
| Target persona | Optional | Industrial / Financial Services / Professional Services | Inferred from research |
| Notion deal page ID | Optional | Deal in the Opportunities database | If deal exists, pull linked data |

If the persona isn't specified, infer it from the research.

### Enrichment from Pipeline Manager (Notion)

If a deal exists in the pipeline, pull existing data before starting web research. This avoids duplicating known information and gives the research a head start.

**Pull from the deal record:**
```
1. API-retrieve-a-page with the deal page_id
   → Extract: deal name, stage, services, estimated value, source, context notes

2. Follow Accounts relation → API-retrieve-a-page
   → Extract: company name, status, website, billing address, industry, location, headcount

3. Follow Primary Contacts relation → API-retrieve-a-page for each
   → Extract: name, title/role, role type, email, phone, LinkedIn URL, linked account

4. Read deal page body → API-get-block-children
   → Extract: lead type, owner, source detail, meeting notes, any prior context
```

Use this data to pre-populate the dossier and focus web research on gaps. If a contact has no LinkedIn URL in Notion, prioritise finding it. If the company has no website, find it first.

---

## Research process

Run these six research streams. Use web search for each. Spend more time on streams 1, 2, and 3 — they're the foundation everything else builds on.

### Stream 1: Company research

Search for the company by name and website. Look for:

- What the company does, in plain language (2-3 sentences)
- Industry and sub-sector
- Size indicators: employee count, revenue estimates, number of locations/offices
- Ownership structure (private, PE-backed, family-owned, public)
- Geographic footprint (NZ, Australia, Asia-Pacific, global)
- Key executives and leadership team
- Recent news (last 6-12 months): funding, acquisitions, expansion, restructuring, new hires, product launches
- Strategic direction: any public statements about growth plans, digital transformation, operational priorities

### Stream 2: Contact research

For each key contact, search LinkedIn and the web:

- Current role and tenure
- Career history (previous companies and roles — especially relevant industry experience)
- Any published content, speaking engagements, podcast appearances, or LinkedIn posts
- Mutual connections within ELab's network (referral partners, existing clients)
- Communication style cues (formal/informal, technical/strategic, from their public content)
- Contact details: email, phone, LinkedIn URL (update Notion if found and not already there)

### Stream 3: Stakeholder mapping

Using contacts from the deal plus any discovered through company and web research, build a stakeholder map:

- **Org position:** Where each contact sits in the organisation (executive, senior management, middle management, operational)
- **Reporting line:** Who they likely report to. If the contact is not the CEO/MD, identify their likely manager or the executive sponsor above them.
- **Decision maker:** Who ultimately signs off on engagements like this? If the primary contact is an IT Manager or Ops lead, the decision maker is likely a C-suite exec, partner, or board member. Identify them by name if possible.
- **Role in the buying process:** Classify each contact:

| Role Type | Definition | Example |
|---|---|---|
| **Decision Maker** | Has authority and budget to approve the engagement | CEO, MD, Partner, CFO |
| **Champion** | Actively advocates for the engagement internally | IT Manager, Innovation Lead, COO |
| **Technical Contact** | Evaluates technical feasibility and requirements | CTO, IT Director, Systems Admin |
| **Gatekeeper** | Controls access to decision makers or information | EA, Procurement, Legal |
| **Influencer** | Shapes opinions but doesn't have direct authority | Board advisor, consultant, peer exec |

- **Missing stakeholders:** Flag if the deal has no identified decision maker. Recommend who to ask about or request an intro to. This is critical — if we're only talking to the champion and not the decision maker, the deal may stall.
- **Stakeholder dynamics:** Any signals about internal politics, competing priorities, or organisational change (e.g. recent CEO departure, restructuring, mergers) that affect who holds power.

> **Update Notion contacts:** If stakeholder research identifies new people who should be tracked (e.g. the CEO who hasn't been added), flag them for creation via Pipeline Manager. If role types can be determined, recommend setting them on existing contact records.

### Stream 4: Industry context

Based on the company's sector:

- 2-3 major industry trends relevant to AI adoption
- Common operational pain points in this sector
- Competitive landscape (who are their peers, are competitors adopting AI)
- Regulatory or compliance factors that affect technology adoption

### Stream 5: AI readiness signals

Look for indicators of how ready this company is for AI:

- Tech stack mentions (job postings, case studies, partnerships)
- Any existing AI/automation initiatives mentioned publicly
- Job postings mentioning AI, data, automation, digital transformation
- IT maturity signals (cloud adoption, modern systems vs. legacy)
- Public statements from leadership about technology or innovation

### Stream 6: Pain point hypotheses

Based on everything above, generate 3-5 specific hypotheses about where ELab could add value. Each hypothesis should include:

- The pain point (specific, not generic)
- Why you believe it exists (evidence from research)
- Which ELab service area addresses it
- Which case study is most relevant as a proof point

Use the persona-specific case studies from the playbook:

**Industrial & Heavy Ops:**
- [AI-powered maintenance operations transformation](https://elab.co.nz/resources/case-studies/ai-powered-maintenance-operations-transformation)
- [De-risking AI adoption for industrial operations (Bridge It NZ)](https://elab.co.nz/resources/case-studies/de-risking-ai-adoption-for-industrial-operations-a-case-study-with-bridge-it-nz)

**Financial Services / Family Offices:**
- [AI-driven private equity operations](https://elab.co.nz/resources/case-studies/ai-driven-private-equity-operations)

**General Business / Professional Services:**
- [AI-enabled professional services operations](https://elab.co.nz/resources/case-studies/ai-enabled-professional-services-operations)

---

## Output format

Produce the dossier in this exact structure. Keep it concise — this is a working document, not a report. Each section should be scannable in under 30 seconds.

```
# Client Deep Research: [Company Name]

> **Date:** [date]
> **Researcher:** [agent or human name]
> **Lead source:** [source]
> **Persona:** [Industrial / Financial Services / Professional Services / TBD]
> **Deal:** [deal name and Notion link, if exists]

## 1. Company snapshot

[2-3 sentence plain-English summary of what the company does, how big they are, and where they operate]

- **Industry:** [sector / sub-sector]
- **Size:** [employees, revenue if known]
- **Ownership:** [private / PE-backed / family / public]
- **Geography:** [locations]
- **Website:** [URL]

## 2. Key contacts & stakeholder map

### [Contact Name] - [Role]
- **Org position:** [executive / senior management / middle management / operational]
- **Role in buying process:** [Decision Maker / Champion / Technical Contact / Gatekeeper / Influencer]
- **Reports to:** [name and title, if identifiable — or "Unknown"]
- **Tenure:** [how long in role]
- **Background:** [1-2 sentences on career history]
- **Public content:** [any articles, posts, talks — or "None found"]
- **Mutual connections:** [any shared connections with ELab network]
- **Style notes:** [formal/informal, technical/strategic — if discernible]
- **Contact details:** [email, phone, LinkedIn — flag if missing]

(Repeat for each contact)

### Stakeholder assessment

| Contact | Role Type | Org Level | Authority to Sign? |
|---|---|---|---|
| [Name] | [Champion] | [Middle Management] | No — needs [Name/Title] above |
| [Name] | [Decision Maker] | [Executive] | Yes |

**Decision maker identified:** [Yes / No — if no, flag this prominently]
**Recommended action:** [e.g. "Ask Cam Russell who has budget authority for external consulting engagements" or "Request intro to CEO via James"]

## 3. Recent news and strategic moves

- [Date] - [headline / event / announcement] ([source])
- [Date] - [headline / event / announcement] ([source])
(List 3-6 most relevant items, most recent first)

## 4. Industry context

- [Trend 1 and why it matters to this company]
- [Trend 2]
- [Competitive landscape note]

## 5. AI readiness assessment

| Signal | Finding |
|---|---|
| Tech stack | [what's known] |
| Existing AI initiatives | [yes/no, details] |
| Digital transformation signals | [evidence] |
| IT maturity | [modern/mixed/legacy] |
| Leadership attitude to tech | [evidence] |

**Overall AI readiness:** [Early / Emerging / Ready / Advanced]

## 6. Pain point hypotheses

### Hypothesis 1: [specific pain point]
- **Evidence:** [what from the research supports this]
- **ELab service:** [which service addresses this]
- **Relevant case study:** [title + link]
- **Confidence:** [High / Medium / Low]

### Hypothesis 2: [specific pain point]
(same structure)

### Hypothesis 3: [specific pain point]
(same structure)

## 7. Outreach hook

**Recommended hook for initial contact:**
[1-2 sentences — the most compelling, personalised angle for the outreach email. Should connect a specific recent event or pain point to what ELab does.]

## 8. ICP fit assessment

| Criterion | Assessment |
|---|---|
| Budget alignment | [Met / Likely / Unknown / Not Met] - [brief note] |
| Business readiness | [Met / Likely / Unknown / Not Met] - [brief note] |
| Strategic fit | [Met / Likely / Unknown / Not Met] - [brief note] |
| Red flags | [None / list any] |

**Preliminary recommendation:** [Go / Needs More Info / No-Go]
```

---

## Output destination

### Primary output — standalone document

Save the dossier as a markdown file in the client folder:

**Path:** `ELab AI Advisory/Clients/<Client Name>/CLIENT-DEEP-RESEARCH_<Client-Short-Name>_<Date>.md`
**Example:** `ELab AI Advisory/Clients/CLM Law (Cooney Lees Morgan)/CLIENT-DEEP-RESEARCH_CLM-Law_2026-03-11.md`

### Notion (via Pipeline Manager)

Attach a summary to the deal page body — not the full dossier:

```
--- Client Deep Research Output ([Date]) ---

Dossier: CLIENT-DEEP-RESEARCH_<Client>_<Date>.md saved to client folder
Persona: [persona]
AI Readiness: [Early / Emerging / Ready / Advanced]
ICP Fit: [Go / Needs More Info / No-Go]
Decision Maker: [Identified: Name / NOT IDENTIFIED — action needed]
Key Hypothesis: [top pain point in one sentence]

Full dossier in client folder: [path or Drive link]
```

### Pipeline Manager actions after dossier is complete

1. **Attach summary** to deal page body
2. **Advance stage** — Lead → Pre Pipeline Discovery (if at Lead)
3. **Set date** — Date Pre Pipeline Discovery
4. **Update contacts** — if new stakeholders identified, flag for creation
5. **Update Account** — if industry, location, headcount discovered, update Account record

---

## Quality checklist

Before delivering the dossier, verify:

- [ ] Company snapshot is specific, not generic (would someone at the company recognise the description?)
- [ ] Stakeholder map identifies a decision maker (or explicitly flags that one is missing with a recommended action)
- [ ] Each contact has a role type assigned (Decision Maker / Champion / Technical Contact / Gatekeeper / Influencer)
- [ ] Pain point hypotheses cite specific evidence, not just "they probably have this problem"
- [ ] Outreach hook references something concrete and recent
- [ ] ICP fit assessment is honest — if information is unknown, say so rather than guessing "Likely"
- [ ] All source links are included for verifiable claims
- [ ] Contact details are as complete as possible (flag any missing email, phone, LinkedIn)
- [ ] The whole thing is scannable in under 3 minutes
- [ ] Dossier saved to client folder as standalone document
- [ ] Summary attached to Notion deal (not full dossier)

---

## Notes for agents

- This skill works with any LLM that has web search capability
- If a Notion deal exists, always pull existing data first — don't duplicate research
- If LinkedIn data is restricted, note "LinkedIn profile not accessible" and work with what's publicly available
- If the company has very little public information, say so explicitly — a thin dossier with honest "Unknown" fields is more useful than a padded one
- When refreshing an existing dossier, focus on Streams 1, 3, and 6 (new developments, stakeholder changes, and updated hypotheses)
- The output feeds directly into the Lead Qualifier skill and Discovery Prep skill — maintain the structured format so they can parse it
- The stakeholder map is critical for the sales team — knowing who the decision maker is (or that we don't know) is often the most valuable output

---

## Handoff

**After this skill completes:**

1. Save the dossier to the client folder (Google Drive)
2. Attach summary to the Notion deal via Pipeline Manager — advance stage: Lead → Pre Pipeline Discovery, set Date Pre Pipeline Discovery
3. **Suggest next skill: Communications Drafter [3]** — the dossier now unlocks outreach. Pass the research dossier and the Lead Qualifier GO result as context. Communication type (outbound_cold, outbound_referral, inbound_response) is determined by lead type.
4. Flag if the dossier is thin (limited public info) — note the gaps but proceed. Comms Drafter will work with what's available.

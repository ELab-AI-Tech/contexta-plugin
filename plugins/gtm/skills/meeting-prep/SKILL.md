---
name: meeting-prep
description: "Generate a briefing document for any upcoming client or prospect meeting. Use this skill when a meeting is booked, when someone asks for a briefing, prep doc, meeting brief, or discovery prep, or references Stage 5 of the pipeline. Also trigger for 'prep me for the [client] meeting', 'what do I need to know before the call with [name]', 'briefing for [company]', or 'discovery prep'."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Meeting Prep

Generate a single briefing document that tells whoever is walking into the meeting everything they need to know — who they're meeting, what to cover, what to listen for, what to avoid, and what success looks like. One document, ready to skim 10 minutes before the call.

## When to use this skill

- A meeting has been booked with a prospect or client
- Someone asks for a briefing, prep doc, or meeting prep
- A discovery meeting is approaching (Stage 5)
- A reverse brief walkthrough is scheduled (Stage 6)
- A SOW/contract walkthrough is scheduled (Stage 8)
- A kickoff meeting is approaching (Stage 9)
- A check-in or review meeting is scheduled (post-engagement)
- A meeting with a referral partner or intermediary is planned

## When NOT to use

- No meeting is booked (run Communications Drafter to get one booked first)
- The meeting is internal only (team standups, retros, etc.)
- The meeting is a casual coffee catch-up with no pipeline context

---

## Meeting Types

| Meeting Type | Pipeline Stage | Primary Purpose |
|---|---|---|
| `discovery` | 5 (Initial Meet) | Understand the client's challenges, gain agreement to receive a Reverse Brief |
| `reverse_brief_walkthrough` | 6 (Reverse Brief Sent) | Walk through the brief, get confirmation or feedback |
| `sow_walkthrough` | 8 (SOW/MSA) | Walk through contracts, address questions, get to signature |
| `kickoff` | 9 (Won) | Launch the engagement, set expectations, introduce the team |
| `check_in` | Post-engagement | Review progress, surface expansion opportunities, maintain relationship |
| `partner` | Any | Meeting with a referral partner, intermediary, or co-delivery partner |

---

## Inputs

| Input | Required | Source | Notes |
|---|---|---|---|
| `meeting_type` | Yes | Inferred from context or specified | One of the types above |
| Meeting details | Yes | Calendar invite or human provides | Date, time, location/Zoom, attendees |
| Deal record (Notion) | Yes | Pipeline Manager | Account, contacts, services, stage, history |
| Research dossier | Yes (discovery, partner) | Client folder | Company snapshot, pain points, stakeholder map |
| Client folder | Yes | Convention: `ELab AI Advisory/Clients/<Client Name>/` | All accumulated materials |
| Case Study Index | Yes (discovery) | `01_Sales_Enablement/Case Studies/_Case_Study_Index.md` | For selecting relevant proof points |
| Discovery Questions template | Helpful (discovery) | `00_Templates_and_SOPs/TEMPLATE - Discovery & Qualification Questions (ELab Advisory).gdoc` | Base questions to tailor |

---

## Process

### Step 1: Gather context

Pull everything available:

**From Notion deal:**
- Account, contacts (names, roles, seniority), services tagged
- Current stage, lead source, relationship temperature
- All notes and skill outputs already attached to the deal
- History of communications and stage transitions

**From client folder:**
- Research dossier (company snapshot, stakeholder map, pain points, AI readiness)
- Lead qualification scorecard (if exists)
- Meeting notes from previous meetings (if any)
- Reverse brief (if exists — for walkthrough or later-stage meetings)
- SOW/MSA drafts (if exists — for contract walkthroughs)
- Any correspondence or transcripts

**Research freshness check:** If the research dossier is older than 2 weeks, flag it: "Research dossier is [X] days old — consider refreshing with Client Deep Research before this meeting."

### Step 2: Build the attendee profiles

For every person attending from the client/prospect side:

- **Name and role** — title, practice group/department, seniority
- **What they care about** — based on their role, what are their day-to-day priorities? What keeps them up at night?
- **Their likely attitude** — from research and prior interactions, are they a champion, cautious, sceptical, or unknown?
- **Buying role** — Decision Maker, Champion, Technical Contact, Gatekeeper, Influencer
- **Relationship history** — have they met the ELab team before? What was discussed? What did they respond well to?
- **Communication style notes** — anything from prior meetings (e.g., "prefers accessible language", "detail-oriented", "time-poor — get to the point")

### Step 3: Select relevant case studies

From the Case Study Index, select 1–3 case studies that are most relevant to this meeting:

**Selection criteria (in order of priority):**
1. Same industry as the prospect
2. Similar pain points to what's been identified in the research
3. Comparable company size or profile
4. Strong, specific metrics (not vague outcomes)

For each selected case study, prepare a **one-line reference** the attendee can drop into conversation naturally: "We recently helped a [similar firm] reduce [problem] by [metric] — happy to share the details."

Do not select case studies just to have them. If nothing is genuinely relevant, say so.

### Step 4: Generate meeting-type-specific content

See the Meeting Type Specifications section below.

### Step 5: Compile the briefing document

Produce one markdown document following the output format below. The document should be scannable in under 5 minutes — use headers, bullets, and tables. No prose blocks where a table or list would be clearer.

---

## Meeting Type Specifications

### `discovery`

The most important meeting type. The goal is to deeply understand the client's challenges and get verbal agreement to receive a Reverse Brief. The briefing prepares the attendee to run a diagnostic conversation, not a sales pitch.

**Additional content for discovery briefings:**

**Tailored discovery questions (5–8):**
Select from the Discovery & Qualification Questions template, tailored to this prospect's industry, size, and hypothesised pain points. For each question:
- The question itself
- Why you're asking it (what it reveals)
- A follow-up probe if the answer is surface-level
- What to listen for in the response (signals that map to qualification criteria or ELab services)

**Pain point hypotheses to validate:**
From the research dossier, list 3–5 specific hypotheses about what this company is struggling with. For each:
- The hypothesis
- Evidence from research
- The ELab service or case study that maps to it
- How to probe it without leading the witness

**Suggested conversation flow:**
A recommended sequence for the meeting — not a rigid script, but a guide:
1. Rapport and agenda framing (2 min)
2. ELab intro — keep it brief, use Discovery Deck if appropriate (5 min)
3. Open discovery — their situation, current state, pain points (25–30 min)
4. Tailored questions and deeper probes (10–15 min)
5. Summary and confirmation — verbally play back what you've heard (5 min)
6. Next step — propose the Reverse Brief, book the walkthrough meeting (3 min)

**Success criteria:**
- 70/30 talk ratio (client/ELab) — this is a diagnostic, not a pitch
- Verbal "yes, that makes sense" to your summary
- Agreement to receive the Reverse Brief
- Next meeting booked before hanging up

---

### `reverse_brief_walkthrough`

The meeting where you walk the client through the reverse brief. The goal is confirmation, feedback, or negotiation — not a re-pitch.

**Additional content:**
- Key sections of the brief to emphasise (what's most relevant to each attendee)
- Sections likely to get pushback (pricing, timeline, scope assumptions)
- Pre-prepared responses to likely objections
- What "success" looks like: written confirmation of the brief, or clear feedback to iterate on
- Any open questions from the brief that need resolving in the meeting

---

### `sow_walkthrough`

Walking through the contract documents. The goal is to get to signature or identify exactly what's needed to get there.

**Additional content:**
- Key commercial terms to highlight
- Sections that need client input (entity details, PO numbers, procurement requirements)
- Any non-standard terms or deviations from the template
- Procurement process status — PO required? Supplier registration? Legal review?
- Pre-prepared responses to commercial questions (from Pricing & Commercials Guide)

---

### `kickoff`

First meeting after signing. The goal is to set expectations, build confidence, and launch the engagement with momentum.

**Additional content:**
- Engagement scope summary (from SOW)
- Key milestones and timeline
- Team introductions (who's doing what on the ELab side)
- What the client needs to provide (access, data, points of contact)
- Onboarding survey status
- First deliverable and when to expect it

---

### `check_in`

Mid or post-engagement review. The goal is to maintain the relationship, surface expansion opportunities, and (if appropriate) set up a referral ask.

**Additional content:**
- Engagement progress summary
- Outcomes achieved so far (specific metrics if available)
- Open items or blockers
- Expansion opportunities to probe (adjacent departments, follow-on phases, managed services)
- Referral ask readiness — is the relationship warm enough?

---

### `partner`

Meeting with a referral partner, intermediary, or co-delivery partner. The goal depends on context — could be relationship maintenance, deal discussion, or co-selling.

**Additional content:**
- Partner relationship history (referrals given/received, joint engagements)
- Specific deals or prospects to discuss
- What you want from the meeting (intro to a specific prospect, co-selling alignment, feedback)
- What value you can offer the partner (reciprocal intros, co-branded content, their own AI needs)

---

## Output Format

```
# Meeting Briefing: [Client/Prospect Name]

> **Meeting type:** [type]
> **Date:** [date and time]
> **Location:** [in-person location or Zoom/Teams link]
> **ELab attendee(s):** [names]
> **Client attendee(s):** [names and roles]
> **Deal:** [deal name and Notion link if exists]

---

## Who You're Meeting

| Name | Role | Buying Role | Likely Priorities | Notes |
|---|---|---|---|---|
| [Name] | [Title] | [Decision Maker/Champion/etc.] | [What they care about] | [Style notes, prior interactions] |

---

## Context

[2-3 sentence summary of where this deal/relationship sits and what has happened so far]

**Research freshness:** [Date of dossier, flag if stale]

---

## Objectives

What success looks like for this meeting:

- [Objective 1]
- [Objective 2]
- [Objective 3]

---

## Agenda

| Time | Topic | Notes |
|---|---|---|
| [duration] | [topic] | [what to cover, how to approach] |

---

## [Meeting-type-specific sections]

(Discovery questions, pain point hypotheses, brief walkthrough notes, etc.)

---

## Case Studies to Reference

| Case Study | Relevance | One-liner |
|---|---|---|
| [Name] | [Why it's relevant to this prospect] | [Drop-in sentence for conversation] |

---

## Landmines and Sensitivities

- [Anything to avoid or be careful about — from research, prior interactions, or deal context]

(or "None identified" — but think hard before writing that)

---

## Documents in Client Folder

| Document | Date | Relevance |
|---|---|---|
| [filename] | [date] | [How it's relevant to this meeting] |
```

---

## Integration with Pipeline Manager

After the meeting:

1. **Save briefing** to client folder as `MEETING-BRIEF_[date]_[Client]_[meeting-type].md`
2. **Attach summary** to Notion deal via Pipeline Manager
3. **After the meeting** (separate action): meeting notes/transcript should be saved to the client folder and attached to the deal. The Precision Notes skill can help with this.

---

## Quality Checks

Before presenting the briefing:

- [ ] Every attendee has a profile with role, priorities, and buying role
- [ ] Research dossier freshness has been checked and flagged if stale
- [ ] Case studies are genuinely relevant (not filler)
- [ ] Discovery questions (if applicable) are tailored to this specific prospect, not generic
- [ ] Landmines section has been populated thoughtfully
- [ ] Agenda is realistic for the meeting duration
- [ ] All relevant documents from the client folder are listed
- [ ] The briefing is scannable in under 5 minutes
- [ ] NZ/UK English throughout

---

## Error Prevention

**Never:**
- Guess who is attending — always confirm from the calendar invite or deal record
- Include generic discovery questions that aren't tailored to this prospect
- Skip the landmines section — there is always something to be aware of
- Include background research trivia as a "landmine" — only flag things that could realistically come up in the meeting and affect how you handle the conversation
- Assume the research is current without checking the date
- Produce a briefing longer than 2 pages of scannable content (excluding appendices)
- Include case studies just to fill the section — if nothing is relevant, say so

**Always:**
- Check the research dossier date and flag if older than 2 weeks
- Include specific follow-up probes for every discovery question, not just the question itself
- Map pain point hypotheses to specific ELab services or case studies
- Note the communication style preferences of each attendee where known
- Include the "what success looks like" framing so the attendee knows their objective

---

## Notes for agents

- This skill requires file system access (to read the client folder and case study index) and optionally Notion MCP (to pull deal context via Pipeline Manager)
- The research dossier is the foundation. If it doesn't exist for a discovery meeting, stop and recommend running Client Deep Research first
- The Discovery & Qualification Questions template is a Google Doc — if it can't be accessed directly, the skill includes enough context about ELab's discovery approach to generate tailored questions without it
- The tailored discovery deck (HTML microsite) mentioned in the playbook is a separate deliverable — this skill produces the briefing document, not the deck. If a tailored deck is needed, note it in the briefing as an action item.
- For repeat meetings with the same client (e.g., check-ins), pull notes from previous meetings to show continuity and avoid re-asking questions that have been answered

---

## Handoff

**After this skill completes:**

1. Save briefing to client folder as `MEETING-BRIEF_[date]_[Client]_[type].md`
2. Attach summary to Notion deal via Pipeline Manager — update Next Action to "Run discovery meeting"
3. **After the meeting itself (separate session):**
   - Save meeting notes/transcript to client folder
   - Attach transcript summary to deal via Pipeline Manager
   - **Suggest next skill based on meeting type:**
     - After `discovery` meeting → **Reverse Brief Generator [5]** (input: transcript + research dossier)
     - After `reverse_brief_walkthrough` → client confirms or gives feedback → **Negotiation Advisor [6]** or **Contract Assembler [7]**
     - After `sow_walkthrough` → awaiting signature → Pipeline Manager (advance to Won when signed)

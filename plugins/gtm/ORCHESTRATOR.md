# ELab GTM Plugin — Orchestrator

Read this file first whenever the ELab GTM plugin is active. It defines the pipeline routing logic, skill firing order, input/output chain, and prerequisites. The Pipeline Manager skill is the hub — every workflow begins and ends there.

---

## The Golden Rule

**Never run a specialist skill before checking deal state in Notion.**

The first action in any GTM workflow is: does a deal exist? If not, create it via Pipeline Manager. If yes, determine its stage and what's already attached. Then route to the correct skill.

---

## Pipeline Stage → Skill Routing Table

| Deal State | Condition | Skill to Run | Notes |
|---|---|---|---|
| **No deal exists** | New lead mentioned | Pipeline Manager → Create Deal | Always the first step. No exceptions. |
| **Stage 1 — Lead** | Deal created, no qualification scorecard | Lead Qualifier | Quick qualify on available context — no dossier needed |
| **Stage 1 — Lead** | Qualification = GO, no research dossier | Client Deep Research | Only runs after GO decision — not before |
| **Stage 2 — Pre Pipeline Discovery** | Research dossier complete, no outreach sent | Communications Drafter (`outbound_cold`, `outbound_referral`, or `inbound_response`) | Route inbound vs outbound based on lead type |
| **Stage 3 — Qualified** | Outreach sent, meeting not yet booked | Communications Drafter (`followup_no_response`) if 3+ days no reply | Waiting stage — no proactive skill needed until meeting booked |
| **Stage 4 — Contacted** | Meeting booked | Meeting Prep (`discovery` type) | Run 24–48 hours before the meeting |
| **Stage 5 — Initial Meet** | Meeting held, transcript available | Reverse Brief Generator | Input: transcript/notes + research dossier |
| **Stage 6 — Reverse Brief Sent** | Brief sent, client pushes back | Negotiation Advisor | Input: client feedback + current brief |
| **Stage 6 — Reverse Brief Sent** | No response after 5+ days | Communications Drafter (`followup_no_response`) | |
| **Stage 7 — Feedback/Negotiating** | Client confirms brief | Contract Assembler | Input: confirmed Reverse Brief |
| **Stage 7 — Feedback/Negotiating** | Ongoing negotiation | Negotiation Advisor | May run multiple times |
| **Stage 8 — SOW/MSA** | Contracts sent, walkthrough needed | Meeting Prep (`sow_walkthrough` type) | |
| **Stage 9 — Won** | Contracts signed | Communications Drafter (`welcome_next_steps`) | Then Pipeline Manager to mark Won |

---

## Input/Output Chain

Each skill's output feeds directly into the next. Follow this chain — do not skip steps.

```
Pipeline Manager (deal created, Stage 1: Lead)
  └─► Lead Qualifier (quick qualify on available context)
        ├─► [GO] → Client Deep Research  →  dossier attached, advance to Stage 2
        │           └─► Communications Drafter (outreach)
        │                 └─► Pipeline Manager (advance to Stage 3: Qualified → Stage 4: Contacted)
        │                       └─► Meeting Prep (when meeting booked)
        │                             └─► [after meeting] Reverse Brief Generator
        │                                   ├─► [client confirms] → Contract Assembler
        │                                   │       └─► Pipeline Manager (advance to Stage 8/9: Won)
        │                                   └─► [client pushes back] → Negotiation Advisor
        │                                         ├─► Communications Drafter (response)
        │                                         └─► [resolved] → Contract Assembler
        └─► [NO-GO] → Pipeline Manager (mark lost/nurture)
        └─► [NEEDS MORE INFO] → stay at Stage 1, update Next Action, gather info, re-qualify

---

## Skill Prerequisites

| Skill | Must Have Before Running |
|---|---|
| **Lead Qualifier** | Deal created in Pipeline Manager (dossier helpful but not required) |
| **Client Deep Research** | Lead Qualifier returned GO |
| **Communications Drafter** | Deal exists + qualification = GO + research dossier |
| **Meeting Prep** | Meeting booked + deal exists + research dossier |
| **Reverse Brief Generator** | Discovery meeting completed + transcript/notes available |
| **Negotiation Advisor** | Reverse Brief sent + client feedback received |
| **Contract Assembler** | Client has confirmed the Reverse Brief (not just received it) |

---

## Cross-Pipeline Skills

Two skills fire at multiple stages — not just once:

**Communications Drafter** fires at:
- Stage 3 (Qualified) — outreach or inbound response
- Stage 4 (Contacted) — follow-up if no response
- Stage 6 (Reverse Brief Sent) — brief cover email
- Stage 7 (Feedback/Negotiating) — negotiation response
- Stage 8 (SOW/MSA) — SOW walkthrough cover
- Stage 9 (Won) — welcome email

**Meeting Prep** fires at:
- Stage 4/5 (discovery meeting)
- Stage 6 (reverse brief walkthrough)
- Stage 8 (SOW walkthrough)
- Any check-in or partner meeting

---

## How to Detect Deal State

1. Ask the human what deal or client this is about
2. Use Pipeline Manager to query Notion: `API-post-search` with the client name, filter for Opportunities database
3. Read the deal's Stage relation and page body to determine:
   - Current stage
   - What skill outputs are already attached (look for `---` section headers in page body)
   - What's missing

If no deal found → create it first.

---

## Skill Number Reference

| # | Skill | Pipeline Stage |
|---|---|---|
| 0 | Pipeline Manager | All stages (hub) |
| 1 | Lead Qualifier | Stage 1 (immediately after deal creation) |
| 2 | Client Deep Research | Stage 1→2 (only after GO qualification) |
| 3 | Communications Drafter | Stages 3, 4, 6, 7, 8, 9 |
| 4 | Meeting Prep | Stages 4/5, 6, 8+ |
| 5 | Reverse Brief Generator | Stage 5→6 |
| 6 | Negotiation Advisor | Stages 6, 7 |
| 7 | Contract Assembler | Stage 7→8 |

---

## 4-Hour Rule

New leads must be triaged within four business hours. When a lead comes in:
1. Create the deal (Pipeline Manager) — Stage 1: Lead
2. Quick qualify (Lead Qualifier) — go/no-go on available context
3. If GO: run Client Deep Research — advance to Stage 2
4. Draft outreach or response (Communications Drafter) — advance to Stage 3/4

All four steps can happen in a single session.

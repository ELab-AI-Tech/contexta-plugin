---
name: contract-assembler
description: Generate draft SOW and MSA documents from a confirmed Reverse Brief using ELab templates. Handles procurement pre-flight, scope extraction, template population, schedule formalisation, and human review flagging.
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Contract Assembler

Generates draft Statement of Work (SOW) and Master Services Agreement (MSA) documents from a confirmed Reverse Brief. Pre-fills scope, deliverables, timeline, pricing, and commercial terms from ELab templates. Critically, confirms procurement requirements before any drafting begins.

## When to Use

- Client has confirmed the Reverse Brief (Stage 7 → Stage 8 transition)
- Ready to formalise scope into contractual documents
- Need to check procurement requirements before investing time in drafting
- Need to generate SOW and/or MSA from confirmed engagement scope

## When NOT to Use

- Reverse Brief is still being negotiated (stay in Stage 7)
- Client has not confirmed scope and pricing direction
- Engagement is a Managed AI Services renewal (different contract structure — see Managed AI SOP)

---

## Pipeline Context

**Pipeline stage:** 8 (SOW / MSA / Final Contracting)
**Trigger:** Reverse Brief confirmed by client, ready to formalise
**Predecessor skill:** Reverse Brief Generator (Skill 6) — the confirmed brief is the primary input
**Successor:** Pipeline Manager (Skill 0) — attaches contracts to deal, advances to SOW/MSA stage
**Probability to close at this stage:** 90%

---

## Source Templates & References

| Document | Location | Purpose |
|---|---|---|
| SOW Template | [Google Doc](https://docs.google.com/document/d/1Wu7-ak-LDHezzn-ZzlKnh2ZeSHoIL1ZYWtiQkLEo80w/edit) | Standard ELab Advisory SOW |
| MSA Template | [Google Doc](https://docs.google.com/document/d/1uSH8MOwRA3ov1YS4XLESfcQM0C_MSkzqjUGM4xu3Drc/edit) | Master Services Agreement |
| LibreChat SOW Template | `00_Templates_and_SOPs/TEMPLATE - Elab LibreChat - Statement of Work.gdoc` | Product-specific SOW for LibreChat engagements |
| Pricing & Commercials Guide | [Google Doc](https://docs.google.com/document/d/1whWfBs0oPH5yqUP4cVHi9L2756J_h5OJ2S9zhrr2KoU/edit) | Rate card, payment terms, commercial arrangements |
| MSA & Onboarding SOP | [Google Doc](https://docs.google.com/document/d/1nqZWkVUYRoZ5kI-p_Tl4ro2DOJcywSOCdwf-sVGg3EA/edit) | Domestic vs. international MSA guidance, onboarding process |

> **Template-first rule:** Always read the current SOW and MSA template content before generating drafts. Templates may have been updated since the last run.

---

## Inputs

| Input | Required | Source | Notes |
|---|---|---|---|
| Confirmed Reverse Brief | Yes | Reverse Brief Generator / deal page body | Must be client-confirmed, not draft |
| Client entity details | Yes | Accounts database / deal page | Legal entity name, address, contact for contracts |
| Primary contact(s) | Yes | Contacts database / deal page | Name, title, email for signing authority |
| SOW Template content | Yes | Google Doc (see above) | Read at runtime |
| MSA Template content | Yes | Google Doc (see above) | Read at runtime |
| Pricing & Commercials Guide | Yes | Google Doc (see above) | Rate card and payment terms |
| Procurement requirements | Yes | Human input (pre-flight check) | PO, supplier agreement, legal review needs |
| Engagement type | No | Inferred from services | Advisory, LibreChat, Custom Dev — determines template variant |

---

## Process

### Step 1: Pre-Flight Procurement Check

**This step is mandatory before any drafting begins.** Ask the human to confirm or investigate the following with the client:

```
PROCUREMENT PRE-FLIGHT CHECKLIST
=================================

1. Purchase Order (PO):
   [ ] Is a PO required before work can commence?
   [ ] If yes, what is the PO process and typical turnaround?

2. Supplier Registration:
   [ ] Does the client require ELab to register as an approved supplier?
   [ ] Is there a supplier agreement or vendor onboarding form?
   [ ] If yes, how long does the registration process take?

3. Legal / Compliance Review:
   [ ] Will the client's legal team need to review the SOW/MSA?
   [ ] Are there specific legal or compliance requirements (data sovereignty, 
       insurance minimums, IP clauses)?
   [ ] Expected turnaround for legal review?

4. Standard Supplier Terms:
   [ ] Does the client have standard supplier terms that supersede or 
       constrain ELab's MSA?
   [ ] If yes, obtain a copy before drafting — the MSA may need to be 
       replaced by or reconciled with the client's terms.

5. Signing Authority:
   [ ] Who has authority to sign on the client side?
   [ ] Is this the same person as the primary contact, or someone else 
       (e.g. CFO, Procurement Manager)?
```

**Decision points after pre-flight:**
- If client has standard supplier terms → obtain and review before drafting MSA. May need to use their template instead or prepare a redline comparison.
- If PO or supplier registration required → factor the lead time into the project schedule.
- If legal review required → allow 1–3 weeks buffer in the timeline.
- If any item changes the document structure → flag to the human before proceeding.

> **Do not draft contracts until the human confirms procurement requirements are understood.** This avoids wasted effort if the client's process requires a different document structure.

### Step 2: Extract Scope from Confirmed Reverse Brief

Parse the confirmed Reverse Brief to extract:

| SOW Section | Extract From Reverse Brief |
|---|---|
| **Engagement title** | Engagement title from brief cover |
| **Background / Context** | Situation summary + challenges |
| **Objectives** | Proposed outcomes / success metrics |
| **Scope of Work** | Proposed approach, phases, deliverables |
| **Deliverables** | Explicit deliverable list |
| **Timeline & Milestones** | Indicative timeline from brief → formalise into confirmed dates |
| **Team / Resources** | ELab team members, client-side requirements |
| **Pricing** | Price range from brief → formalise into fixed quote or rate schedule |
| **Payment Terms** | From Pricing & Commercials Guide (standard: 50/50 or milestone-based) |
| **Assumptions & Dependencies** | Client responsibilities, access requirements, data availability |
| **Change Management** | Standard change request process (from template) |

**Formalisation rules:**
- **Indicative timeline → Confirmed schedule:** The Reverse Brief contains indicative dates. The SOW must contain confirmed start date, milestone dates, and delivery date. Confirm delivery team availability before committing.
- **Price range → Fixed quote:** The Reverse Brief may contain a range (e.g. "$25,000–$35,000"). The SOW must contain a single agreed price or a clearly defined rate schedule. Confirm with the human.
- **Assumptions → Explicit:** Any assumption from the brief that could affect delivery must be called out as a formal assumption or dependency in the SOW.

### Step 3: Determine Contract Structure

| Decision | Criteria | Action |
|---|---|---|
| **SOW variant** | Engagement type | Standard Advisory SOW for most engagements. Use LibreChat SOW template for LibreChat/product deployments. |
| **MSA required?** | New client vs. existing | New clients: always include MSA. Existing clients with current MSA: SOW only (reference existing MSA). |
| **Domestic vs. International** | Client jurisdiction | NZ clients: standard MSA. International: check MSA & Onboarding SOP for jurisdiction-specific clauses. |
| **Client terms override?** | Procurement pre-flight | If client has standard supplier terms, assess whether ELab MSA is replaced or supplemented. Flag to human. |

### Step 4: Generate Draft SOW

Populate the SOW template with extracted content. The draft must include:

**Required SOW Sections:**

1. **Cover Page**
   - ELab entity details
   - Client legal entity name and address
   - Engagement title
   - Document date
   - Version number (start at v1.0)

2. **Background & Objectives**
   - Client context (from brief)
   - Engagement objectives (from brief)
   - Success criteria / outcomes

3. **Scope of Work**
   - Phases and activities
   - What is in scope (explicit)
   - What is out of scope (explicit — prevents scope creep)

4. **Deliverables**
   - Numbered deliverable list
   - Format and delivery method for each
   - Acceptance criteria where applicable

5. **Timeline & Schedule**
   - Confirmed start date
   - Key milestone dates
   - Delivery/completion date
   - Any dependencies that could shift dates

6. **Team & Resources**
   - ELab team members and roles
   - Client-side requirements (people, access, data)
   - Availability assumptions

7. **Commercial Terms**
   - Total engagement fee (NZD)
   - Payment schedule (e.g. 50% on signing, 50% on delivery; or milestone-based)
   - Invoicing terms
   - Expenses (if applicable)
   - GST treatment

8. **Assumptions & Dependencies**
   - Client obligations
   - Data / system access
   - Availability requirements
   - Technology prerequisites

9. **Change Management**
   - Process for scope changes
   - How additional work is quoted
   - Sign-off requirements

10. **Governance**
    - Key contacts (both sides)
    - Communication cadence
    - Escalation path

**Flagging rules:** Mark any section with `[REVIEW: reason]` if:
- The information was not in the Reverse Brief and was inferred
- The pricing needs human confirmation
- Unusual scope or non-standard terms are involved
- Procurement pre-flight raised complications
- The section relies on delivery team availability not yet confirmed

### Step 5: Generate Draft MSA (if required)

Populate the MSA template. Key variable fields:

| MSA Field | Source |
|---|---|
| **Party details** | Client legal entity from Accounts database |
| **Effective date** | Date of signing (leave as placeholder) |
| **Jurisdiction** | Client location → determines governing law |
| **IP ownership** | Standard: client owns deliverables, ELab retains pre-existing IP and methodologies |
| **Confidentiality** | Standard mutual NDA terms from template |
| **Liability cap** | From Pricing & Commercials Guide (typically capped at engagement fee) |
| **Termination** | Standard termination for convenience with notice period |
| **Insurance** | Standard ELab coverage — check if client has minimum requirements from pre-flight |

> **International engagements:** Consult the MSA & Onboarding SOP for jurisdiction-specific considerations (currency, tax treatment, data sovereignty, governing law).

### Step 6: Compile Outputs & Flag for Review

Assemble the complete output package:

1. **Procurement Requirements Summary** — what was confirmed in pre-flight and any outstanding items
2. **Draft SOW** — fully populated, with `[REVIEW]` flags
3. **Draft MSA** — fully populated (or note if existing MSA applies)
4. **Review Checklist** — all flagged items requiring human attention
5. **Suggested Next Steps** — walkthrough meeting, signing process, timeline to execution

---

## Output Format

### Primary outputs — standalone documents

All contract outputs are saved as **standalone files** in the client folder on Google Drive (`ELab AI Advisory/Clients/<Client Name>/`). These are the documents that get reviewed, polished, and sent to the client.

**File naming convention:**
- SOW: `DRAFT_SOW_<Client>_<Engagement-Short-Name>.md`
- MSA: `DRAFT_MSA_<Client>.md`
- Procurement summary: included as an internal section at the end of the SOW (removed before sending)

The markdown file can be converted to Google Docs, PDF, or `.docx` for final delivery. The draft should be complete enough to send after human review — not a skeleton that requires rewriting.

### Draft SOW — required sections

The SOW document must include all of the following sections:

1. **Header** — ELab entity, client entity, engagement title, date, version, DRAFT status
2. **Background & Objectives** — client context and engagement goals
3. **Scope of Work** — phases/activities, explicitly including:
   - In-scope items (detailed)
   - Out-of-scope items (explicit — critical for preventing scope creep)
4. **Deliverables** — numbered table with format and target delivery date
5. **Timeline & Schedule** — milestones with confirmed or TBC dates
6. **Commercial Terms** — total fee, payment schedule, invoicing terms, expenses, GST
7. **ELab Team** — team members and roles
8. **Client Requirements** — what the client needs to provide (people, access, data)
9. **Assumptions & Dependencies** — anything that could affect delivery
10. **Change Management** — formal process for scope changes
11. **Governance & Communication** — key contacts, cadence, escalation
12. **Acceptance / Signature Block** — references MSA, signature table
13. **Review Checklist (internal)** — flagged items for human review, marked for removal before sending

Flag uncertain content with `[REVIEW: reason]` markers throughout. Collect all flags into the review checklist at the end.

### Review Checklist

Appended to the end of the SOW document, clearly marked as internal-only:

```
REVIEW CHECKLIST (Internal — remove before sending)

- [ ] Pricing confirmed at $[Amount] (was range in Reverse Brief)
- [ ] Timeline: delivery team availability confirmed
- [ ] Payment terms: standard / custom — if custom, leadership approval needed
- [ ] Signing authority confirmed
- [ ] Procurement: [any outstanding pre-flight items]
- [ ] MSA: new / existing / client terms
- [ ] Workshop/meeting format confirmed
- [ ] Remove this checklist before sending to client
```

### What goes in Notion (via Pipeline Manager)

The Notion deal page gets a **summary and link only** — not the full document. This keeps the deal page clean and avoids duplication.

```
--- Contract Assembler Output ([Date]) ---

SOW: DRAFT_SOW_<Client>_<Engagement>.md saved to client folder
     [Google Drive link or file path]
Fee: $[Amount] NZD + GST | Payment: [structure]
MSA: [New draft / Existing MSA applies / Client terms under review]

Procurement Notes:
- [Key items from pre-flight — PO, legal review, signing authority]

Review Checklist: [X] items pending human review (see SOW document)
Next Step: [Schedule walkthrough meeting / Confirm pricing / etc.]
```

---

## Integration with Pipeline Manager

After generating drafts, hand off to the Pipeline Manager (Skill 0):

1. **Save documents to client folder** — write the SOW (and MSA if applicable) as standalone `.md` files in `ELab AI Advisory/Clients/<Client Name>/`
2. **Attach summary to Notion** — append a short summary with file path/link to the deal page body (NOT the full document — see Output Format above)
3. **Advance stage** — move deal from Feedback/Negotiating to SOW/MSA
4. **Set dates** — update `Date SOW/MSA/Final Contracting` to today
5. **Update properties** — set `Project Start Date` if confirmed, update `Expected Close Date` based on procurement timeline
6. **Set Next Action** — "Schedule SOW walkthrough meeting" with target date

> **Document-first rule:** The SOW is a standalone file the human reviews and sends. Notion gets a summary and link. Never dump the full SOW into the deal page body.

---

## Commercial Guidance

Reference the [Pricing & Commercials Guide](https://docs.google.com/document/d/1whWfBs0oPH5yqUP4cVHi9L2756J_h5OJ2S9zhrr2KoU/edit) for:

- **Rate card:** Standard day rates by role and engagement type
- **Payment structures:** 50/50 (most common), milestone-based, monthly retainer
- **Discounting rules:** Trade, don't discount. If price reduction needed, tie to a "get" (faster payment, case study rights, longer commitment, reduced scope)
- **Cash flow caution:** Be careful with clients showing cash flow issues. Custom terms need leadership approval.
- **GST:** All NZ engagements are + GST. International engagements: check tax treatment.

### Standard Payment Structures

| Structure | When to Use | Format |
|---|---|---|
| **50/50** | Most advisory engagements < $50k | 50% on signing, 50% on delivery |
| **Milestone** | Multi-phase engagements > $50k | Payment tied to phase completion |
| **Monthly retainer** | Managed AI Services | Fixed monthly fee |
| **Progressive** | Long engagements (3+ months) | Monthly invoicing based on progress |

> **Scope is the pricing lever, not discount.** If the client needs a lower price, reduce scope collaboratively. Do not discount without getting something in return.

---

## Template Selection Logic

```
IF engagement_type == "LibreChat" OR engagement_type == "Product Deployment":
    USE LibreChat SOW Template
    
ELIF engagement_type == "Managed AI Services":
    USE Managed AI Services agreement structure (not standard SOW)
    FLAG: "Managed AI Services uses a different contract structure — 
           consult leadership"

ELSE:
    USE Standard Advisory SOW Template

IF new_client AND NOT client_terms_override:
    INCLUDE MSA (standard template)
    
ELIF new_client AND client_terms_override:
    REVIEW client terms
    FLAG: "Client has standard supplier terms — compare against ELab MSA. 
           May need legal review."

ELIF existing_client:
    CHECK for existing MSA
    IF existing_msa_current:
        SOW only — reference existing MSA
    ELSE:
        INCLUDE updated MSA
```

---

## Quality Checks

Before finalising any draft:

- ✅ Procurement pre-flight completed and confirmed by human
- ✅ All scope items traceable to the confirmed Reverse Brief
- ✅ No scope items inferred without `[REVIEW]` flag
- ✅ Pricing is a single figure (not a range) — confirmed with human
- ✅ Timeline has confirmed dates (not indicative) — delivery team availability checked
- ✅ Payment terms align with Pricing & Commercials Guide
- ✅ Out-of-scope section is explicit and reasonable
- ✅ Client legal entity name matches Accounts database
- ✅ Signing authority identified (from pre-flight)
- ✅ MSA decision is clear (new / existing / client terms)
- ✅ All `[REVIEW]` flags listed in the review checklist
- ✅ Engagement type → correct template variant selected

---

## Error Prevention

**Never:**
- Draft contracts before completing the procurement pre-flight
- Use indicative pricing from the Reverse Brief as the SOW price without confirmation
- Use indicative dates without confirming delivery team availability
- Assume client is NZ-based — check jurisdiction for MSA clauses
- Include scope not in the confirmed Reverse Brief without flagging
- Skip the out-of-scope section (critical for preventing scope creep)
- Offer discounts without a corresponding trade (faster payment, case study, longer term, reduced scope)
- Send contracts without a walkthrough meeting scheduled

**Always:**
- Complete procurement pre-flight first
- Read current template content before populating
- Confirm pricing and dates with human before finalising
- Flag anything inferred or uncertain with `[REVIEW]`
- Include explicit out-of-scope boundaries
- Reference the Pricing & Commercials Guide for all commercial terms
- Check if client has an existing MSA before generating a new one
- Present the review checklist to the human before the draft is considered complete

---

## Walkthrough Meeting Prep

After drafts are ready and human-reviewed, prepare for the SOW walkthrough:

**Meeting structure (from Playbook):**
1. Walk through the value and ROI story first (from Reverse Brief)
2. Walk through scope and deliverables
3. Present commercial terms last (value before price)
4. Ask directly: "Are you ready to move forward with this project?"
5. Map the signing process: "What does your typical process for signing a new partner look like, and who needs to be involved?"
6. Agree on a target signing date

**Post-meeting actions:**
- Send confirmation email summarising the positive decision
- Attach final SOW/MSA for signature
- Offer a one-page summary the champion can use for internal stakeholders
- Update Pipeline Manager: Next Action → "Awaiting signature" with target date

---

## Handoff

**After this skill completes:**

1. Save SOW (and MSA if applicable) to client folder as standalone `.md` files
2. Pipeline Manager: attach summary and file links to deal, advance stage Feedback/Negotiating → SOW/MSA, set Date SOW/MSA
3. **Suggest next skill: Communications Drafter [3]** — type `sow_walkthrough` — to send contracts to client with a walkthrough meeting invite
4. After SOW is sent, schedule walkthrough → **Meeting Prep [4]** type `sow_walkthrough`
5. On signature: Pipeline Manager → advance to Won, set Date Close Won, update Estimated Value to final agreed amount

---
name: communications-drafter
description: "Draft pipeline communications in the sender's personal voice, with deep recipient context and automatic document awareness. Use this skill when someone asks to draft an email, write outreach, respond to an inbound lead, send a reverse brief, send a SOW, write a follow-up, send a welcome email, or ask for referrals. Also trigger for 'write to [contact name]', 'draft an email for [deal]', 'follow up with [company]', or 'send the reverse brief'."
---

# Communications Drafter

Draft pipeline communications that sound like the actual sender wrote them — not a template, not a brand, not a robot. Every email demonstrates genuine understanding of the recipient's world, references the right documents, and is ready to review-and-send.

## When to use this skill

- A lead has been qualified (Go from Skill 3) and needs outreach
- An inbound enquiry needs a response
- A reverse brief is ready to send to the client
- A SOW/MSA is ready for the client to review
- A deal has been won and needs a welcome email
- A follow-up is needed after no response
- A referral ask is appropriate after a successful engagement
- Any pipeline stage where a communication to the prospect/client is the next step

## When NOT to use

- Internal communications (Slack messages, team updates)
- LinkedIn posts or social media content (use brand voice guidelines directly)
- Marketing emails or newsletters (different skill)
- The recipient is unknown — run Client Deep Research first
- No deal context exists — create a deal via Pipeline Manager first

---

## Pipeline Context

| Communication Type | Pipeline Stage | Typical Trigger |
|---|---|---|
| `outbound_cold` | 3 (Qualified) | Lead Qualifier returns Go, outbound lead |
| `outbound_referral` | 3 (Qualified) | Lead Qualifier returns Go, referral source identified |
| `inbound_response` | 3 (Qualified) | Inbound enquiry received, lead qualified |
| `event_followup` | 3–4 | Post-event or conference connection |
| `followup_no_response` | 4 (Contacted) | 3 business days with no response to any outreach |
| `reverse_brief_cover` | 6 (Reverse Brief Sent) | Reverse Brief completed and reviewed |
| `sow_walkthrough` | 8 (SOW/MSA) | Draft SOW/MSA ready for client review |
| `welcome_next_steps` | 9 (Won) | SOW/MSA signed |
| `check_in` | Post-engagement | Mid or post-engagement touchpoint |
| `referral_ask` | Post-engagement | Successful engagement, strong relationship |

---

## Inputs

| Input | Required | Source | Notes |
|---|---|---|---|
| `communication_type` | Yes | Human specifies or inferred from context | One of the types above |
| Deal record (Notion) | Yes | Pipeline Manager | Account, contacts, services, stage, lead source, relationship temperature |
| Research dossier | Yes (outbound types) | Client folder | Company snapshot, pain points, stakeholder map, industry context |
| Sender | Yes | Whoever creates the communication | The person invoking the skill IS the sender — their voice profile is loaded automatically |
| Recipient(s) | Yes | Deal contacts or specified | Name, email, role, seniority |
| Referral context | If referral type | Human provides | Who referred, relationship to recipient |
| Calendar link | If booking needed | Human provides | Gmail calendar booking link for discovery sessions |
| Qualification output | Helpful | Lead Qualifier (Skill 3) | Persona assignment, confidence, recommended approach |
| Client folder path | Auto-detected | Convention: `ELab AI Advisory/Clients/<Client Name>/` | Scanned for attachable documents |

---

## Process

### Step 1: Load sender voice profile

The sender is always the person creating the communication. Identify them and load their personal voice profile. Voice profiles are stored in `04_Brand_Assets/Brand Voice/`.

**Currently available profiles:**

**Antoni Tisot** — Use when Antoni is the sender.
- Warm, direct, grounded in specifics
- Collaborative "we" (speaks as part of team, not above it)
- Genuine enthusiasm, not corporate fakeness
- NZ pride, comfortable showing local roots
- Practical over inspirational
- Low-friction CTAs ("ping me for a coffee", "DM me")
- Uses contractions (we're, I'll, you're)
- Sign-off: Cheers

**ELab default** — Use when sender has no personal profile, or for corporate communications.
- Expert Guide archetype: confident, experienced partner leading clients through complexity
- Pragmatic, authoritative and humble, methodical, trustworthy and empathetic
- Brief by default, get to the point quickly
- Human, not corporate — write like talking to a colleague
- Sign-off: Cheers, Thanks, Much appreciated

When sender has no personal profile, use ELab default voice with their name, and adjust formality based on relationship stage (warmer for existing relationships, slightly more structured for cold outreach).

### Step 2: Pull deal context and understand the recipient

Pull from the Notion deal record:
- Account name, industry, headcount, location
- Contacts: names, emails, roles, seniority
- Services tagged, estimated value
- Lead source, lead type (inbound/outbound), relationship temperature
- Stage, any notes or context in the deal body
- Qualification output (persona, confidence, recommended approach)

Pull from the research dossier:
- Company snapshot (what they do, size, recent news)
- Industry context and vocabulary
- Pain points and challenges identified
- Stakeholder map (who reports to whom, decision makers, champions)
- AI readiness signals
- Competitive position and strategic moves

**Recipient modelling — this is critical:**

Before writing a single word, build a mental model of the recipient:
- What is their role? What do they care about day-to-day?
- What language does their industry use? (Legal: matters, practice groups, precedent, billable hours. Industrial: SOPs, maintenance cycles, HSE compliance. PE: AUM, deal flow, due diligence, EBITDA. Professional services: utilisation, client outcomes, workflow.)
- What specific challenge or opportunity did the research surface for them?
- What is their likely attitude towards AI? (Curious, cautious, sceptical, enthusiastic?)
- What is the relationship temperature? (Cold, warm referral, inbound enquiry, existing relationship?)
- Are they the decision maker, a champion, or a gatekeeper?

The email must demonstrate this understanding without being try-hard about it. Reference something specific — a recent company event, an industry challenge, their competitive position — that shows genuine homework. Do NOT open with "I noticed your company..." or any formulaic research-reveal. Weave the understanding into the substance naturally.

### Step 3: Scan client folder for documents

Before drafting, scan the client folder (`ELab AI Advisory/Clients/<Client Name>/`) for:

| Pattern | Document Type | Relevant For |
|---|---|---|
| `CLIENT-DEEP-RESEARCH_*.md` | Research dossier | All types (context) |
| `DRAFT_Reverse-Brief_*.md`, `REVERSE-BRIEF_*.md` | Reverse Brief | `reverse_brief_cover` |
| `LEAD-QUALIFICATION_*.md` | Lead qualification | All types (context) |
| `DRAFT_SOW_*.md` | Statement of Work | `sow_walkthrough` |
| `DRAFT_MSA_*.md` | Master Services Agreement | `sow_walkthrough` |
| `COMPRESSED-NOTES_*.md` | Meeting notes/transcripts | All types (context) |

Based on the communication type:
- **List documents to attach** — the specific files the recipient should receive
- **Reference documents naturally** in the email body (e.g., "I've put together a brief that captures..." not "Please find attached...")
- **Flag missing documents** — if a `reverse_brief_cover` is requested but no reverse brief exists in the folder, stop and flag: "No reverse brief found in client folder — run the Reverse Brief Generator first."

### Step 4: Match communication type and draft

Select the communication type and apply its specific structure, constraints, and attachment logic. See the Communication Type Specifications section below.

Generate **one draft** — the single best version for this specific recipient, context, and communication type. Do not produce multiple variants. Put your judgment into picking the right approach (direct, referral-led, pain-point-led, etc.) based on the context, and commit to it.

For types that include a follow-up (e.g., `outbound_cold`), also generate one follow-up draft.

### Step 5: Quality check

Every draft must pass ALL of these checks before presenting to the human:

**The person test:** Does this sound like [sender name] wrote it? Read it aloud. If it sounds like a template or a chatbot, rewrite it.

**The context test:** Does the email demonstrate genuine understanding of the recipient's situation? Could this email only have been written for this specific person at this specific company? If you could swap in another company name and it would still work, it fails.

**The jargon scan:** Search for every word and phrase in the banned lists below. If any appear, cut them.

**The word count check:** Is it within the maximum for its type? If over, cut. Shorter is almost always better.

**The attachment check:** Are all required documents listed? Are file paths correct? Is anything missing that should be flagged?

**The CTA check:** Is there exactly one clear ask? Is it low-friction? ("Open to a brief call next week?" not "When can we schedule a comprehensive discovery session?")

**The decisiveness check:** Is there one draft and one subject line? Do not hedge by producing multiple options. Pick the best approach and commit.

**The house style check:**
- NZ/UK English (analyse, colour, organise, programme)
- No Oxford comma ("people, process and technology")
- No em-dashes
- No emojis
- Sentence case for any headings

---

## Communication Type Specifications

### `outbound_cold`

**Stage:** 3 (Qualified) | **Max words:** 150

**Structure:**
1. **Opening** (1 sentence) — Show research. Reference something specific and recent about the recipient's company or industry. Not "I noticed your company..." — something that demonstrates genuine insight.
2. **Body** (2–3 sentences) — Connect the observation to a business problem ELab solves. Use a specific metric or outcome from a relevant engagement. Speak their industry language.
3. **CTA** (1 sentence) — Single, low-friction question. "Open to a brief call next week?" or "Worth a 20-minute conversation?"
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None (cold outreach should be lightweight).

**Required elements:**
- Research-backed opening (not generic)
- Specific metric or proof point from a relevant case study
- Persona-appropriate landing page link (if natural to include)
- Low-friction CTA

**Example (Antoni sending to industrial CEO):**

```
Subject: AI for maintenance operations

Hi John,

Saw the announcement on your Waikato expansion. Growth like that usually means more sites, more SOPs, and senior techs spending half their week on documentation instead of actual engineering.

We recently helped a major industrial operator deploy a secure AI tool that cut information retrieval time by 90% and freed up 2 hours a day for their maintenance coordinators. The pilot paid for itself in month two.

Open to a brief call next week to share the approach?

Cheers,
Antoni
```

---

### `outbound_referral`

**Stage:** 3 (Qualified) | **Max words:** 150

**Structure:**
1. **Opening** (1 sentence) — Lead with the mutual connection. "[Referrer name] suggested I reach out" or "[Referrer name] mentioned you might be dealing with..."
2. **Body** (2–3 sentences) — Brief context on why the referrer thought it was relevant. Connect to a specific challenge and ELab proof point.
3. **CTA** (1 sentence) — Low-friction. Referral warmth means you can be slightly more direct.
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None.

**Required elements:**
- Referrer name in opening line
- Specific reason the referrer connected you (not just "thought you should meet")
- One proof point or relevant outcome

**Example (Antoni, referred by Julian at Potentia):**

```
Subject: Julian suggested we connect — AI for legal operations

Hi James,

Julian from Potentia mentioned you've been thinking about how AI could help with some of the operational heavy lifting at CLM. He thought there might be a good fit with the work we've been doing.

We've been helping mid-sized professional services firms deploy practical AI tools — things like automating document review, structuring knowledge bases, and cutting admin time for senior practitioners. One firm reduced their report turnaround from 90 minutes to 15 per matter.

Happy to have a quick chat about what might make sense for your team?

Cheers,
Antoni
```

---

### `inbound_response`

**Stage:** 3 (Qualified) | **Max words:** 120

**Structure:**
1. **Opening** (1 sentence) — Acknowledge the enquiry. Warm, not effusive. "Thanks for reaching out" or "Good to hear from you."
2. **Body** (2–3 sentences) — Briefly position ELab's relevance to their stated need. Reference a relevant case study or proof point if natural. Show you've looked at their company.
3. **CTA** (1–2 sentences) — Calendar booking link. "I've dropped a few times below — grab whichever works" or "Here's a link to book a time that suits."
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None (keep it light, save detail for the meeting).

**Required elements:**
- Acknowledgement of their specific enquiry (not generic)
- Brief ELab positioning relevant to their need
- Calendar booking link
- Persona-appropriate landing page link (optional, for background reading)

---

### `event_followup`

**Stage:** 3–4 | **Max words:** 120

**Structure:**
1. **Opening** (1 sentence) — Reference the event and the specific conversation. "Good to meet you at [event]" not "It was great connecting."
2. **Body** (2–3 sentences) — Pick up from where the conversation left off. Reference the specific topic discussed.
3. **CTA** (1 sentence) — Low-friction next step.
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None.

**Required elements:**
- Specific event name
- Specific conversation reference (not "our chat")
- Natural follow-on from the in-person conversation

---

### `followup_no_response`

**Stage:** 4 (Contacted) | **Max words:** 80

Sent 3 business days after the original email with no response.

**Structure:**
1. **Bump** (1–2 sentences) — Brief, casual. Add one new piece of value (a relevant article, case study, or observation). Do NOT guilt-trip or re-pitch.
2. **CTA** (1 sentence) — Same ask, rephrased. Even lower friction.
3. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** Optional — attach a relevant case study PDF if one exists.

**Required elements:**
- New value-add (not just "following up on my email")
- No desperate tone
- Under 80 words

**Example:**

```
Subject: Re: [original subject]

Hi James,

Just bumping this up. Separately, we published a case study last week on AI in professional services that might be relevant to what you're working on — [link].

Worth a quick call?

Cheers,
Antoni
```

---

### `reverse_brief_cover`

**Stage:** 6 (Reverse Brief Sent) | **Max words:** 200

This is the email that accompanies the reverse brief — the most important document in the pipeline. The tone should be confident, warm, and collaborative. The brief is doing the heavy lifting; this email frames it.

**Structure:**
1. **Opening** (1–2 sentences) — Thank them for the discovery session. Reference something specific from the conversation that shows you listened.
2. **Framing** (2–3 sentences) — Explain what the attached brief is and what it captures. Frame it as "our understanding of your situation and how we can help" not "our proposal." Mention that it is meant to be a starting point for discussion, not a final document.
3. **Next step** (1–2 sentences) — Suggest a walkthrough meeting. "Happy to jump on a call to walk through it and make sure we've captured everything correctly."
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:**
- **Required:** Reverse Brief (`.md` or PDF from client folder)
- **Optional:** Reverse Brief deck (if generated)
- Flag if reverse brief is missing from client folder

**Required elements:**
- Specific reference to the discovery conversation (not generic)
- Clear framing of what the brief is (not "proposal" — "brief", "our understanding", "a starting point")
- Invitation to discuss/adjust
- All recipients from the discovery session included

**Example (Antoni to James Curtis and Cam Russell after CLM discovery):**

```
Subject: Following up from our conversation — ELab brief for CLM

Hi James, Cam,

Thanks for the conversation last week. The challenges you described around knowledge management and the operational load on your senior practitioners really resonated — we see similar patterns across professional services firms, and it's a space where practical AI can make a real difference.

I've put together a brief that captures our understanding of CLM's situation and where we think there's an opportunity. It covers the key challenges we discussed, a proposed approach, and indicative investment. It's meant as a starting point — not a finished document — so please mark it up, push back, or add anything we've missed.

Happy to jump on a call to walk through it together. Let me know what works for your calendars.

Cheers,
Antoni
```

---

### `sow_walkthrough`

**Stage:** 8 (SOW/MSA) | **Max words:** 150

**Structure:**
1. **Opening** (1 sentence) — Reference the agreed scope from the reverse brief.
2. **Body** (2–3 sentences) — Explain what is attached (SOW, MSA if applicable) and what it formalises. Note any sections that need their input or review.
3. **CTA** (1–2 sentences) — Suggest a walkthrough meeting to go through it together.
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:**
- **Required:** Draft SOW
- **Required (if applicable):** Draft MSA
- Flag if SOW is missing from client folder

**Required elements:**
- Reference to agreed scope
- Clear description of attached documents
- Walkthrough meeting suggestion
- Note about sections requiring their input

---

### `welcome_next_steps`

**Stage:** 9 (Won) | **Max words:** 200

**Structure:**
1. **Opening** (1–2 sentences) — Genuine but understated. "Looking forward to getting started" not "thrilled to welcome you as a client."
2. **Logistics** (3–5 sentences) — Concrete next steps: onboarding survey, kickoff meeting timing, who their primary contact will be, what to expect in the first week.
3. **Close** (1 sentence) — Open door. "Any questions in the meantime, just shout."
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None (onboarding survey link goes in body).

**Required elements:**
- Specific next steps with timing
- Primary contact introduction
- Onboarding survey link (if available)
- Kickoff meeting scheduling

---

### `check_in`

**Stage:** Post-engagement | **Max words:** 100

**Structure:**
1. **Context** (1 sentence) — Reference the engagement and how long it's been.
2. **Value** (1–2 sentences) — Share an observation, a relevant development, or ask about outcomes from the work.
3. **Open door** (1 sentence) — "If there's anything else we can help with, let me know."
4. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** Optional — attach a relevant case study or article.

---

### `referral_ask`

**Stage:** Post-engagement | **Max words:** 120

Only use after a successful engagement where the client has expressed satisfaction.

**Structure:**
1. **Opening** (1 sentence) — Reference the engagement outcomes specifically.
2. **Ask** (2–3 sentences) — Direct but not pushy. "If you know anyone in your network dealing with similar challenges, I'd appreciate an intro." Not "Can you refer three people?"
3. **Sign-off** — Cheers, [Sender first name]

**Attachment logic:** None.

**Required elements:**
- Specific reference to the engagement outcome (not generic "our work together")
- Low-pressure referral ask
- No incentive language (this is relationship-based, not transactional)

---

## Voice Rules (Embedded)

These rules apply to ALL communication types. They are embedded here so the skill works standalone.

### Always do

- Brief by default. Get to the point. No preamble unless context genuinely helps.
- Human, not corporate. Write like talking to a colleague.
- Use contractions (we're, I'll, you're, that's)
- Use direct requests ("Could you..." / "Are you able to...")
- Use casual sign-offs: Cheers, Thanks, Much appreciated
- Active voice throughout
- Acknowledge constraints honestly ("fully booked", "things are hectic")
- Start with the core message, add context if needed
- One clear action per message
- Use bullets where they make the email easier to scan — especially when listing what a document covers or what next steps look like. Don't force everything into paragraphs.
- Be confident, not apologetic. You're sending your best thinking, not a rough draft you're nervous about. Collaborative framing is good; hedging and over-qualifying is weak.

### Never do

- Em-dashes (—)
- AI filler phrases ("I'd be happy to...", "I hope this finds you well", "I hope this email finds you well")
- Excessive politeness ("I was wondering if perhaps...", "Would it be possible to maybe...")
- Corporate jargon ("circle back", "touch base", "synergise", "loop in")
- Fake enthusiasm ("thrilled", "delighted", "excited to connect", "excited to announce")
- Rhetorical questions ("What if I told you...?")
- Formulaic research-reveal callbacks ("The point you raised about...", "You mentioned that...", "As you noted in our conversation...")

### Banned words and phrases — NEVER use

- Thrilled, excited, humbled, grateful, privilege, incredible, amazing, fantastic, delighted
- Revolutionary, game-changing, cutting-edge, state-of-the-art
- Transform/transformation (when used generically without specifics)
- AI journey
- Thought leadership
- Disruption/disrupt
- Unlock potential
- Synergise, leverage, utilise, operationalise, optimise (use: use, apply, improve, speed up)
- Here's the thing / Let me explain / The reality is
- The key isn't X, it's Y / Not because X, but because Y / It's not about X, but about Y
- I've been thinking about... / Furthermore / Moreover / In conclusion / Therefore
- Most X fail. Not because Y, but because Z.
- Solutions provider / secret sauce / world-class / unparalleled
- The point you raised about... / You mentioned that... / As you noted... / As we discussed... (formulaic callbacks that scream AI)

### House style

- **Language:** NZ/UK English — analyse, colour, organise, prioritise, programme (not -ize)
- **Punctuation:** No Oxford comma — "people, process and technology" (not "people, process, and technology")
- **Capitalisation:** Sentence case for any headings
- **No em-dashes** — use commas, full stops, or restructure the sentence

---

## Persona Tuning

Adjust vocabulary and emphasis based on the recipient's industry. This goes beyond word choice — it shapes which pain points you lead with and which proof points you cite.

### PE / Financial Services / Investment

- **Vocabulary:** AUM, deal flow, due diligence, investor confidence, EBITDA impact, portfolio companies, fund operations
- **Lead with:** Risk mitigation, governance, scalable ROI, competitive intelligence
- **Proof points:** Investment management case studies, portfolio-wide AI enablement
- **Landing page:** elab.co.nz/landing/family-offices

### Industrial / Operations / Construction / Field Services

- **Vocabulary:** SOPs, maintenance cycles, HSE compliance, workflow automation, key-person dependency, site operations
- **Lead with:** Operational efficiency, safety, compliance, reducing reliance on key personnel
- **Proof points:** Industrial case studies, voice-to-report tools, field service automation
- **Landing page:** elab.co.nz/landing/industrial-ops

### Professional Services / Legal

- **Vocabulary:** Matters, practice groups, billable hours, utilisation, client outcomes, document review, precedent research
- **Lead with:** Practitioner productivity, knowledge management, client service quality, admin burden reduction
- **Proof points:** Professional services case studies, document automation, knowledge base deployment
- **Landing page:** elab.co.nz/landing/general-business

### General Business

- **Vocabulary:** General operational language, keep it accessible
- **Lead with:** Practical AI applications, measurable outcomes, starting small
- **Proof points:** Cross-industry case studies, broad AI enablement outcomes
- **Landing page:** elab.co.nz/landing/general-business

---

## Output Format

Present each draft as a Gmail-ready structured block:

```
**From:** [Sender full name] <[sender email]>
**To:** [Recipient name] <[email]>; [additional recipients]
**CC:** [if applicable]
**Subject:** [subject line]

---

[Email body — plain text, no formatting beyond line breaks]

---

**Attachments:**
- [filename] — [file path in client folder]

(or "None" if no attachments for this type)

**Notes:** [any context the sender should be aware of before sending, or "None"]
```

---

## Integration with Pipeline Manager

After the human reviews, edits, and sends the communication:

1. **Log to Notion deal** — Append a summary block:
```
--- Communication Sent ([Date]) ---
Type: [communication_type]
Recipient(s): [names]
Sender: [name]
Subject: [subject used]
Status: Sent
```

2. **Advance stage if appropriate:**
   - After `outbound_cold`, `outbound_referral`, `inbound_response`: Advance to Contacted (Stage 4)
   - After `reverse_brief_cover`: Advance to Reverse Brief Sent (Stage 6)
   - After `sow_walkthrough`: Remain at SOW/MSA (Stage 8) — advance happens on signature
   - After `welcome_next_steps`: Remain at Won (Stage 9)

3. **Update Next Action** field with the expected response or follow-up timing.

---

## Quality Checks (Summary)

Before presenting ANY draft to the human:

- [ ] Sounds like the sender, not a template — passes the "read it aloud" test
- [ ] Demonstrates specific understanding of the recipient's company and situation
- [ ] Could NOT be sent to a different company without changes (context test)
- [ ] No banned words or phrases from the voice rules
- [ ] Within word count limit for the communication type
- [ ] Exactly one clear, low-friction CTA
- [ ] All required attachments identified and file paths confirmed
- [ ] Missing documents flagged if applicable
- [ ] NZ/UK English throughout
- [ ] No em-dashes, no emojis
- [ ] No Oxford comma
- [ ] Sign-off matches sender voice (Cheers for Antoni, Cheers/Thanks for others)

---

## Error Prevention

**Never:**
- Guess dates or days of the week — always pull the actual meeting date from the discovery notes or deal record. If unsure, leave as [date] for the human to fill in.
- Send any communication without human review and approval
- Use a research-reveal opening ("I noticed your company..." / "I've been following your...")
- Include more than one CTA per email
- Exceed the word count for the communication type
- Attach documents that haven't been confirmed to exist in the client folder
- Use bullet points in email body text (flowing prose only)
- Default to brand voice when a personal voice profile is available
- Write a follow-up that just says "following up on my previous email" without adding value

**Always:**
- Load the sender's voice profile before writing anything
- Read the research dossier thoroughly before outbound communications
- Scan the client folder for documents before drafting
- Produce one draft — the best one. Do not generate variants.
- Flag missing documents rather than sending without them
- Match vocabulary to the recipient's industry
- Keep it short — if in doubt, cut

---

## Notes for agents

- This skill requires file system access (to scan the client folder for documents) and optionally Notion MCP (to pull deal context and log communications via Pipeline Manager)
- The research dossier is the primary source of recipient intelligence. If it's missing or thin for an outbound communication, flag it and suggest running Client Deep Research first
- Voice profiles are loaded from `04_Brand_Assets/Brand Voice/`. If a sender's profile doesn't exist, use ELab default with their name
- Gmail MCP integration is planned but not yet implemented. For now, present output as structured markdown for the human to copy into Gmail
- One draft, one subject line. The skill makes the judgment call on the best approach — the human reviews and edits, not chooses between options
- Attachment file paths should be absolute paths within the Google Drive structure so the human can find them immediately

---

## Handoff

**After this skill completes (and human sends the communication):**

1. Log communication to Notion deal via Pipeline Manager (type, recipient, subject, date)
2. Advance stage if applicable:
   - After outbound/inbound outreach → Pipeline Manager: advance to Contacted (Stage 4), set Date Contacted
   - After reverse brief cover → Pipeline Manager: advance to Reverse Brief Sent (Stage 6), set Date Reverse Brief Sent
   - After SOW email → remain at SOW/MSA (Stage 8)
   - After welcome email → remain at Won (Stage 9)
3. **Suggest next skill based on type:**
   - After outreach (Stage 3→4): no immediate skill — **wait for meeting to be booked, then Meeting Prep [4]**
   - After follow-up (Stage 4): monitor for response; if meeting booked → Meeting Prep [4]
   - After reverse brief cover (Stage 6): monitor for client response; if pushback → Negotiation Advisor [6]
   - After SOW email (Stage 8): schedule walkthrough → Meeting Prep [4]

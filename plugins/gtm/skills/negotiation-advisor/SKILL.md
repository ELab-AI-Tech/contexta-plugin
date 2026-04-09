---
name: negotiation-advisor
description: "Analyse client feedback on a reverse brief, SOW, or commercial proposal and produce a recommended response strategy. Use this skill when a client pushes back on price, scope, timeline, or terms, when someone asks how to handle an objection, when a deal is stuck at Stage 7, or when commercial feedback needs a structured response. Also trigger for 'they came back with feedback', 'how do we handle this objection', 'they want a discount', 'they want to change scope', or 'deal is stuck'."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Negotiation Advisor

Analyse client feedback and produce a clear recommendation: what they're really saying, what to do about it, and what to say back. One recommendation, not a menu of options. The human decides whether to follow it.

## When to use this skill

- A client responds to the Reverse Brief with feedback, concerns, or pushback
- A client questions pricing, scope, timeline, or commercial terms in the SOW
- A deal is stuck at Stage 7 (Feedback/Negotiating) and needs to move
- A stakeholder blocker has surfaced (someone new needs convincing)
- A client goes quiet after receiving the brief or SOW
- Commercial feedback arrives at any pipeline stage that needs a structured response

## When NOT to use

- The client has confirmed the brief without changes (move to Contract Assembler)
- The feedback is purely administrative (e.g., correcting a company name, updating a contact)
- The client has explicitly said no and the deal is dead (update Pipeline Manager, move on)
- You need to draft the actual response email (use Communications Drafter after this skill produces the strategy)

---

## Pipeline Context

**Primary stage:** 7 (Feedback / Negotiating)
**Also relevant at:** 6 (after Reverse Brief sent), 8 (during SOW/MSA review)
**Predecessor skill:** Reverse Brief Generator (Skill 6) or Contract Assembler (Skill 8)
**Successor skill:** Communications Drafter (Skill 4) for the response, or Contract Assembler (Skill 8) for an updated SOW
**Probability to close at Stage 7:** 75%

---

## Inputs

| Input | Required | Source | Notes |
|---|---|---|---|
| Client feedback | Yes | Email, meeting notes, or verbal summary | The actual feedback — what did they say? |
| Current Reverse Brief | Yes | Client folder | The document they're responding to |
| Deal record (Notion) | Yes | Pipeline Manager | Account, contacts, services, estimated value, stage, history |
| Research dossier | Helpful | Client folder | Company context, stakeholder map, buying dynamics |
| Lead qualification | Helpful | Client folder | Budget signals, red flags, confidence level |
| SOW/MSA draft | If SOW stage | Client folder | If the feedback is on contracts rather than the brief |
| Prior correspondence | Helpful | Email thread, deal notes | Relationship temperature, what's been said before |

---

## Process

### Step 1: Classify the feedback

Read the client's feedback carefully and classify it. Most feedback falls into one of these categories — sometimes more than one:

| Category | What it sounds like | Urgency |
|---|---|---|
| **Minor edit** | "Can you update the timeline?" / "We'd like to add X to scope" | Low — update and resend |
| **Scope question** | "We're not sure we need Phase 2" / "Can we start smaller?" | Medium — needs discussion |
| **Price objection** | "This is more than we expected" / "Can you sharpen the price?" | Medium — apply negotiation framework |
| **Timeline concern** | "We can't start until Q3" / "This needs to happen faster" | Medium — adjust plan |
| **Stakeholder blocker** | "I need to get buy-in from [person]" / "The board needs to approve" | High — new decision-maker in play |
| **Cold feet** | "We need more time to think" / "Not sure we're ready" | High — deal at risk |
| **Silence** | No response after 5+ business days | High — deal at risk |
| **Competitor comparison** | "We're also talking to [firm]" / "Someone else quoted less" | High — need to differentiate |

If the feedback spans multiple categories, classify the primary issue and note the secondary ones.

### Step 2: Understand what they're really saying

The stated objection is rarely the real one. Before recommending a response, think through:

- **What did they actually say?** (Quote it exactly)
- **What might they really mean?** (The subtext)
- **What's driving this?** (Budget constraint, internal politics, risk aversion, genuine concern about value, comparison shopping)
- **Who is this coming from?** (The champion, the decision-maker, a gatekeeper, or someone new?)
- **What has changed since the last interaction?** (New stakeholder, budget cycle shift, competitive pressure, internal priority change)

### Step 3: Apply the negotiation framework

ELab's negotiation framework from the playbook, in order of preference:

**1. Isolate the objection**
Confirm this is the only issue. "If we address the pricing, are you comfortable with everything else?" This prevents scope creep in the negotiation — solve one thing at a time.

**2. Reframe around value**
Before adjusting anything, ensure the value case is clear. If the client sees the engagement as a cost rather than an investment, no amount of discounting helps. Go back to the business impact and ROI framing from the Reverse Brief.

**3. Trade, don't discount**
Never give a discount for nothing. Every price reduction should be tied to a get:
- Faster payment terms (payment on signing, net 14 instead of net 30)
- Case study rights (named case study for ELab's portfolio)
- Longer-term commitment (managed services contract alongside the engagement)
- Referral commitment (formal intro to 2-3 contacts in their network)
- Reduced scope (see below)

**4. Adjust scope to adjust price**
The primary lever. Collaboratively add or remove scope to hit a price point. Key considerations:
- Can the engagement be phased? (Start with Foundations, pilot is a separate decision)
- Can a module be deferred rather than removed?
- Does the adjusted scope still deliver standalone value? (Never strip an engagement to the point where it can't succeed)
- Can the scope be adjusted to fly under procurement thresholds? (e.g., under $20k to avoid PO requirements)

**5. Flexible payment terms (with caution)**
If cash flow is the issue, suggest alternative payment structures:
- 50/30/20 split across milestones
- Monthly instalments across the engagement period
- Payment on completion of phases

**Cash flow red flag:** Requests for payment flexibility can indicate the organisation isn't large enough or the engagement isn't justified. Unless it's a genuinely strategic client, don't extend custom terms. For large strategic clients, bespoke terms need leadership approval.

### Step 4: Produce the recommendation

One clear recommendation with reasoning. Not a menu of options — the human decides whether to follow it or not.

---

## Feedback-Specific Playbooks

### Minor edit

**Approach:** Just do it. Update the brief or SOW, send v2 with a brief note highlighting the changes. No strategy needed — speed and responsiveness matter more than deliberation.

**Output:** Updated brief/SOW section + cover note for Communications Drafter.

---

### Scope question

**Approach:** Understand whether they want less scope (budget constraint), different scope (misalignment on priorities), or phased scope (risk management). Each has a different response.

**If they want less scope (budget):**
- Identify what can be phased or deferred
- Propose a reduced engagement that still delivers standalone value
- Show the price reduction and what they lose
- Frame the deferred items as "Phase 2 when you're ready"

**If they want different scope (misalignment):**
- Go back to the discovery conversation — what did they say their priorities were?
- If the brief missed the mark, own it: "Good catch — let us adjust"
- If the brief is right but they've changed their mind, probe what shifted

**If they want phased scope (risk management):**
- This is actually a good sign — they want to proceed but want to manage risk
- Propose a clear phase gate: "Let's do Foundations first. You see the output, decide if you want to continue."
- ELab's AI Foundations engagement is designed as exactly this kind of strategic wedge

---

### Price objection

**Approach:** Apply the full negotiation framework (Step 3). Never lead with a discount.

**Response structure:**
1. Acknowledge the concern without apologising for the price
2. Reframe around value: what does the engagement deliver? What's the cost of not doing it?
3. If value reframe doesn't land, propose a trade (case study, faster payment, commitment)
4. If trade doesn't land, adjust scope — show what a reduced engagement looks like and what they give up
5. Only adjust payment terms as a last resort and only for strategic accounts

**Key pricing context to reference:**
- AI Foundations: $15,000+ NZD ($10,000 minimum for smaller strategic engagements)
- Pilot/implementation: $20,000–$40,000
- Managed AI services: $2,000+/month ($1,000/month minimum for key strategic clients)
- AI Foundations is designed as a low-risk entry point — if $15k is too much, the engagement may not be right for them

---

### Timeline concern

**If they want to delay:**
- Understand why (budget cycle, internal readiness, competing priorities, decision-maker availability)
- If it's a legitimate scheduling issue, accommodate and keep the deal warm
- If it's a stalling tactic, probe: "What would need to change for the timing to work?"
- Offer to hold a specific date range to create gentle urgency

**If they want to accelerate:**
- Check ELab's delivery capacity before committing
- Identify what can be parallelised vs. what has dependencies
- Be honest about realistic timelines — don't overpromise to win the deal

---

### Stakeholder blocker

**Approach:** This is the most common reason deals stall. A new decision-maker or approver has entered the picture.

**Response structure:**
1. Identify who the new stakeholder is and what they care about
2. Prepare a champion enablement pack — materials the champion can use to sell internally
3. Offer to present directly to the new stakeholder: "Happy to jump on a quick call with [name] to walk them through it"
4. If the stakeholder is a CFO or finance approver, prepare an ROI-focused one-pager
5. If the stakeholder is a board or committee, prepare a summary deck or executive brief

**Champion enablement pack:**
- One-page summary of the engagement (problem, approach, outcomes, investment)
- ROI framing specific to what the new stakeholder cares about
- Relevant case study with metrics
- FAQ for common internal questions ("Why do we need external help?", "Can't we do this ourselves?", "What if it doesn't work?")

---

### Cold feet

**Approach:** The deal is at risk. The client is backing away from a commitment, not raising a specific objection. This requires a different response than negotiation.

**Response structure:**
1. Don't chase or pressure — acknowledge that it's a significant decision
2. Identify the real concern: is it budget, internal politics, risk aversion, or a change in priorities?
3. Reduce perceived risk: highlight the Foundations engagement as a low-commitment starting point
4. Social proof: share a relevant case study where a similar client had the same hesitation
5. Open door: "No pressure — when the timing is right, we're here"
6. Set a concrete follow-up date so it doesn't drift: "Shall I check in after [event/quarter]?"

---

### Silence

**Approach:** No response after 5+ business days. Could mean many things — don't assume the worst.

**Response structure:**
1. Wait 5 business days after the brief/SOW was sent before escalating
2. First follow-up: brief, adds value (use Communications Drafter, `followup_no_response` type)
3. If no response after the follow-up, try a different channel (call the champion directly)
4. If still nothing after 10 business days: send a "closing the loop" message that gives them an easy out — "If now isn't the right time, completely understand. Happy to revisit when it makes sense."
5. Move to nurture in the pipeline if no response after 15 business days

---

### Competitor comparison

**Approach:** They're comparing ELab to another provider. This is healthy and normal — don't panic.

**Response structure:**
1. Don't badmouth the competitor
2. Differentiate on methodology, not price: ELab's people-process-data-technology sequence, Lean Six Sigma foundations, "we eat our own dog food"
3. Highlight what ELab delivers that a pure tech vendor doesn't: strategic alignment, governance, change management, ongoing advisory relationship
4. If they're comparing to a large consultancy (Accenture, PwC, Deloitte): ELab offers senior talent at every touchpoint, not a partner for the pitch and juniors for the delivery
5. If they're comparing to a cheaper provider: "You'll get what you pay for — happy to walk through the differences in approach"
6. Share a relevant case study where ELab's methodology delivered results the alternative approach wouldn't have

---

## Output Format

```
# Negotiation Advisor: [Client Name]

> **Date:** [date]
> **Deal:** [deal name]
> **Feedback source:** [email / call / meeting — who said it and when]
> **Classification:** [primary category] (secondary: [if applicable])

---

## What They Said

[Exact quote or close paraphrase of the feedback]

## What They Probably Mean

[Your read of the subtext — what's really driving this]

## What's Changed

[Any shift in dynamics since the last interaction — new stakeholder, budget cycle, competitive pressure]

---

## Recommendation

[Clear, direct recommendation — one approach, not a menu]

### Reasoning

[Why this approach, not another. Reference the negotiation framework.]

### Specifically

- [Concrete action 1]
- [Concrete action 2]
- [Concrete action 3]

### What to Say

[Key talking points or framing for the response — not the full email, just the substance. Use Communications Drafter to write the actual response.]

### If This Doesn't Work

[Fallback position — what's the next move if the recommendation doesn't land]

---

## Updated Documents

[If scope or pricing changes are recommended, specify exactly what changes in the Reverse Brief or SOW]

- [Section X: change from Y to Z]
- [Section X: remove / defer to Phase 2]

(or "No document changes recommended")

---

## Pipeline Impact

- **Stage change:** [Stay at Stage 7 / Advance to Stage 8 / Move to Nurture]
- **Estimated value change:** [If scope adjustment changes the deal value]
- **Next action:** [What happens next and by when]
- **Risk level:** [Low / Medium / High — with one-line reason]
```

---

## Integration with Pipeline Manager

After the human reviews and acts on the recommendation:

1. **Attach summary** to Notion deal via Pipeline Manager
2. **Update deal properties** if value or scope has changed
3. **Advance stage** if feedback is resolved and the deal moves forward
4. **Update Next Action** with the agreed next step and date
5. **If nurture/lost:** Update deal status and add the reason

---

## Quality Checks

Before presenting the recommendation:

- [ ] The feedback has been quoted accurately, not paraphrased loosely
- [ ] The classification matches the actual feedback, not just the surface-level ask
- [ ] The "what they probably mean" section adds insight, not just restates the obvious
- [ ] The recommendation is one clear approach, not a list of options
- [ ] Any proposed scope or price changes still result in a viable engagement
- [ ] Trade proposals are specific (case study rights, faster payment) not vague ("find a trade")
- [ ] The fallback position is genuinely different from the primary recommendation
- [ ] Document changes are specific enough to action immediately
- [ ] NZ/UK English throughout

---

## Error Prevention

**Never:**
- Recommend a discount without a corresponding trade or scope reduction
- Propose payment flexibility for clients where the qualification flagged budget red flags
- Assume silence means rejection — it usually means the champion is selling internally
- Recommend aggressive follow-up when the client has asked for time
- Propose scope reductions that leave the engagement unable to deliver value
- Badmouth a competitor in the response strategy
- Override the human's commercial judgment — this skill recommends, the human decides

**Always:**
- Start by isolating the objection before proposing solutions
- Check the qualification scorecard for budget and governance signals before recommending a pricing response
- Consider whether the feedback is coming from the champion, the decision-maker, or someone new
- Frame scope reductions as phasing ("Phase 2 when you're ready") not as cuts
- Include a fallback position so the human has a plan B ready
- Flag if the deal should be moved to nurture rather than continuing to push

---

## Notes for agents

- This skill requires no tools — it is pure reasoning over the feedback, deal context, and commercial framework
- The Pricing & Commercials Guide is a Google Doc (`SOP - Pricing & Commercials - Rate Card - ELab Advisory.gdoc` in `00_Templates_and_SOPs/`). Key pricing bands are embedded in this skill file so it works standalone.
- The output of this skill feeds into Communications Drafter (for the response email) and potentially Contract Assembler (if scope changes require a new SOW)
- Do not write the response email — produce the strategy and talking points, then hand off to Communications Drafter for the actual draft
- Commercial judgment is the hardest part of this skill. When in doubt, recommend the more conservative approach (hold price, adjust scope) rather than the aggressive one (discount to close)

---

## Handoff

**After this skill completes:**

1. Attach strategy summary to Notion deal via Pipeline Manager — update Next Action and risk level
2. **Suggest next skill based on outcome:**
   - Recommendation requires a response email → **Communications Drafter [3]** — pass the "What to Say" talking points as input
   - Recommendation requires scope/price changes → update Reverse Brief first, then Communications Drafter
   - Client confirms brief after negotiation → **Contract Assembler [7]**
   - Deal moving to nurture → Pipeline Manager: update stage to On Hold or Nurture
3. If deal value or scope has changed, update deal properties via Pipeline Manager before moving forward

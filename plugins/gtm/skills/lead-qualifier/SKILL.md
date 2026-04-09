---
name: lead-qualifier
description: "Score a prospect against the ELab Lead Qualification Checklist and produce a Go / No-Go / Needs More Info recommendation. Use this skill immediately after a deal is created (Stage 1: Lead) — before running deep research — using whatever context is available (intro email, referral notes, initial conversation). Also trigger when someone says 'should we pursue this?', 'is this a good fit?', 'qualify this lead', 'Go/No-Go on this one', or 'is CLM worth pursuing?'. A research dossier is helpful but not required — this skill can qualify on available context alone and will flag what's unknown."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Lead Qualifier

Score a prospect against ELab's Lead Qualification Checklist and produce a structured Go / No-Go / Needs More Info recommendation with reasoning. This skill enforces discipline on which leads the team invests time in.

## When to use this skill

- A deal has just been created in Pipeline Manager (Stage 1: Lead) — this is the default next step
- A new lead needs qualifying before investing time in deep research
- Someone asks whether a prospect is a good fit, "should we pursue this?", or "is this worth it?"
- Re-qualifying a stalled deal after new information emerges
- **A research dossier is NOT required** — this skill qualifies on available context and clearly flags what's unknown

## When NOT to use

- The prospect has already been qualified and is in Stage 3+ (unless re-qualifying)
- The lead is an existing client (use Account Expansion Planner instead)

---

## Pipeline Context

**Pipeline stage:** 1 (Lead) — fires immediately after deal creation
**Trigger:** Deal created in Pipeline Manager
**Predecessor skill:** Pipeline Manager (deal creation)
**Successor skill (if GO):** Client Deep Research [2] — then Communications Drafter [3]
**Successor skill (if NO-GO):** Pipeline Manager (mark lost/nurture)
**Probability to close at this stage:** 10%

---

## Inputs

| Input | Required | Source | Notes |
|---|---|---|---|
| Deal record (Notion) | Yes | Pipeline Manager | Account, contacts, services, lead source, lead type, relationship temperature |
| Initial context | Yes | Email thread, intro message, referral notes, human's knowledge | What you know about the lead from the initial contact |
| Research dossier | Optional | Client Deep Research (if already run) | Improves scoring confidence but not required. If unavailable, score criteria as Unknown and flag. |

> **Pre-research mode:** When no dossier exists, score criteria as **Met / Likely / Unknown / Not Met** based on available signals. 3+ Unknowns on must-have criteria = Needs More Info (not automatic No-Go). A low-confidence GO is still a GO — it means "proceed to research to confirm."

> **Warm referral note:** For warm intros (referral from a trusted source, personal meeting), weight the relationship signal positively — unknown criteria are more likely "Likely" than "Unknown" in this context.

---

## Process

### Step 1: Pull context

If a Notion deal exists, pull:
- Account name, industry, headcount, location
- Contacts and their roles
- Services tagged, estimated value
- Lead source and lead type (inbound/outbound)
- Any notes or context already in the deal body

Combine with the research dossier to form a complete picture.

### Step 2: Score must-have criteria

Evaluate each must-have criterion as **Met / Likely / Unknown / Not Met**. Every score must include a one-line evidence citation from the research dossier or deal context.

**Budget alignment:**

| Criterion | Score | Evidence |
|---|---|---|
| Has budget for AI Foundations engagement ($15,000+ NZD) | | |
| Has budget for $20,000-$40,000 pilot/implementation | | |
| Can support ongoing AI costs ($2,000+/month) | | |
| Has decision-making authority over the budget | | |

**Business readiness:**

| Criterion | Score | Evidence |
|---|---|---|
| Lower-middle-market business | | |
| Clear operational pain points that AI can address | | |
| ROI opportunity through cost out, scale, or revenue | | |
| Basic technical infrastructure and medium-to-high tech literacy | | |
| Has team members who can champion AI implementation | | |

**Organisational culture and tech literacy:**

| Criterion | Score | Evidence |
|---|---|---|
| Leadership willing to invest and experiment | | |
| Organisation not too large/bureaucratic for ELab's delivery model | | |
| IT team or exec/ops actively engaged and empowered | | |

Assessment scale for this section:
- **Ideal:** Progressive, tech-savvy leadership willing to invest and experiment
- **Sweet spot:** Large enough that AI benefits scale, not so large that bureaucracy kills delivery
- **Caution:** Low tech literacy across leadership and operations with no internal champion

**Strategic fit:**

| Criterion | Score | Evidence |
|---|---|---|
| Within or adjacent to target industries (Financial Services, PE/Investment/Family Offices, Industrials, Field Services, Construction, Professional Services, Legal, Healthcare) | | |
| Potential for long-term AI enablement journey | | |
| Not just looking for a one-off solution | | |

### Step 3: Score positive indicators

Rate each category as **Strong / Present / Weak / Not Observed**. Include evidence.

**Growth potential:**
- Potential for multiple AI implementations
- Multiple departments/functions that could benefit
- Clear path to expand services over time
- Opportunity for reference/case study in their industry

**Organisational readiness:**
- Leadership actively supports and champions AI adoption
- Has an internal champion who is empowered to act
- Team open to new technologies and willing to change workflows
- Has data and processes that can be enhanced with AI
- IT team is engaged and collaborative (not a blocker)
- Executive team demonstrates tech curiosity

**Business impact:**
- Clear ROI potential from AI implementation
- Size of business means AI benefits scale
- Significant efficiency gains possible
- High-frequency, repeatable tasks present
- Potential for measurable cost savings

### Step 4: Check for red flags

Flag any of the following that are present. Each flag must include evidence.

**Budget red flags:**
- Unwilling to commit to paid exploration phase
- Expects free proof of concept
- Unrealistic budget expectations
- Unclear funding source
- Cash flow concerns that suggest the organisation may not sustain the engagement

**Implementation red flags:**
- No clear decision-maker
- Significant resistance to change at leadership or team level
- Lack of basic technical infrastructure
- No internal resources to support implementation
- IT team actively hostile to external advisory or AI initiatives
- Low tech literacy across leadership and operations with no internal champion

**Strategic red flags:**
- Looking for quick fix without commitment
- Unrealistic timeline expectations
- No clear business problem to solve
- Just "exploring AI" without serious intent
- Organisation too large/bureaucratic for ELab's nimble delivery model

### Step 5: Calculate overall score and recommendation

**Scoring logic:**

1. Count must-have criteria scored as **Not Met**:
   - 0 Not Met → eligible for Go
   - 1 Not Met → eligible for Go with caveat (flag the gap)
   - 2+ Not Met → likely No-Go unless strong mitigating factors

2. Count must-have criteria scored as **Unknown**:
   - 3+ Unknown → Needs More Info (cannot qualify without more data)

3. Count red flags:
   - 0 red flags → no penalty
   - 1-2 red flags → Go with caution (flag in recommendation)
   - 3+ red flags → likely No-Go unless outweighed by exceptional positives

4. Assess positive indicators:
   - Strong across all three categories → strong Go signal
   - Weak or Not Observed across multiple categories → tempers the Go recommendation

**Produce one of three recommendations:**

**Go** — Proceed to Stage 3 (Qualified). Include:
- Confidence level (High / Medium / Low)
- Key strengths driving the recommendation
- Any caveats or areas to probe during discovery
- Recommended persona assignment (Industrial, Financial Services, Professional Services, or General Business)
- Recommended next action (outreach type: referral intro, direct outreach, inbound response)
- Estimated engagement pathway (which ELab services are most likely relevant)

**No-Go** — Disqualify. Include:
- Primary reason(s) for disqualification
- Whether to keep in nurture (revisit in 6-12 months) or close permanently
- If nurture: what would need to change for re-qualification

**Needs More Info** — Cannot qualify yet. Include:
- Specific questions that must be answered before a decision can be made
- Suggested source for each answer (further research, direct outreach, referral partner, etc.)
- Interim recommendation (lean Go or lean No-Go based on what is known)

---

## Output Format

```
# Lead Qualification: [Company Name]

> **Date:** [Date]
> **Deal:** [Deal name from Notion, if exists]
> **Research dossier:** [Filename/path]
> **Recommendation:** [GO / NO-GO / NEEDS MORE INFO]
> **Confidence:** [High / Medium / Low]

---

## Must-Have Criteria

### Budget Alignment

| Criterion | Score | Evidence |
|---|---|---|
| Budget for AI Foundations ($15k+) | [Met/Likely/Unknown/Not Met] | [one-line citation] |
| Budget for pilot ($20-40k) | [score] | [citation] |
| Ongoing AI support ($2k+/month) | [score] | [citation] |
| Decision-making authority | [score] | [citation] |

### Business Readiness

| Criterion | Score | Evidence |
|---|---|---|
| Lower-middle-market business | [score] | [citation] |
| Clear operational pain points | [score] | [citation] |
| ROI opportunity | [score] | [citation] |
| Technical infrastructure | [score] | [citation] |
| Internal champion potential | [score] | [citation] |

### Organisational Culture

| Criterion | Score | Evidence |
|---|---|---|
| Leadership investment appetite | [score] | [citation] |
| Not too large/bureaucratic | [score] | [citation] |
| IT/exec engaged and empowered | [score] | [citation] |

### Strategic Fit

| Criterion | Score | Evidence |
|---|---|---|
| Target industry alignment | [score] | [citation] |
| Long-term journey potential | [score] | [citation] |
| Beyond one-off solution | [score] | [citation] |

**Summary:** [X] Met | [X] Likely | [X] Unknown | [X] Not Met

---

## Positive Indicators

| Category | Rating | Key Evidence |
|---|---|---|
| Growth potential | [Strong/Present/Weak/Not Observed] | [summary] |
| Organisational readiness | [rating] | [summary] |
| Business impact | [rating] | [summary] |

---

## Red Flags

[List any flagged items with evidence, or "No red flags identified"]

---

## Recommendation

### [GO / NO-GO / NEEDS MORE INFO]

**Confidence:** [High / Medium / Low]

[2-3 sentence summary of the recommendation and primary reasoning]

**If GO:**
- Persona: [Industrial / Financial Services / Professional Services / General Business]
- Recommended next action: [outreach type and approach]
- Likely engagement pathway: [services]
- Caveats: [any areas to probe during discovery]

**If NO-GO:**
- Primary reason: [reason]
- Disposition: [Nurture / Close]
- Re-qualification trigger: [what would need to change]

**If NEEDS MORE INFO:**
- Questions to resolve:
  1. [Question] — source: [where to find the answer]
  2. [Question] — source: [source]
- Interim lean: [lean Go / lean No-Go]
```

---

## Integration with Pipeline Manager

After producing the qualification:

1. **Attach scorecard** to Notion deal page (summary, not full scorecard - see output format above)
2. **If Go:** Advance deal from Pre-Pipeline Discovery to Qualified. Set persona assignment. Trigger Communications Drafter (Skill 4) for outreach/response.
3. **If No-Go:** Move deal to Disqualified (or Lost if applicable). Add disqualification reason.
4. **If Needs More Info:** Keep at Pre-Pipeline Discovery. Add the specific questions to the deal's Next Action field.

### What goes in Notion (via Pipeline Manager)

```
--- Lead Qualifier Output ([Date]) ---

Recommendation: [GO / NO-GO / NEEDS MORE INFO] (Confidence: [level])
Must-haves: [X] Met | [X] Likely | [X] Unknown | [X] Not Met
Red flags: [count and summary, or "None"]
Persona: [assignment]

Key strengths: [1-2 bullet points]
Key risks: [1-2 bullet points, or "None identified"]
Next action: [recommended next step]
```

---

## Quality Checks

Before finalising:

- Every score has a one-line evidence citation (no unsupported judgments)
- All evidence traces to the research dossier, deal record, or correspondence (nothing assumed)
- Must-have scores are conservative (if evidence is ambiguous, score as Unknown rather than Likely)
- Red flags are not ignored or downplayed - if present, they are flagged regardless of overall strength
- The recommendation is consistent with the scores (do not recommend Go if 2+ must-haves are Not Met without explicit justification)
- Persona assignment is based on industry and case study relevance, not guessed
- UK/NZ English spelling throughout

---

## Error Prevention

**Never:**
- Score Unknown criteria as Likely or Met to push a deal towards Go
- Ignore red flags because the positive indicators are strong
- Recommend Go without at least one clear pain point that ELab can address
- Assign a persona without checking the persona-specific assets in the playbook
- Qualify a lead without a research dossier (run Client Deep Research first)

**Always:**
- Be conservative on budget scores unless budget was explicitly discussed
- Flag governance/decision-maker gaps prominently (this is ELab's most common deal-killer)
- Note if the research dossier is thin and more data would improve confidence
- Include the "what would need to change" clause for No-Go and Needs More Info recommendations

---

## Notes for agents

- This skill requires no tools - it is pure reasoning over structured input
- The research dossier is the primary input. If it is missing or thin, say so and recommend running Client Deep Research before qualifying
- Budget is almost never explicitly known at this stage. Score as Unknown unless the research or correspondence gives clear signals. Do not penalise Unknown budget scores on their own
- The qualification is an internal assessment, not a client-facing document. Be direct about strengths and weaknesses
- When in doubt between Go and Needs More Info, choose Needs More Info. It is cheaper to ask one more question than to invest hours pursuing a poor-fit lead

---

## Handoff

**After this skill completes:**

1. Attach scorecard summary to the Notion deal via Pipeline Manager
2. **If GO:**
   - Pipeline Manager: keep at Stage 1 (Lead) — stage advances to Pre Pipeline Discovery after research
   - **Suggest next skill: Client Deep Research [2]** — pass the GO confidence level and key unknowns as context so the research targets the right gaps
3. **If NO-GO:**
   - Pipeline Manager: move deal to Disqualified / Lost, add closed lost reason
   - No further skills needed — investment saved
4. **If NEEDS MORE INFO:**
   - Pipeline Manager: keep at Stage 1, update Next Action with specific questions to resolve
   - Revisit after answers are gathered — re-run Lead Qualifier with updated context
   - Do NOT run Client Deep Research until a GO or Likely GO is reached

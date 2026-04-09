# Reverse Brief Content Extraction Guide

This guide defines exactly how to extract content from a Reverse Brief prose document into the JSON format required by the deck generator.

---

## General Principles

1. **Compress, don't summarise** - Keep the meaning, cut the filler
2. **Complete sentences** - Every description should read as a standalone statement
3. **Specific over generic** - Keep client-specific details, cut generic consulting language
4. **Consistent tone** - Professional, direct, no hype words
5. **Do not infer or fabricate data** - Every field value must be traceable to the source document. If the source says "approximately 200 staff", extract "approximately 200" - do not change to "200+" or "~200"
6. **Case studies must be sourced from the case study folder** - For `case_studies` fields, consult `ELab Sales and Marketing/01_Sales_Enablement/Case Studies/_Case_Study_Index.md` to find relevant studies, then pull details directly from the individual case study files. Titles, locations, challenges, solutions, and impact metrics must match verbatim - do not paraphrase or round figures
7. **Flag missing fields** - If a required JSON field cannot be populated from the source material, insert `"[CONFIRM: description of what's needed]"` as the value rather than guessing. Ask the user to supply the missing information before generation
8. **No suitable case study?** - If no case study in the folder is a good match for the prospect, tell the user and ask which to use rather than selecting a poor fit or inventing one

---

## Field-by-Field Extraction Rules

### Cover Fields

| Field | Length | Format | Example |
|-------|--------|--------|---------|
| `client_name` | As written | Company name only | "Hargreaves Power Services" |
| `engagement_title_1` | 3-4 words | First line of title, ends with "&" or similar | "AI Foundations &" |
| `engagement_title_2` | 2-3 words | Second line, the "hero" phrase | "Strategic Roadmap" |
| `date` | Month Year | No day | "January 2026" |

---

### Slide 2: Our Understanding

#### `situation_summary`
- **Length:** 30-50 words (1-2 sentences)
- **Content:** Who they are, what they do, scale of operations
- **Include:** Company name, location, headcount/scale, key clients or services
- **Exclude:** Challenges (those go in cards)

```
❌ Too short (15 words):
"Hargreaves operates industrial maintenance services in Hong Kong."

❌ Too long (80 words):
"Hargreaves Power Services (HK) operates a significant industrial maintenance and engineering business across Hong Kong, with 200-300 personnel delivering mechanical/electrical maintenance, scaffolding, and overhead line distribution services to major clients including CLP, Hong Kong Electric, MTR, and Hong Kong Airport. Your business combines routine scheduled maintenance with sophisticated precision engineering work."

✅ Just right (40 words):
"Hargreaves Power Services (HK) operates a significant industrial maintenance and engineering business across Hong Kong, with 200-300 personnel delivering services to major clients including CLP, Hong Kong Electric, MTR, and Hong Kong Airport."
```

#### `challenges` (array)
- **Count:** 4-6 items (5 is ideal for 3+2 grid layout)
- **Icon:** Select from icon library based on theme (see mapping below)

| Field | Length | Format |
|-------|--------|--------|
| `title` | 3-5 words | Noun phrase, Title Case |
| `description` | 15-25 words | 1-2 complete sentences |

**Icon Mapping:**
- IT/Systems/Constraints → `Settings`
- Documents/Reports/Paperwork → `FileText`
- People/Workforce/Adoption → `Users`
- Time/Aging/Knowledge Loss → `Clock`
- Risk/Warning/Barriers → `AlertTriangle`
- Language/Communication → `AlertTriangle` or `Users`

```
❌ Title too long:
"Corporate IT Infrastructure Constraints and Limitations"

✅ Title right:
"Corporate IT Constraints"

❌ Description too short:
"IT is limited to Copilot."

❌ Description too long:
"Your group AI strategy is currently limited to Microsoft Copilot's basic chat function, which creates a significant roadblock for implementing custom AI solutions that could address your specific operational needs, requiring you to build a compelling business case."

✅ Description right:
"Group AI strategy limited to Microsoft Copilot. Custom solutions require business case for corporate approval."
```

---

### Slide 3: Business Impact

#### `impact_paragraph_1`
- **Length:** 40-60 words
- **Content:** How challenges compound/connect operationally
- **Tone:** Empathetic, shows understanding

#### `impact_paragraph_2`
- **Length:** 40-60 words
- **Content:** The opportunity within the constraint, transition to solution
- **Tone:** Forward-looking, sets up engagement

```
✅ Example paragraph 1:
"These challenges create a compounding operational burden: complex work requires manual documentation, which ties up experienced personnel who hold critical tribal knowledge that isn't being captured. Meanwhile, tech adoption barriers mean efficiency improvements must be designed around voice and phone-based interaction rather than apps or forms."
```

---

### Slide 4: Proposed Engagement

#### `engagement_name`
- **Length:** 4-7 words
- **Format:** The formal name of the engagement
- **Example:** "AI Foundations & Strategic Roadmap"

#### `objectives` (array)
- **Count:** Exactly 4 (fits 4-column grid)

| Field | Length | Format |
|-------|--------|--------|
| `title` | 2-3 words | Verb + Noun, Title Case |
| `description` | 8-12 words | Single phrase |

**Standard objectives (adapt as needed):**
1. Build Capability → Training/education
2. Identify Use Cases → Discovery/prioritisation  
3. Assess Readiness → Infrastructure/maturity
4. Create Strategy → Roadmap/business case

```
✅ Example:
{
  "icon": "Lightbulb",
  "title": "Build Capability",
  "description": "AI fundamentals training for leadership team"
}
```

#### `engagement_callout`
- **Length:** 20-35 words
- **Content:** The key value proposition of this engagement
- **Format:** Single sentence

---

### Slide 5: Standalone Value

#### `value_items` (array)
- **Count:** Exactly 6 (fits 3+3 grid)

| Field | Length | Format |
|-------|--------|--------|
| `title` | 2-4 words | Noun phrase, Title Case |
| `description` | 10-15 words | What they get, stated as outcome |

**Standard value items (adapt as needed):**
1. AI-Literate Leadership
2. Shadow AI Mitigation
3. Workflow Documentation
4. Quantified Business Case
5. IT-Ready Architecture
6. Strategic Clarity

---

### Slides 6-7: Phase Details

#### `phase_1` and `phase_2`

| Field | Length | Content |
|-------|--------|---------|
| `title` | 3-6 words | Phase name |
| `description` | 8-15 words | Duration and format |
| `topics` / `activities` | Array of 6-8 | What's covered |
| `note` / `outcome` | 15-25 words | Key callout |

**For `topics` and `activities`:**
- Each item: 8-15 words
- Start with verb or noun
- Specific to client context where possible

```
✅ Good topic:
"Current AI capabilities, limitations, and realistic expectations"

❌ Too vague:
"AI overview"

❌ Too long:
"A comprehensive overview of current AI capabilities including large language models, their limitations, and how to set realistic expectations for what AI can and cannot do"
```

---

### Slide 8: Phase 3 Deliverables

#### `phase_3_docs` (array)
- **Count:** Exactly 2

| Field | Length | Content |
|-------|--------|---------|
| `title` | 3-5 words | Document name |
| `subtitle` | 3-5 words | Who it's for |
| `items` | Array of 4-5 | What's included |

**Each item:** 6-12 words, noun phrase describing a section/component

---

### Slide 9: AI Opportunities

#### `opportunities` (array)
- **Count:** Exactly 6 (fits 3+3 grid)

| Field | Length | Format |
|-------|--------|--------|
| `title` | 3-5 words | Use case name, Title Case |
| `description` | 15-25 words | What it does, how it works |
| `impact` | 2-4 words | Metric or benefit |

**Impact examples:**
- "50-70% less doc time"
- "Knowledge retention"
- "IP preservation"
- "Improved compliance"
- "Reduced admin time"
- "Inventory accuracy"

```
✅ Good opportunity:
{
  "icon": "Mic",
  "title": "AI-Assisted Completion Reports",
  "description": "Voice input with AI structuring. Supervisors speak; AI creates compliant documentation.",
  "impact": "50-70% less doc time"
}
```

---

### Slide 10: Technical Considerations

#### `tech_section_title`
- **Length:** 3-5 words
- **Format:** Regional or context-specific heading
- **Example:** "Hong Kong Regional Considerations"

#### `tech_considerations` (array)
- **Count:** 4 items
- **Each:** Icon + 8-12 word description

#### `tech_card`
- **Single card** addressing platform positioning (e.g., Copilot relationship)
- Title: 5-8 words
- Description: 25-40 words

---

### Slide 11: Corporate IT

#### `it_context`
- **Length:** 25-40 words
- **Content:** The IT constraint and what this engagement provides

#### `it_document_items` (array)
- **Count:** 6 items
- **Each:** 5-10 words, what's in the technical document

#### `it_callout`
- **Length:** 20-30 words
- **Content:** Key message for IT stakeholders

---

### Slide 12: Investment & Timeline

| Field | Format | Example |
|-------|--------|---------|
| `investment.amount` | Currency + number | "$15,750" |
| `investment.currency` | 3-letter code | "USD" |
| `investment.tax_label` | Currency + tax string | "NZD + GST" |
| `investment.includes` | Array of 4-6 | What's included |
| `duration` | X weeks/months | "4 weeks" |
| `delivery_model` | How delivered | "Remote delivery via video conference" |
| `proposed_start` | When available | "Mid-March 2026" |

If `tax_label` is not provided, the generator defaults to `currency + ' + GST'`. Use this field for non-NZD currencies or different tax formats (e.g. 'AUD + GST', 'excl. VAT', 'USD').

---

### Slide 13: Tangible Deliverables

#### `deliverables_table` (array)
- **Count:** 6-8 items

| Field | Length |
|-------|--------|
| `name` | 2-5 words |
| `description` | 8-15 words |

---

### Slide 14: Future Phases

#### `future_phases` (array)
- **Count:** Exactly 3

| Field | Format |
|-------|--------|
| `number` | "1", "2", "3" |
| `title` | 2-3 words |
| `description` | Price range + brief scope (10-15 words) |

```
✅ Example:
{
  "number": "1",
  "title": "Pilot Sprint",
  "description": "$15k - $25k · Initial pilot with small user group"
}
```

---

### Slide 15: Success Criteria

#### `success_criteria` (array)
- **Count:** 8 items (fits 2-column layout)
- **Each:** 8-15 words, outcome-focused statement

---

### Slide 16: Why ELab

#### `why_elab` (array)
- **Count:** Exactly 4 (fits 2x2 grid)

| Field | Length |
|-------|--------|
| `title` | 3-5 words |
| `description` | 20-30 words |

**Standard differentiators (adapt as needed):**
1. Deep Industrial Experience
2. Regional Expertise
3. Practical, Not Theoretical
4. Technology Agnostic

---

### Slide 17: Relevant Experience

#### `case_studies` (array)
- **Count:** Exactly 2

| Field | Length |
|-------|--------|
| `title` | 3-5 words (company type, not name) |
| `location` | Country/region |
| `challenge` | 10-20 words |
| `solution` | 10-20 words |
| `impacts` | Array of 2 metric/outcome phrases |

#### `experience_insight`
- **Length:** 25-40 words
- **Content:** Pattern or lesson from these engagements

---

### Slide 18: Next Steps

#### `next_steps` (array)
- **Count:** Exactly 4

| Field | Length |
|-------|--------|
| `number` | "1", "2", "3", "4" |
| `title` | 1-2 words (verb) |
| `description` | 8-12 words |

**Standard steps:**
1. Review - Confirm brief captures situation
2. Schedule - Follow-up call
3. Confirm - Issue SOW
4. Align - Involve stakeholders

#### `closing_text`
- **Length:** 15-25 words
- **Content:** Low-risk value proposition

#### `contact`
- `name`: Full name
- `role`: Title, Company
- `email`: Email address
- `phone`: Phone or website

---

## Icon Reference

| Theme | Icon Name |
|-------|-----------|
| IT/Systems | Settings |
| Documents | FileText |
| People/Team | Users |
| Time/Duration | Clock |
| Warning/Risk | AlertTriangle |
| Ideas/Learning | Lightbulb |
| Discovery | Search |
| Metrics/ROI | BarChart3 |
| Strategy | Map |
| Security | Shield |
| Data/Infrastructure | Database |
| Speed/Practical | Rocket |
| Voice/Audio | Mic |
| Knowledge/SOPs | BookOpen |
| AI/Intelligence | Brain |
| Schedule | Calendar |
| Inventory | Package |
| Success | CheckCircle |
| Business | Briefcase |
| Global/Regional | Globe |
| Platform | Layers |
| Server | Server |
| Processing | Cpu |
| Compliance | Scale |
| Video/Remote | Video |
| Industrial | HardHat |
| Construction | Building |

---

## Output JSON Structure

Ensure output matches this exact structure:

```json
{
  "client_name": "string",
  "engagement_title_1": "string",
  "engagement_title_2": "string",
  "date": "string",
  "situation_summary": "string",
  "challenges": [{ "icon": "string", "title": "string", "description": "string" }],
  "impact_paragraph_1": "string",
  "impact_paragraph_2": "string",
  "engagement_name": "string",
  "objectives": [{ "icon": "string", "title": "string", "description": "string" }],
  "engagement_callout": "string",
  "value_items": [{ "icon": "string", "title": "string", "description": "string" }],
  "phase_1": { "title": "string", "description": "string", "topics": ["string"], "note": "string" },
  "phase_2": { "title": "string", "description": "string", "activities": ["string"], "outcome": "string" },
  "phase_3_docs": [{ "icon": "string", "title": "string", "subtitle": "string", "items": ["string"] }],
  "deliverables_note": "string",
  "opportunities": [{ "icon": "string", "title": "string", "description": "string", "impact": "string" }],
  "tech_section_title": "string",
  "tech_considerations": [{ "icon": "string", "text": "string" }],
  "tech_card": { "icon": "string", "title": "string", "description": "string" },
  "it_context": "string",
  "it_document_items": ["string"],
  "it_callout": "string",
  "investment": { "amount": "string", "currency": "string", "tax_label": "string (optional)", "includes": ["string"] },
  "duration": "string",
  "delivery_model": "string",
  "proposed_start": "string",
  "deliverables_table": [{ "name": "string", "description": "string" }],
  "future_phases": [{ "number": "string", "title": "string", "description": "string" }],
  "success_criteria": ["string"],
  "why_elab": [{ "icon": "string", "title": "string", "description": "string" }],
  "case_studies": [{ "icon": "string", "title": "string", "location": "string", "challenge": "string", "solution": "string", "impacts": ["string"] }],
  "experience_insight": "string",
  "next_steps": [{ "number": "string", "title": "string", "description": "string" }],
  "closing_text": "string",
  "contact": { "name": "string", "role": "string", "email": "string", "phone": "string" }
}
```

---

## General Content Rules

1. **UK English** - Use UK/NZ English spelling throughout all extracted content (e.g. "organisation" not "organization", "colour" not "color", "programme" not "program")
2. **No em-dashes or en-dashes** - Use hyphens or rewrite sentences to avoid dashes
3. **Currency flexibility** - Investment amounts may be in any currency. Always confirm the currency code and tax treatment with the user if not explicitly stated in the source material
4. **Factual accuracy** - All extracted content must be directly traceable to the source material. Never fabricate, embellish, or assume details that are not explicitly stated

---

*Document Version: 1.0*

# Reverse Brief Deck System

Single source of truth for generating ELab Reverse Brief reader decks.

---

## Part 1: Dimensions & Base Styles

### Slide Dimensions
```
Width:  1920px
Height: 1080px
Aspect: 16:9
```

### Base CSS
```css
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Inter', 'Segoe UI', system-ui, sans-serif; }

.slide {
  width: 1920px;
  height: 1080px;
  position: relative;
  overflow: hidden;
}

.slide-content {
  padding: 60px 80px;
  height: 100%;
}
```

### Google Fonts Import

All generated HTML must include:
```html
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
```

### ELab Brand Colour Palette
```css
:root {
  --navy: #0A1128;
  --indigo: #2C2B9F;
  --indigo-light: #4745B5;
  --purple: #2C2B9F;
  --gray-50: #F5F5F7;
  --gray-100: #F5F5F7;
  --gray-200: #e2e8f0;
  --gray-400: #94a3b8;
  --gray-500: #64748b;
  --gray-600: #475569;
  --gray-700: #334155;
  --gray-900: #0A1128;
  --white: #ffffff;
}
```

**Named Brand Tokens:**

| Token | Hex | Usage |
|-------|-----|-------|
| Midnight Indigo | `#2C2B9F` | Primary accent, headings, borders, CTAs, tags |
| ELab Navy | `#0A1128` | Body text, dark backgrounds, secondary headings |
| Indigo Light | `#4745B5` | Secondary accent, dark-slide eyebrows, hover states |
| Indigo Mid | `#6563C9` | Cover title accent colour |
| Indigo Muted | `#9190D4` | Decorative/light accent where needed |
| Dark Gradient Mid | `#1A1970` | Gradient midpoint for dark slides |
| Light Grey | `#F5F5F7` | Card/box backgrounds, subtle fills |
| White | `#FFFFFF` | Slide backgrounds (light slides), text on dark |

**Forbidden colours:** Do not use `#4f46e5`, `#6366f1`, `#7c3aed`, `#818cf8`, `#a5b4fc`, `#1e1b4b`, `#0f172a`, or any Tailwind-style indigo/purple defaults.

### Slide Variants
```css
.slide-white    { background: #ffffff; }
.slide-light    { background: #F5F5F7; }
.slide-gradient { background: linear-gradient(135deg, #0A1128 0%, #1A1970 50%, #0A1128 100%); }
```

---

## Part 1.5: Typography

### Heading Font
All headings, eyebrows, logos, module titles, investment amounts, card titles, subheadings, step numbers, metric values, and contact names:
```css
font-family: 'Poppins', 'Segoe UI', sans-serif;
```

### Body Font
All body text, descriptions, lead text, checklist items, table cells, and everything else:
```css
font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
```

### Font Size Minimums

The deck renders at 1920x1080px. These are the **minimum** font sizes:

| Element | Minimum Size | Recommended Range |
|---------|-------------|-------------------|
| Slide headlines | 56px | 56-88px |
| Section headlines | 36px | 36-48px |
| Eyebrow/label text | 20px | 20-26px |
| Body text / descriptions | 19px | 19-24px |
| Card/box body text | 18px | 18-22px |
| Table cell text | 18px | 18-20px |
| Impact tags / badges | 15px | 15-18px |
| Footnotes / captions | 16px | 16-18px |
| **Absolute minimum (nothing below this)** | **15px** | - |

**Key rule:** No text anywhere in the deck should be below 15px. If content does not fit at these sizes, reduce the amount of content rather than shrinking the font.

---

## Part 2: Typography Components

### Eyebrow
```css
.eyebrow {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 20px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  margin-bottom: 12px;
}
.eyebrow-light { color: #2C2B9F; }
.eyebrow-dark  { color: #4745B5; }
```

### Headline
```css
.headline {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 64px;
  font-weight: 700;
  letter-spacing: -0.02em;
  line-height: 1.1;
  margin-bottom: 12px;
}
.headline-light { color: #0A1128; }
.headline-dark  { color: #ffffff; }
```

### Headline Accent (for cover slide)
```css
.headline-accent {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 88px;
  font-weight: 700;
  letter-spacing: -0.02em;
  line-height: 1.1;
  color: #6563C9;
}
```

### Divider
```css
.divider {
  width: 80px;
  height: 5px;
  background: #2C2B9F;
  margin-bottom: 24px;
}
```

### Lead Text
```css
.lead {
  font-size: 26px;
  line-height: 1.5;
  margin-bottom: 24px;
}
.lead-light { color: #475569; }
.lead-dark  { color: rgba(255,255,255,0.8); }
```

### Section Label
```css
.section-label {
  font-size: 18px;
  font-weight: 600;
  color: #334155;
  margin-bottom: 20px;
}
```

---

## Part 3: Card Components

### FeatureCard
Used for: Challenges, opportunities, case studies

```css
.feature-card {
  background: #ffffff;
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.feature-card-dark {
  background: rgba(255,255,255,0.1);
  border: 1px solid rgba(255,255,255,0.1);
}

.feature-card .icon-container {
  width: 64px;
  height: 64px;
  border-radius: 14px;
  background: rgba(44, 43, 159, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 18px;
}

.feature-card .icon-container svg {
  width: 32px;
  height: 32px;
  stroke: #2C2B9F;
  stroke-width: 2;
  fill: none;
}

.feature-card .title {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 24px;
  font-weight: 700;
  color: #0A1128;
  margin-bottom: 10px;
}

.feature-card .description {
  font-size: 18px;
  line-height: 1.5;
  color: #475569;
}
```

### PillarCard
Used for: Engagement objectives, standalone value items

```css
.pillar-card {
  background: #ffffff;
  border-radius: 20px;
  padding: 32px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.pillar-card .icon-container {
  width: 72px;
  height: 72px;
  border-radius: 16px;
  background: rgba(44, 43, 159, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
}

.pillar-card .icon-container svg {
  width: 36px;
  height: 36px;
  stroke: #2C2B9F;
  stroke-width: 2;
  fill: none;
}

.pillar-card .title {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 22px;
  font-weight: 700;
  color: #0A1128;
  margin-bottom: 10px;
}

.pillar-card .description {
  font-size: 16px;
  line-height: 1.5;
  color: #475569;
}
```

### StepCard
Used for: Future phases

```css
.step-card {
  background: #ffffff;
  border-radius: 20px;
  padding: 32px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

.step-card .number {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  width: 48px;
  height: 48px;
  border-radius: 12px;
  background: linear-gradient(135deg, #2C2B9F, #4745B5);
  color: #ffffff;
  font-size: 24px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 16px;
}

.step-card .title {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 22px;
  font-weight: 700;
  color: #0A1128;
  margin-bottom: 8px;
}

.step-card .description {
  font-size: 16px;
  color: #475569;
}
```

### MetricCard
Used for: Investment amount

```css
.metric-card {
  background: rgba(255,255,255,0.1);
  border-radius: 20px;
  padding: 40px;
}

.metric-card .label {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 15px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: #4745B5;
  margin-bottom: 8px;
}

.metric-card .value {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 64px;
  font-weight: 700;
  color: #ffffff;
}

.metric-card .suffix {
  font-size: 20px;
  color: rgba(255,255,255,0.7);
  margin-top: 4px;
}
```

### ContactCard
Used for: Next steps slide

```css
.contact-card {
  background: rgba(255,255,255,0.1);
  border-radius: 20px;
  padding: 32px;
  border: 1px solid rgba(255,255,255,0.1);
}

.contact-card .name {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  font-size: 24px;
  font-weight: 700;
  color: #ffffff;
  margin-bottom: 4px;
}

.contact-card .role {
  font-size: 16px;
  color: rgba(255,255,255,0.7);
  margin-bottom: 16px;
}

.contact-card .detail {
  font-size: 16px;
  color: rgba(255,255,255,0.8);
  margin-bottom: 8px;
}
```

### ChecklistItem
Used for: Workshop topics, discovery activities, success criteria

```css
.checklist-item {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: 16px 20px;
  background: #F5F5F7;
  border-radius: 12px;
  margin-bottom: 12px;
}

.checklist-item svg {
  width: 24px;
  height: 24px;
  stroke: #2C2B9F;
  stroke-width: 2;
  fill: none;
  flex-shrink: 0;
  margin-top: 2px;
}

.checklist-item p {
  font-size: 18px;
  line-height: 1.5;
  color: #334155;
}
```

### ImpactTag
Used for: AI opportunities

```css
.impact-tag {
  display: inline-block;
  padding: 6px 14px;
  background: rgba(44, 43, 159, 0.1);
  color: #2C2B9F;
  font-size: 15px;
  font-weight: 600;
  border-radius: 20px;
  margin-top: 12px;
}
```

### Callout Box
```css
.callout {
  padding: 24px 32px;
  background: #ffffff;
  border-radius: 16px;
  border-left: 4px solid #2C2B9F;
  margin-top: 32px;
}

.callout p {
  font-size: 18px;
  line-height: 1.6;
  color: #334155;
}

.callout-dark {
  background: #2C2B9F;
}

.callout-dark p {
  color: #ffffff;
}
```

---

## Part 4: Layout Grids

### 3-Column Grid (Challenges, Opportunities)
```css
.grid-3 {
  display: flex;
  flex-wrap: wrap;
  gap: 24px;
}

.grid-3 > * {
  width: calc(33.333% - 16px);
}
```

### 2-Column Grid (Deliverables docs, case studies)
```css
.grid-2 {
  display: flex;
  gap: 32px;
}

.grid-2 > * {
  flex: 1;
}
```

### 4-Column Grid (Engagement objectives)
```css
.grid-4 {
  display: flex;
  gap: 24px;
}

.grid-4 > * {
  flex: 1;
}
```

### 2x3 Grid (Standalone value - 6 items)
```css
.grid-2x3 {
  display: flex;
  flex-wrap: wrap;
  gap: 24px;
}

.grid-2x3 > * {
  width: calc(33.333% - 16px);
}
```

---

## Part 4.5: Logo Requirements

### Logo Source
`ELab Sales and Marketing/04_Brand_Assets/Logos (ELab)/ELab Logo 3 cropped.png`

### Embedding
At generation time, read the PNG file, convert to base64, and embed directly into the HTML as `<img src="data:image/png;base64,..." />`.

### Positioning
Every slide must include the logo:
```css
.slide-logo {
  position: absolute;
  top: 48px;
  right: 60px;
  height: 44px;
  width: auto;
  z-index: 10;
}
```

### Dark Slide Variant
On gradient/dark slides, invert the logo to white:
```css
.slide-logo-dark {
  filter: brightness(0) invert(1);
}
```

Light slides use the logo as-is (dark version, no filter).

### Fallback
If the logo file cannot be found at generation time, leave the logo space completely empty. Do NOT render a text placeholder like `<div class="logo">ELab</div>`.

### Contrast
- On dark/gradient slides: the white-inverted logo must be clearly visible against the gradient
- On light slides: the dark logo must read clearly against white or `#F5F5F7`
- If a slide uses a mid-tone background behind the logo position, add a subtle semi-transparent backing or reposition

---

## Part 5: Slide-by-Slide Specification

### Slide 1: Cover
**Variant:** `gradient`

**Layout:**
- Logo: top-right (absolute positioned via `.slide-logo .slide-logo-dark`)
- Eyebrow + icon: y=280px
- Title line 1: y=340px (88px, white)
- Title line 2: y=440px (88px, `#6563C9`)
- Client name: y=560px (32px, white/80)
- Date: y=610px (26px, gray-400)
- Decorative circles: bottom-right

**Content Mapping:**
```
{{CLIENT_NAME}}
{{ENGAGEMENT_TITLE_LINE_1}}  e.g., "AI Foundations &"
{{ENGAGEMENT_TITLE_LINE_2}}  e.g., "Strategic Roadmap"
{{DATE}}                      e.g., "January 2026"
```

---

### Slide 2: Our Understanding
**Variant:** `white`

**Layout:**
- Eyebrow: "Section 1"
- Headline: "Our Understanding"
- Divider
- Lead: 1-2 sentence situation summary
- Section label: "Key Challenges"
- Grid-3: 5 FeatureCards (3 top, 2 bottom)

**Content Mapping:**
```
{{SITUATION_SUMMARY}}
{{CHALLENGES}}  Array of 3-5 items:
  - icon: (see icon mapping)
  - title: string
  - description: string (1-2 sentences)
```

---

### Slide 3: Business Impact
**Variant:** `gradient`

**Layout:**
- Eyebrow (dark): "The Challenge"
- Headline (dark): "The Business Impact"
- Lead (dark): 2 paragraphs

**Content Mapping:**
```
{{IMPACT_PARAGRAPH_1}}
{{IMPACT_PARAGRAPH_2}}
```

---

### Slide 4: Proposed Engagement
**Variant:** `light`

**Layout:**
- Eyebrow: "Section 2"
- Headline: "The Proposed Engagement"
- Lead: engagement name + intro
- Grid-4: 4 PillarCards (objectives)
- Callout box

**Content Mapping:**
```
{{ENGAGEMENT_NAME}}
{{OBJECTIVES}}  Array of 4 items:
  - icon
  - title
  - description
{{ENGAGEMENT_CALLOUT}}
```

---

### Slide 5: Standalone Value
**Variant:** `white`

**Layout:**
- Eyebrow: "What You Get"
- Headline: "Standalone Value"
- Lead: intro text
- Grid-2x3: 6 PillarCards
- Footer text (italic)

**Content Mapping:**
```
{{VALUE_ITEMS}}  Array of 6 items:
  - icon
  - title
  - description
```

---

### Slide 6: Phase 1 Workshop
**Variant:** `light`

**Layout:**
- Eyebrow: "Phase 1"
- Headline: "{{PHASE_1_TITLE}}"
- Lead: duration/format
- Checklist: 6-8 items
- Callout box (optional)

**Content Mapping:**
```
{{PHASE_1_TITLE}}
{{PHASE_1_DESCRIPTION}}
{{PHASE_1_TOPICS}}  Array of strings
{{PHASE_1_NOTE}}  Optional callout
```

---

### Slide 7: Phase 2 Discovery
**Variant:** `white`

**Layout:**
- Eyebrow: "Phase 2"
- Headline: "{{PHASE_2_TITLE}}"
- Lead: duration/format
- Checklist: 6-8 items
- Lead: outcome summary

**Content Mapping:**
```
{{PHASE_2_TITLE}}
{{PHASE_2_DESCRIPTION}}
{{PHASE_2_ACTIVITIES}}  Array of strings
{{PHASE_2_OUTCOME}}
```

---

### Slide 8: Phase 3 Deliverables
**Variant:** `gradient`

**Layout:**
- Eyebrow (dark): "Phase 3"
- Headline (dark): "Strategy & Roadmap Delivery"
- Grid-2: 2 FeatureCards (dark) with bullet lists
- Footer text

**Content Mapping:**
```
{{DELIVERABLE_DOC_1}}
  - title
  - subtitle
  - items: Array of strings
{{DELIVERABLE_DOC_2}}
  - title
  - subtitle
  - items: Array of strings
{{DELIVERABLES_NOTE}}
```

---

### Slide 9: AI Opportunities
**Variant:** `light`

**Layout:**
- Eyebrow: "Section 3"
- Headline: "AI Opportunities for Your Roadmap"
- Lead: intro
- Grid-3: 6 FeatureCards with ImpactTags
- Footer text

**Content Mapping:**
```
{{OPPORTUNITIES}}  Array of 6 items:
  - icon
  - title
  - description
  - impact: string (e.g., "50-70% less doc time")
```

---

### Slide 10: Technical Considerations
**Variant:** `white`

**Layout:**
- Eyebrow: "Section 4"
- Headline: "Technical Considerations"
- Grid-2:
  - Left: Subheading + 4 icon+text rows
  - Right: 1 FeatureCard

**Content Mapping:**
```
{{TECH_SECTION_TITLE}}  e.g., "Regional Considerations"
{{TECH_CONSIDERATIONS}}  Array of 4 items:
  - icon
  - text
{{TECH_CARD}}
  - icon
  - title
  - description
```

---

### Slide 11: Corporate IT
**Variant:** `light`

**Layout:**
- Eyebrow: "For IT Stakeholders"
- Headline: "What This Means for Corporate IT"
- Lead: context paragraph
- Subheading + Grid-2 checklist
- Callout (dark)

**Content Mapping:**
```
{{IT_CONTEXT}}
{{IT_DOCUMENT_ITEMS}}  Array of 6 strings
{{IT_CALLOUT}}
```

---

### Slide 12: Investment & Timeline
**Variant:** `gradient`

**Layout:**
- Eyebrow (dark): "Section 5"
- Headline (dark): "Investment & Timeline"
- Grid-2:
  - Left: MetricCard with checklist
  - Right: 3 stacked FeatureCards (dark)

**Content Mapping:**
```
{{INVESTMENT_AMOUNT}}  e.g., "$15,750"
{{TAX_LABEL}}          e.g., "NZD + GST" (configurable, not always NZD)
{{INVESTMENT_INCLUDES}}  Array of strings
{{DURATION}}           e.g., "4 weeks"
{{DELIVERY_MODEL}}     e.g., "Remote delivery via video conference"
{{PROPOSED_START}}     e.g., "February 2026"
```

---

### Slide 13: Tangible Deliverables
**Variant:** `white`

**Layout:**
- Eyebrow: "What You Retain"
- Headline: "Tangible Deliverables"
- Table: 2 columns (Deliverable, Description)

**Content Mapping:**
```
{{DELIVERABLES_TABLE}}  Array of items:
  - name
  - description
```

---

### Slide 14: Future Phases
**Variant:** `light`

**Layout:**
- Eyebrow: "Looking Ahead"
- Headline: "Future Phases"
- Lead: intro
- Grid-3: 3 StepCards
- Footer text

**Content Mapping:**
```
{{FUTURE_PHASES}}  Array of 3 items:
  - number: "1", "2", "3"
  - title
  - description (include price range)
```

---

### Slide 15: Success Criteria
**Variant:** `white`

**Layout:**
- Eyebrow: "Section 6"
- Headline: "Success Criteria"
- Lead: "This engagement will be considered successful when:"
- Grid-2: 8 ChecklistItems

**Content Mapping:**
```
{{SUCCESS_CRITERIA}}  Array of 8 strings
```

---

### Slide 16: Why ELab
**Variant:** `gradient`

**Layout:**
- Eyebrow (dark): "Section 7"
- Headline (dark): "Why ELab?"
- Grid-2x2: 4 PillarCards (dark)

**Content Mapping:**
```
{{WHY_ELAB}}  Array of 4 items:
  - icon
  - title
  - description
```

---

### Slide 17: Relevant Experience
**Variant:** `white`

**Layout:**
- Eyebrow: "Track Record"
- Headline: "Relevant Experience"
- Grid-2: 2 FeatureCards (case study format with impact tags)
- Callout box

**Content Mapping:**
```
{{CASE_STUDIES}}  Array of 2 items:
  - icon
  - title (company type)
  - location
  - challenge
  - solution
  - impacts: Array of strings
{{EXPERIENCE_INSIGHT}}
```

---

### Slide 18: Next Steps
**Variant:** `gradient`

**Layout:**
- Eyebrow (dark): "Section 8"
- Headline (dark): "Next Steps"
- Grid-2:
  - Left: 4 numbered steps (vertical)
  - Right: Intro text + ContactCard

**Content Mapping:**
```
{{NEXT_STEPS}}  Array of 4 items:
  - number
  - title
  - description
{{CLOSING_TEXT}}
{{CONTACT}}
  - name
  - role
  - email
  - phone
```

---

## Part 6: Icon Library

### Icon-to-Content Mapping

Use these icons based on content themes:

| Theme | Icon Name | Use For |
|-------|-----------|---------|
| IT/Systems | Settings | IT constraints, configuration |
| Documents | FileText | Reports, documentation |
| People/Team | Users | Workforce, adoption, collaboration |
| Time/Risk | Clock | Timeline, aging workforce, duration |
| Warning/Risk | AlertTriangle | Barriers, risks, compliance |
| Ideas | Lightbulb | Capability building, innovation |
| Search | Search | Discovery, analysis |
| Metrics | BarChart3 | Assessment, ROI, business case |
| Strategy | Map | Roadmap, planning |
| Security | Shield | Compliance, protection, IT approval |
| Data | Database | Architecture, infrastructure |
| Speed | Rocket | Implementation, practical |
| Voice | Mic | Voice input, audio |
| Knowledge | BookOpen | SOPs, manuals, training |
| AI/Capture | Brain | Knowledge capture, intelligence |
| Schedule | Calendar | Planning, availability |
| Inventory | Package | Stock, materials |
| Success | CheckCircle | Checklists, completion |
| Business | Briefcase | Professional experience |
| Global | Globe | Regional, international |
| Platform | Layers | Integration, Copilot positioning |
| Server | Server | Infrastructure, cloud |
| Processing | Cpu | AI models, compute |
| Compliance | Scale | Regulations, balance |
| Remote | Video | Video delivery |
| Building | Building | Enterprise, construction |
| Industrial | HardHat | Field work, industrial |

### Inline SVG Definitions

All SVG icons are defined in `generate_deck.js` in the `ICONS` object. They use `stroke: #2C2B9F` for light backgrounds and `stroke: #4745B5` for dark backgrounds via the `.icon-container-dark` class.

---

## Part 7: JSON Content Schema

The generator script expects this JSON structure:

```json
{
  "client_name": "string",
  "engagement_title_1": "string",
  "engagement_title_2": "string",
  "date": "string",
  
  "situation_summary": "string",
  "challenges": [
    { "icon": "string", "title": "string", "description": "string" }
  ],
  
  "impact_paragraph_1": "string",
  "impact_paragraph_2": "string",
  
  "engagement_name": "string",
  "objectives": [
    { "icon": "string", "title": "string", "description": "string" }
  ],
  "engagement_callout": "string",
  
  "value_items": [
    { "icon": "string", "title": "string", "description": "string" }
  ],
  
  "phase_1": {
    "title": "string",
    "description": "string",
    "topics": ["string"],
    "note": "string"
  },
  
  "phase_2": {
    "title": "string",
    "description": "string",
    "activities": ["string"],
    "outcome": "string"
  },
  
  "phase_3_docs": [
    {
      "icon": "string",
      "title": "string",
      "subtitle": "string",
      "items": ["string"]
    }
  ],
  "deliverables_note": "string",
  
  "opportunities": [
    { "icon": "string", "title": "string", "description": "string", "impact": "string" }
  ],
  
  "tech_section_title": "string",
  "tech_considerations": [
    { "icon": "string", "text": "string" }
  ],
  "tech_card": {
    "icon": "string",
    "title": "string",
    "description": "string"
  },
  
  "it_context": "string",
  "it_document_items": ["string"],
  "it_callout": "string",
  
  "investment": {
    "amount": "string",
    "currency": "string",
    "tax_label": "string (optional - defaults to currency + ' + GST')",
    "includes": ["string"]
  },
  "duration": "string",
  "delivery_model": "string",
  "proposed_start": "string",
  
  "deliverables_table": [
    { "name": "string", "description": "string" }
  ],
  
  "future_phases": [
    { "number": "string", "title": "string", "description": "string" }
  ],
  
  "success_criteria": ["string"],
  
  "why_elab": [
    { "icon": "string", "title": "string", "description": "string" }
  ],
  
  "case_studies": [
    {
      "icon": "string",
      "title": "string",
      "location": "string",
      "challenge": "string",
      "solution": "string",
      "impacts": ["string"]
    }
  ],
  "experience_insight": "string",
  
  "next_steps": [
    { "number": "string", "title": "string", "description": "string" }
  ],
  "closing_text": "string",
  "contact": {
    "name": "string",
    "role": "string",
    "email": "string",
    "phone": "string"
  }
}
```

---

## Part 8: Content Extraction Rules

When converting the Reverse Brief prose document to JSON:

1. **Situation Summary**: First paragraph of "Our Understanding" section, condensed to 1-2 sentences
2. **Challenges**: Extract bullet points, assign icons based on theme (see Part 6 mapping)
3. **Impact Paragraphs**: Summarise "Business Impact" section into 2 focused paragraphs
4. **Objectives**: Extract from "Proposed Engagement" section, limit to 4 items
5. **Value Items**: Extract from "Standalone Value" section, limit to 6 items
6. **Phase Topics/Activities**: Direct extraction from phase sections
7. **Opportunities**: Extract from "AI Opportunities" section with impact metrics
8. **Investment**: Extract exact figures, don't round
9. **Success Criteria**: Direct extraction, limit to 8 items
10. **Case Studies**: Source from `ELab Sales and Marketing/01_Sales_Enablement/Case Studies/` - use verbatim details from the case study files, never fabricate

**Length Limits for Slides:**
- Titles: 3-5 words
- Descriptions: 1-2 sentences (max 25 words)
- Lead text: 2-3 sentences (max 50 words)
- Callouts: 1-2 sentences

---

## Part 9: Executive Summary Guidelines

The executive summary is a separate A4 document generated alongside the deck.

### Dimensions
```css
@page { size: A4; margin: 1.2cm 1.8cm; }
```

### Brand
- Same colour palette as the deck (Midnight Indigo, ELab Navy, Light Grey, White)
- Same typography (Poppins headings, Inter body)
- Logo base64-embedded in the header

### Module Box Row Separation
Replace margin-based separation with border-based separation for clear visual scanning:
```css
.item {
  display: flex;
  gap: 6px;
  margin-bottom: 0;
  font-size: 7pt;
  padding: 3px 0;
  border-bottom: 1px solid #e8e8ea;
}
.item:last-child {
  border-bottom: none;
}
```

### PDF Generation
Use weasyprint for PDF output from the HTML.

---

## Part 10: DOCX Case Study Pack Guidelines

The DOCX case study pack is generated using docx-js (the `docx` npm package).

### Colour Constants
```javascript
const MIDNIGHT_INDIGO = '2C2B9F';
const ELAB_NAVY = '0A1128';
const LIGHT_GREY = 'F5F5F7';
const WHITE = 'FFFFFF';
```

### Font Rules
- All heading `TextRun` objects: `font: 'Poppins'`
- All body `TextRun` objects: `font: 'Inter'`

### Styling
- Table header rows: shaded with `LIGHT_GREY` (`F5F5F7`)
- Accent borders (callout boxes, left-border highlights): `MIDNIGHT_INDIGO` (`2C2B9F`)
- Body text colour: `ELAB_NAVY` (`0A1128`)

---

## Part 11: General Rules

These rules apply to ALL generated documents (deck, executive summary, DOCX):

1. **UK English** spelling and grammar throughout (e.g. "organisation" not "organization", "colour" not "color" in copy text, "programme" not "program")
2. **No em-dashes or en-dashes** in generated text. Use hyphens or rewrite sentences to avoid them
3. **PDF generation** uses weasyprint for the deck and executive summary
4. **Slide dimensions** are 1920x1080px with `@page { size: 1920px 1080px; margin: 0; }`
5. **Executive summary dimensions** are A4 with `@page { size: A4; margin: 1.2cm 1.8cm; }`
6. **Each slide must have `page-break-after: always`** (except the last) for correct PDF pagination
7. **Base64-embed all images** (especially the logo) to ensure PDF rendering works without external file dependencies
8. **Investment figures** use the format `$15,000` with a configurable `tax_label` field. Currency is not always NZD
9. **Contrast check everything** - every piece of text and every logo placement should be checked for readability against its background
10. **Content accuracy** - all case study information, client details, metrics, and impact figures must be sourced directly from provided materials. Never fabricate or embellish. Use `[CONFIRM: ...]` placeholders for any uncertain or missing data
11. **Review before generating** - always present the prose reverse brief and extracted JSON to the user for review and confirmation before running the generator scripts. This catches content errors before PDF/DOCX generation, saving time and tokens. Do not generate final documents until the user has confirmed the drafts

---

*Document Version: 2.0*
*Last Updated: February 2026*

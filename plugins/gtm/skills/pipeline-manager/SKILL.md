---
name: pipeline-manager
description: "The entry point for every new lead and all pipeline operations. Use this skill first whenever a new lead comes in, someone is mentioned as a potential client, a deal needs to be created, or any pipeline action is needed (stage advance, deal update, report). Also trigger for 'new lead', 'just heard from', 'got a referral', 'came in via', 'inbound from', 'can you add to pipeline', 'create a deal', 'what's in the pipeline', or any CRM operation. Pipeline Manager is always the first step — before research, before qualification, before outreach."
---

> **House Style:** Before producing any written output, load and apply ELab's tone of voice and house style rules from `../communications-drafter/references/ELab-Voice-System-Prompt.md`. This applies to all written output from this skill.

# Pipeline Manager

Single CRM interface for the ELab BD Pipeline. Creates deals, advances them through stages, attaches skill outputs and documents, updates properties, and generates pipeline reports. All other skills produce outputs — this skill handles the Notion operations.

## When to Use

- Creating a new deal from a lead (inbound or outbound)
- Moving a deal to the next pipeline stage
- Attaching outputs from other skills (research dossier, qualification scorecard, reverse brief, etc.)
- Querying deals by stage, client, owner, or status
- Updating deal properties (value, priority, contacts, services)
- Generating pipeline reports and summaries
- Logging meeting notes, transcripts, or correspondence to a deal

---

## Target Database

**Database name:** Opportunities
**Database ID:** `9e29ade1-7a7a-48b8-9403-fededff1c724`

### Related Databases

| Database | ID | Purpose |
|---|---|---|
| Accounts | `47177b40-6cc5-46e9-a824-0c24051e118b` | Client company records |
| Contacts | `2b4577f5-9b9f-802b-b9de-d699d8fc54c5` | People / primary contacts |
| Master Services & Modules | `2b7577f5-9b9f-8029-a5d1-d44cd5a22738` | Service tags (AI Foundations, etc.) |
| Funnel Dashboard | `28b577f5-9b9f-8087-96e6-c242d27eb8dd` | Pipeline stages (Lead, Qualified, etc.) |

> **Schema-first rule:** Before creating or updating any deal, ALWAYS fetch the current Opportunities database schema using `API-retrieve-a-database` with `database_id: "9e29ade1-7a7a-48b8-9403-fededff1c724"` to confirm field names, property types, and available options.

### Accounts Database Schema

| Field | Type | Notes |
|---|---|---|
| **Account Name** | title | Company name |
| **Status** | select | Prospect, Client (active), Client (inactive), Lost, Active |
| **Industry** | select | Legal / Professional Services, Financial Services / PE, Industrial / Field Services, Construction, Healthcare, Technology, Government / Public Sector, Other |
| **Location** | rich_text | City / region (e.g. "Tauranga, NZ" or "Hong Kong") |
| **Headcount** | number | Approximate company size |
| **Website** | url | Company website |
| **Billing Address** | rich_text | Physical address |
| **Owner** | people | Account owner (ELab team member) |
| **Related Opportunities** | relation | Auto-synced from Opportunities → Accounts |
| **Related Contacts** | relation | Auto-synced from Contacts → Accounts |

> **Fields to add manually in Notion:** Industry (select), Location (rich text), Headcount (number). Add via the "+" button on the Accounts database column headers. These are optional enrichment fields — existing records won't break.

### Contacts Database Schema

| Field | Type | Notes |
|---|---|---|
| **Name** | title | Full name of the contact |
| **Title / Role** | rich_text | Job title or role (e.g. "Partner", "IT Manager") |
| **Role Type** | select | Decision Maker, Champion, Technical Contact, Gatekeeper, Influencer |
| **Email** | email | Email address |
| **Phone** | phone_number | Phone number |
| **Linkedin Address** | url | LinkedIn profile URL |
| **Accounts** | relation | Link to Account page (auto-syncs to Account's Related Contacts) |

> **Field to add manually in Notion:** Role Type (select) with options: Decision Maker, Champion, Technical Contact, Gatekeeper, Influencer. Helps the skill know who to address at each pipeline stage.

> **Create-if-missing rule:** When creating a deal, search for matching Account and Contact records first. If they don't exist, **create them** before creating the deal so all relations can be properly linked. Never leave relation fields empty when the information is available.

### Master Services Catalogue

Standard service records in the Master Services & Modules database. Link to deals via the Services relation.

| Service | Page ID |
|---|---|
| AI Foundations (Strategic) | `320577f5-9b9f-814c-a3f3-eca4d8135580` |
| AI Foundations (Operations) | `320577f5-9b9f-816d-99f6-f8d93be0f092` |
| AI Strategy & Governance | `320577f5-9b9f-813e-89bb-e684c76928e2` |
| AI Discovery & Pilot | `320577f5-9b9f-81c6-8f9e-f8771b1b529b` |
| Managed AI Services | `320577f5-9b9f-81f2-840f-e7e84a278a1b` |
| Custom AI Development | `320577f5-9b9f-8198-b579-f341c9d31891` |
| AI Workshops & Training | `320577f5-9b9f-81ce-a2b2-f644d7f9edb1` |

> When creating a deal, suggest relevant services based on the context. Most new client engagements start with **AI Foundations (Strategic)** or **AI Foundations (Operations)**. Governance-focused clients also get **AI Strategy & Governance**. If a pilot is discussed, add **AI Discovery & Pilot**.

---

## Available MCP Tools

- `API-retrieve-a-database` — Get database schema and field definitions
- `API-query-data-source` — Query deals with filters and sorting
- `API-get-users` — Get user list and resolve user IDs
- `API-post-page` — Create new deal records
- `API-patch-page` — Update existing deal properties
- `API-post-search` — Search for deals, accounts, contacts, services, or stages by text
- `API-get-block-children` — Read page body content (attached notes, outputs)
- `API-patch-block-children` — Append content to a deal page (attach outputs, notes)
- `API-retrieve-a-page` — Get full details of a specific deal

---

## Field Reference (Live Schema)

### Title Field

- **Project** (title) — Deal name. Format: `Client Name - Project/Opportunity Name`

### Relation Fields (require page IDs)

| Field | Relates To | How to Set |
|---|---|---|
| **Stage** | Funnel Dashboard | Link to stage page ID |
| **Accounts** | Accounts database | Link to account page ID |
| **Primary Contacts** | Contacts database | Link to contact page ID |
| **Services** | Master Services & Modules | Link to service page IDs |

### Select Fields

| Field | Options |
|---|---|
| **Source** | Website Form, CSV Import, Live Chat, LinkedIn, Email, Event, Referral, Partner Engagement, Follow-On From Previous, Inbound |
| **Priority Level** | High, Medium, Low |
| **Likelihood** | High, Medium, Low |
| **Relationship** | Warm, Cold, New |
| **Closed Lost Reason** | Timing, Budget, Size, Disqualified, Unresponsive |

### Number Fields

| Field | Format |
|---|---|
| **Estimated value** | Dollar (NZD) — numeric only |

### Date Fields

| Field | Purpose | Set When |
|---|---|---|
| **Date Lead** | Lead entered | Deal created |
| **Date Pre Pipeline Discovery** | Moved to Stage 2 | Stage → Pre Pipeline Discovery |
| **Date Qualified (Entered Pipeline)** | Qualified | Stage → Qualified |
| **Date Contacted** | First outreach sent | Stage → Contacted |
| **Date Initial Meet** | Discovery meeting held | Stage → Initial Meet |
| **Date Reverse Brief Sent** | Brief sent | Stage → Reverse Brief Sent |
| **Date Feedback/Negotiating/Objection Handling** | Negotiating | Stage → Feedback/Negotiating |
| **Date SOW/MSA/Final Contracting** | Contracts sent | Stage → SOW/MSA |
| **Date Close Won - Pending Kick Off** | Deal won | Stage → Won |
| **Date Closed Lost** | Deal lost | Deal marked lost |
| **Expected Close Date** | Projected close | Updated as deal progresses |
| **Project Start Date** | Projected start | Set at SOW/contracting stage |
| **Project Completed Date** | Completion | Post-delivery |

### Other Fields

| Field | Type | Notes |
|---|---|---|
| **Client Folder Link** | URL | Link to Google Drive client folder |
| **Archive** | Checkbox | Mark archived deals |

### Recommended Fields (add manually in Notion)

| Field | Type | Why |
|---|---|---|
| **Next Action** | rich_text | What's the next step on this deal (e.g. "Send reverse brief") |
| **Next Action Date** | date | When should the next step happen — enables stale deal alerting |
| **Referrer** | rich_text | Who referred the deal (e.g. "Andrew Meakin via Jeremy") |

> These fields reduce reliance on page body notes for critical deal tracking info. Add via "+" on the Opportunities database column headers. Until added, these are captured in page body.

### Fields Not in Schema (Captured in Page Body)

- **Lead Type** (Inbound / Outbound)
- **Owner** (deal owner name)
- **Notes / Context** (initial context, meeting notes, correspondence)

---

## Pipeline Stage Page IDs

Stage is a **relation field** linking to the Funnel Dashboard. To set or change a deal's stage, link to the correct page ID.

| Stage | Page ID | Order | Group | Date Field to Set |
|---|---|---|---|---|
| Lead | `28b577f5-9b9f-8032-a215-f22c108ea118` | 1 | Prospecting & Qualification | Date Lead |
| Pre Pipeline Discovery | `28b577f5-9b9f-80eb-8921-f03f869b5cf3` | 2 | Prospecting & Qualification | Date Pre Pipeline Discovery |
| Qualified | `28b577f5-9b9f-80cf-a642-d9babf677c59` | 3 | Prospecting & Qualification | Date Qualified (Entered Pipeline) |
| Contacted | `28b577f5-9b9f-806d-b892-d17c3e880c04` | 4 | Discovery | Date Contacted |
| Initial Meet | `28b577f5-9b9f-80c0-bdf4-c0f1c81dc647` | 5 | Discovery | Date Initial Meet |

> For stages 6–9 and lost/on-hold, search the Funnel Dashboard by title at runtime to resolve the page ID.

---

## Operation 1: Create Deal

### Inputs

| Input | Required | Notes |
|---|---|---|
| Client company name | Yes | Used for naming and Account linking |
| Project / opportunity name | Yes | Used in deal naming |
| Contact name(s) and role(s) | Yes | Linked as Primary Contacts |
| Source | Yes | Must match a Source select option |
| Lead type (inbound/outbound) | Yes | Written to page body |
| Initial context | Yes | Written to page body |
| Estimated value | No | Ask if not provided |
| Services | No | Suggest based on context |
| Deal owner | No | Written to page body — default: Tushar or Antoni |
| Relationship | No | Warm, Cold, or New |
| Likelihood | No | High, Medium, or Low — estimate based on engagement signals |

### Process

1. **Fetch schema** — verify field names and options
2. **Check for duplicates** — search for existing deals with same client name
3. **Resolve or create Account** — search Accounts database for the client company. If not found, create a new Account page with name and status "Prospect"
4. **Resolve or create Contacts** — search Contacts database for each contact. If not found, create new Contact pages with name, title/role, and link to the Account
5. **Resolve Services** — search Master Services & Modules for matching service page IDs
6. **Create deal** — `API-post-page` with all properties, relations, and page body content
7. **Prompt for missing details** — ask for any info not captured: contact emails/phone/LinkedIn, estimated value, client folder URL
8. **Confirm** — present full summary of what was created (deal, account, contacts, services linked)
9. **Notify BD team** — draft Slack message for Tushar and Antoni

### Relation Resolution Detail

**Resolve or create Account:**
```
1. API-post-search with query: "<client company name>"
2. Filter results for pages in database 47177b40-6cc5-46e9-a824-0c24051e118b
3. If found → use existing page ID
4. If NOT found → API-post-page to create:
   {
     "parent": { "database_id": "47177b40-6cc5-46e9-a824-0c24051e118b" },
     "properties": {
       "Account Name": { "title": [{ "text": { "content": "<company name>" } }] },
       "Status": { "select": { "name": "Prospect" } }
     }
   }
5. Use the new page ID for the deal's Accounts relation
```

**Resolve or create Contacts:**
```
1. API-post-search with query: "<contact name>"
2. Filter results for pages in database 2b4577f5-9b9f-802b-b9de-d699d8fc54c5
3. If found → use existing page ID
4. If NOT found → API-post-page to create:
   {
     "parent": { "database_id": "2b4577f5-9b9f-802b-b9de-d699d8fc54c5" },
     "properties": {
       "Name": { "title": [{ "text": { "content": "<full name>" } }] },
       "Title / Role": { "rich_text": [{ "text": { "content": "<role>" } }] },
       "Accounts": { "relation": [{ "id": "<account-page-id>" }] }
     }
   }
   Optionally set Email, Phone, Linkedin Address if available.
5. Use the new page ID(s) for the deal's Primary Contacts relation
```

**Resolve Services:**
```
1. API-post-search with query: "<service name>" (e.g. "AI Foundations")
2. Filter results for pages in database 2b7577f5-9b9f-8029-a5d1-d44cd5a22738
3. Collect matching page IDs for the deal's Services relation
```

### Create Payload Format

```json
{
  "parent": {
    "database_id": "9e29ade1-7a7a-48b8-9403-fededff1c724"
  },
  "properties": {
    "Project": {
      "title": [{ "text": { "content": "Client Name - Project Name" } }]
    },
    "Stage": {
      "relation": [{ "id": "28b577f5-9b9f-8032-a215-f22c108ea118" }]
    },
    "Accounts": {
      "relation": [{ "id": "<account-page-id>" }]
    },
    "Primary Contacts": {
      "relation": [{ "id": "<contact-page-id>" }]
    },
    "Services": {
      "relation": [{ "id": "<service-page-id>" }]
    },
    "Source": {
      "select": { "name": "Referral" }
    },
    "Estimated value": {
      "number": 25000
    },
    "Relationship": {
      "select": { "name": "Warm" }
    },
    "Priority Level": {
      "select": { "name": "Medium" }
    },
    "Date Lead": {
      "date": { "start": "2026-03-11" }
    }
  },
  "children": [
    {
      "paragraph": {
        "rich_text": [{
          "text": {
            "content": "Lead Type: Inbound (Referral)\nOwner: Tushar\nSource Detail: Referral from Julian at Potentia\n\nContext: CEO wants to explore AI for maintenance operations."
          }
        }]
      }
    }
  ]
}
```

---

## Operation 2: Advance Stage

### Process

1. **Find the deal** — search by name or client
2. **Determine current stage** — read the Stage relation
3. **Validate advancement** — check prerequisites (see Stage Progression Rules below)
4. **Update stage** — change Stage relation to the next stage page ID
5. **Set date** — update the corresponding date field with today's date
6. **Log the transition** — append a note to the page body

### Stage Progression Rules

| From | To | Prerequisites | Next Skill |
|---|---|---|---|
| Lead | Pre Pipeline Discovery | Lead Qualifier returned GO; research dossier attached | Communications Drafter [3] — outreach |
| Pre Pipeline Discovery | Qualified | Outreach sent to prospect | Meeting Prep [4] when meeting booked |
| Qualified | Contacted | Outreach email sent | Meeting Prep [4] when meeting booked |
| Contacted | Initial Meet | Discovery meeting booked | Meeting Prep [4] — discovery type |
| Initial Meet | Reverse Brief Sent | Meeting held; transcript or notes attached | Reverse Brief Generator [5] |
| Reverse Brief Sent | Feedback/Negotiating | Reverse Brief sent to client | Negotiation Advisor [6] if pushback |
| Feedback/Negotiating | SOW/MSA | Client confirmed brief; procurement requirements checked | Contract Assembler [7] |
| SOW/MSA | Won | Contracts signed | — pipeline complete |

> These are guidelines, not hard blocks. If the user explicitly wants to skip ahead, allow it but flag what's missing.

### Advance Payload Format

```json
{
  "page_id": "<deal-page-id>",
  "properties": {
    "Stage": {
      "relation": [{ "id": "<next-stage-page-id>" }]
    },
    "Date Pre Pipeline Discovery": {
      "date": { "start": "2026-03-12" }
    }
  }
}
```

### Log Transition (append to page body)

```json
{
  "block_id": "<deal-page-id>",
  "children": [
    {
      "paragraph": {
        "rich_text": [{
          "text": {
            "content": "--- Stage Transition: Lead → Pre Pipeline Discovery (2026-03-12) ---\nAdvanced by: [user]. Research dossier attached."
          }
        }]
      }
    }
  ]
}
```

---

## Operation 3: Attach Skill Output

When another skill completes its work, the Pipeline Manager attaches the output to the deal.

### What Gets Attached

| Skill | Output to Attach | Stage Triggered |
|---|---|---|
| Client Deep Research [1] | Research dossier summary | → Pre Pipeline Discovery |
| Lead Qualifier [2] | Qualification scorecard + GO/NO-GO | → Qualified (if GO) |
| Communications Drafter [3] | Communication log (type, recipient, subject, date) | → Contacted (when outreach sent) |
| Meeting Prep [4] | Briefing doc summary | Before Initial Meet |
| Reverse Brief Generator [5] | Brief summary + file path | → Reverse Brief Sent |
| Negotiation Advisor [6] | Strategy summary + pipeline impact | During Feedback/Negotiating |
| Contract Assembler [7] | SOW/MSA summary + file path | → SOW/MSA |

### Attachment Process

1. **Find the deal** — search by client or deal name
2. **Append output to page body** — use `API-patch-block-children` with the deal's page ID
3. **Update Client Folder Link** — if the output is saved to Google Drive, update the URL
4. **Advance stage if appropriate** — follow Stage Progression Rules
5. **Confirm** — report what was attached and any stage change

### Attachment Format

```json
{
  "block_id": "<deal-page-id>",
  "children": [
    {
      "paragraph": {
        "rich_text": [{
          "text": {
            "content": "--- Client Deep Research Output (2026-03-12) ---"
          }
        }]
      }
    },
    {
      "paragraph": {
        "rich_text": [{
          "text": {
            "content": "[Research dossier content or summary here]"
          }
        }]
      }
    }
  ]
}
```

---

## Operation 4: Query Deals

### Common Queries

**Find deals at a specific stage:**
```
API-post-search with query: "" (empty)
Then filter results where parent.database_id = "9e29ade1-7a7a-48b8-9403-fededff1c724"
and Stage relation contains the target stage page ID.
```

**Find deals for a client:**
```
API-post-search with query: "Client Name"
Filter results for pages in the Opportunities database.
```

**Find a specific deal:**
```
API-post-search with query: "Deal Name"
Filter by parent database.
```

### Query Response Format

```
📋 Pipeline Summary — [Stage/Client/Filter]

1. Acme Industrial - AI Maintenance Ops
   Stage: Lead | Source: Referral | Value: $25,000
   Date Lead: 2026-03-11 | Owner: Tushar
   Link: [URL]

2. Meridian Finance - AI Governance
   Stage: Qualified | Source: Website Form | Value: $40,000
   Date Qualified: 2026-03-08 | Owner: Antoni
   Link: [URL]

Total deals: 2 | Total pipeline value: $65,000
```

---

## Operation 5: Update Deal Properties

### Process

1. **Find the deal** — search by name or client
2. **Validate changes** — check field types and option values against schema
3. **Update** — `API-patch-page` with changed properties
4. **Confirm** — report what changed

### Common Updates

**Update estimated value:**
```json
{ "page_id": "<id>", "properties": { "Estimated value": { "number": 40000 } } }
```

**Add/change contacts:**
```json
{ "page_id": "<id>", "properties": { "Primary Contacts": { "relation": [{ "id": "<contact-id>" }] } } }
```

**Update priority:**
```json
{ "page_id": "<id>", "properties": { "Priority Level": { "select": { "name": "High" } } } }
```

**Set expected close date:**
```json
{ "page_id": "<id>", "properties": { "Expected Close Date": { "date": { "start": "2026-04-30" } } } }
```

**Update Client Folder Link:**
```json
{ "page_id": "<id>", "properties": { "Client Folder Link": { "url": "https://drive.google.com/..." } } }
```

**Mark as lost:**
```json
{
  "page_id": "<id>",
  "properties": {
    "Stage": { "relation": [{ "id": "<closed-lost-stage-id>" }] },
    "Closed Lost Reason": { "select": { "name": "Budget" } },
    "Date Closed Lost": { "date": { "start": "2026-03-15" } }
  }
}
```

---

## Operation 6: Pipeline Report

### Process

1. **Query all active deals** — exclude archived and closed-lost
2. **Group by stage** — count deals and sum value per stage
3. **Flag stale deals** — any deal sitting in the same stage for more than 2 weeks
4. **Present summary**

### Report Format

```
📊 ELab BD Pipeline Report — 2026-03-11

Stage Breakdown:
  Lead:                    2 deals | $50,000
  Pre Pipeline Discovery:  1 deal  | $25,000
  Qualified:               3 deals | $90,000
  Contacted:               2 deals | $60,000
  Initial Meet:            1 deal  | $40,000
  Reverse Brief Sent:      1 deal  | $35,000
  Feedback/Negotiating:    0 deals | $0
  SOW/MSA:                 1 deal  | $45,000
  ---
  Active Pipeline Total:   11 deals | $345,000

⚠️ Stale Deals (>2 weeks at same stage):
  - Waikato Steel - AI Field Ops: Lead since 2026-02-20 (19 days)
  - NZ Builders - AI Governance: Contacted since 2026-02-25 (14 days)

🎯 Deals Expected to Close This Month:
  - Meridian Finance - AI Governance ($40,000) — Expected: 2026-03-28
```

---

## Quality Checks

Before any operation:

- ✅ Schema fetched and verified in this session
- ✅ No duplicate deals (searched before creating)
- ✅ Account exists (or created) and linked to deal
- ✅ Contact(s) exist (or created), linked to Account, and linked to deal
- ✅ All relation fields use page IDs (not text names)
- ✅ Select values match available options exactly
- ✅ Date fields updated when stage changes
- ✅ Page body includes Lead Type, Owner, and context
- ✅ Stage transitions logged in page body
- ✅ User prompted for any missing information

---

## Error Prevention

**Never:**
- Create a deal without checking for duplicates
- Assume field names or option values — verify against schema
- Put text in relation fields — resolve to page IDs
- Leave Account or Contact relations empty when the information is available
- Skip stage date updates when advancing
- Advance past a stage without flagging missing prerequisites

**Always:**
- Fetch schema at the start of every session
- Search for existing Account/Contact records before creating new ones (avoid duplicates)
- Create Account and Contact records if they don't exist — never leave relations unlinked
- Link Contacts to their Account (via the Accounts relation on the Contact page)
- Resolve Account, Contact, Service, and Stage page IDs before writing to the deal
- Set the corresponding date field when changing stages
- Log stage transitions and attachments in the page body
- Present summaries before and after modifications

---

## Pipeline Rules (from Playbook)

1. **4-Hour Rule:** New leads must be triaged within four business hours
2. **48-Hour Discovery Target:** Book discovery session within 48 hours of lead entry
3. **Naming convention:** `Client Name - Project Name`
4. **Schema-first:** Always verify before creating or updating
5. **BD notification:** New leads → notify Tushar and Antoni
6. **Client folder:** After deal creation, create client folder in ELab AI Advisory and set the `Client Folder Link` URL on the deal
7. **Contact completeness:** Always prompt for email, phone, and LinkedIn for every contact. Update contact records as details become available.
8. **Services tagging:** Every deal must have at least one service linked. Suggest based on context if not specified.
9. **Document everything:** All meeting notes, transcripts, and skill outputs → page body or client folder

---

## Troubleshooting

**Relation fields not linking:**
Relations require page IDs. Search for the target page, filter by `parent.database_id`.

**Stage not updating:**
Stage is a relation, not a select. Link to the correct Funnel Dashboard page ID.

**"Invalid request" errors:**
Fetch schema and verify exact field names (case-sensitive). Check format: relations use `{ "relation": [{ "id": "..." }] }`, selects use `{ "select": { "name": "..." } }`.

**Deal in wrong database:**
Ensure `parent.database_id` is `9e29ade1-7a7a-48b8-9403-fededff1c724` (Opportunities).

**Unknown stage page ID:**
Search the Funnel Dashboard: `API-post-search` with the stage name, filter for pages in database `28b577f5-9b9f-8087-96e6-c242d27eb8dd`.

**Account or Contact not linking to deal:**
Ensure you searched the correct database (Accounts: `47177b40-6cc5-46e9-a824-0c24051e118b`, Contacts: `2b4577f5-9b9f-802b-b9de-d699d8fc54c5`). If not found, create the record first, then link to the deal. When creating Contacts, always link them to their Account via the `Accounts` relation field on the Contact page.

**Duplicate Account/Contact created:**
Before creating, search broadly (partial name match). If an existing record has a slightly different name (e.g. "CLM Law" vs "CLM"), confirm with the user before creating a new one.

---

## Handoff

**Pipeline Manager is the hub — it doesn't hand off to one skill. Instead, after every CRM operation, suggest the next skill based on the deal's current stage:**

| After this PM operation | Suggest next skill |
|---|---|
| Deal created (Stage 1: Lead) | Lead Qualifier [1] — quick qualify on available context |
| Stage advanced to Pre Pipeline Discovery | Communications Drafter [3] — outreach type (research dossier should now exist) |
| Stage advanced to Qualified | Communications Drafter [3] — outreach type |
| Stage advanced to Contacted | Wait for meeting booking, then Meeting Prep [4] |
| Stage advanced to Initial Meet | Meeting Prep [4] — discovery type (if not already run) |
| Stage advanced to Reverse Brief Sent | Communications Drafter [3] — reverse_brief_cover type |
| Stage advanced to Feedback/Negotiating | Negotiation Advisor [6] when client feedback arrives |
| Stage advanced to SOW/MSA | Contract Assembler [7] (if not already run) |
| Stage advanced to Won | Communications Drafter [3] — welcome_next_steps type |

After every stage transition, always update the corresponding date field and log the transition in the page body.

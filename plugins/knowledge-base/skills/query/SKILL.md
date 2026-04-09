---
name: query
description: Search the knowledge base for captured content. Loads org rules to understand folder structure, searches local knowledge base files, and returns a synthesised answer citing source documents. Triggers on "/query", "what do we know about", "search our knowledge base", "find in our notes", "do we have anything on", "look up in our kb".
allowed-tools: Read, Grep, Glob, mcp__elab-contexta__elab_org_config
argument-hint: "[question about your knowledge base content]"
---

## When to Use

Trigger this skill whenever the user wants to retrieve or surface content already captured in the knowledge base. This includes direct queries, exploratory questions, and requests to find, check, or confirm what the organisation knows about a topic.

This skill searches **captured content** — what has been extracted and filed. It is not for questions about how knowledge systems work in general.

---

## How to Execute

### Step 1 — Load Org Config

Call `elab_org_config` with `action: "read"`.

From the response, extract:
- Which knowledge folders exist and what each contains
- Org name and vocabulary (use their terms throughout the response)
- Naming convention

If the config is empty or not yet written, fall back to the standard folder set: `SOPs/`, `Decisions/`, `Lessons/`, `Frameworks/`, `Policies/`.

---

### Step 2 — Classify the Query

Map the user's intent to the folder types most likely to contain relevant content:

| Intent | Folder type |
|---|---|
| How something is done or repeated | SOPs |
| Why something was chosen or agreed | Decisions |
| What was learned from experience | Lessons |
| How to think about a class of problem | Frameworks |
| What the standing rule or constraint is | Policies |
| Unclear or spanning multiple types | All folders |

If the org config defines custom folder names, map intent to those names instead.

---

### Step 3 — Search the Knowledge Base

Search the relevant folders using two passes:

**Pass 1 — Filename scan**
List files in the target folders and match against the core concepts in the user's question.

**Pass 2 — Full-text search**
Search file contents in the target folders for the core concepts. If results are sparse, expand to synonyms and related terms.

**Reading matched files**
Read each matched file in full. Aim for depth over breadth: 3–7 files read thoroughly is better than skimming many. Prioritise by recency (date prefix in filename) and specificity of match.

---

### Step 4 — Synthesise the Answer

**Lead with the answer.** Do not narrate the search.

**Ground in the source material.** Quote or closely paraphrase relevant passages. Use the org's vocabulary.

**Cite sources.** List the files the answer draws from, using their full relative paths.

**Be explicit about gaps.** If the knowledge base does not cover the topic, say so and offer to fill the gap via pipeline.

Do not invent, infer, or extrapolate beyond what the files actually contain.

---

### Step 5 — Offer a Clear Next Step

- Content found: offer to go deeper on a specific file or surface related content
- Content not found: offer to help capture something on the topic
- Partial results: flag what's missing and how to address it

One clear offer, not a menu.

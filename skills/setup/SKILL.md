---
name: setup
description: Set up the ELab knowledge base in this workspace. Verifies the MCP connection, asks the user questions first, shows a dry-run preview, waits for confirmation, then creates the folder structure. Triggers on "/setup", "set up my knowledge base", "initialise my workspace", "help me get started", "create my vault".
allowed-tools: Read, Write, mcp__elab-contexta__elab_features, mcp__elab-contexta__elab_setup_kb, mcp__elab-contexta__elab_org_config
---

## Critical Rule

Do NOT call `elab_setup_kb`, `elab_org_config`, or write any files until Step 4. Steps 2 and 3 are a conversation with the user — no tool calls, no file writes.

---

## Step 1 — Verify Connection

Call `elab_features` with no arguments.

- If successful: proceed to Step 2.
- If it fails: tell the user the Contexta server is not reachable and stop.

---

## Step 2 — Ask Questions (conversation only, no tool calls)

Present all questions in a single message. Do not call any tools or create any files during this step.

Ask the user:
1. What is your team or organisation name?
2. What is the primary use for this knowledge base? (client work / internal ops / research / mixed)
3. Will you use the GTM features? (Outreach, Research, Meeting-Prep, Reverse-Briefs)
4. Any custom folder names, or are the defaults fine? (defaults: SOPs, Decisions, Lessons, Frameworks, Policies)

Wait for the user to respond before proceeding.

---

## Step 3 — Show Dry-Run Summary (conversation only, no tool calls)

Based on the user's answers, present exactly what will be created. Do not call any tools or create any files during this step.

Show the complete folder list with a one-line description of each folder. Include GTM folders only if the user opted in. State the naming convention.

End with: "Ready to create? Or would you like to adjust anything first?"

Wait for the user to confirm before proceeding. If they want changes, adjust and re-present.

---

## Step 4 — Create Folders and READMEs

Only after the user confirms the dry-run summary:

1. Call `elab_setup_kb` with the user's org name and GTM preference
2. For each folder in the response, create the folder and write its README.md
3. Call `elab_org_config` (action: write) to persist the workspace configuration

---

## Step 5 — Present Summary

After everything is created, present a folder-by-folder tour explaining what each one is for and how content gets there.

End with a clear first action: drop a document into Incoming/ and say "process this document".

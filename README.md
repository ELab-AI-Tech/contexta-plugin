# ELab Contexta Plugin

**The client-facing Claude Code plugin for ELab Contexta.**

This plugin connects your AI agent (Claude Code or Cursor) to ELab's hosted capabilities server, giving you access to ELab's document processing, brand voice, formatting, and GTM tools — without any of the implementation leaving ELab's servers.

---

## Installation

You need a GitHub account that has been added as a collaborator on this repo by ELab.

```bash
/plugin marketplace add ELab-AI-Tech/contexta-plugin
/plugin install elab-contexta@ELab-AI-Tech
```

Then run setup:

```
set up Contexta
```

---

## What You Need

- An ELab API key (provided by ELab during onboarding)
- Claude Code v1.0.33+

---

## Available Capabilities (Stage 1)

| Skill | Trigger | What it does |
|---|---|---|
| `setup` | "set up Contexta", "connect to ELab" | Configures `.mcp.json` and verifies connection |
| `pipeline` | "/pipeline", "process this document" | Extracts SOPs, decisions, lessons, frameworks from source documents |

More capabilities (brand voice, formatting, GTM) are added in subsequent stages.

---

## How It Works

This plugin contains only orchestration instructions — no ELab methodology or processing logic. When you ask Claude to process a document, the plugin tells Claude to:
1. Read your local file
2. Send the content to ELab's server
3. Receive structured, extracted documents back
4. Write them to your knowledge base

The extraction logic, quality rules, and ELab methodology run entirely on ELab's server and are never exposed to the client.

---

## Support

Contact ELab for API key issues, feature upgrades, or onboarding support.

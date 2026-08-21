# Contexta Plugin

**The client-facing Claude Code plugin for ELab Contexta.**

This plugin connects your AI agent to ELab's hosted capabilities server — giving you document processing, brand voice, formatting, and GTM tools powered by ELab's methodology, without any implementation leaving ELab's servers.

---

## Installation

You need a GitHub account that has been added as a collaborator on this repo by ELab.

```
/plugin marketplace add ELab-AI-Tech/contexta-plugin
/plugin install contexta@ELab-AI-Tech
```

Then sign in to the Contexta MCP server (OAuth — no API key):

```
/mcp
```

Select **contexta** and complete the browser sign-in. After that, set up your workspace:

```
set up Contexta
```

---

## What You Need

- Claude Code with plugin support
- An ELab Contexta account (sign in via `/mcp` when prompted)

---

## Available Skills

| Skill | Trigger | What it does |
|---|---|---|
| `setup` | "set up Contexta", "set up my knowledge base", "/setup" | Verifies the MCP connection, then fetches and follows the full workspace setup process from the server |
| `audit` | "/audit", "workspace audit", conflicting skills or MCPs | Fetches `workspace/audit` and scans native skills plus MCP config for collisions with Contexta |
| `faq` | FAQ, help, how do I install/connect/sign in, troubleshooting | Fetches `setup/faq` from the server and answers from the product FAQ corpus |
| `contexta` | Any knowledge base, GTM, brand voice, or document operation | Routes to the right server skill via `contexta_get_skill`, then applies methodology locally |

Capability-specific instructions (pipeline, brand voice, GTM, format, governance, etc.) live on the server and are fetched on demand — they are not shipped in this plugin.

---

## How It Works

This plugin contains only orchestration skills — no ELab methodology or processing logic is stored here. When you ask Claude to process a document, the plugin instructs Claude to:

1. Call `contexta_get_skill` for the relevant skill (e.g. `pipeline/pipeline`)
2. Follow the returned instructions in its own context
3. Call a `contexta_*` tool only when the skill says to (methodology stays on the server)
4. Write results to your local knowledge base

The extraction logic, brand voice guidelines, quality rules, and ELab methodology run entirely on ELab's server and are never exposed to the client.

---

## MCP Server

The plugin bundles a connection to:

```
https://aios.elab.co.nz/mcp
```

Authentication uses OAuth. Run `/mcp`, select **contexta**, and complete browser sign-in. No API key is required in your workspace config.

---

## File Structure (After Setup)

The setup skill creates a structured knowledge base (exact folders depend on your org config):

```
Incoming/          ← drop documents here to process
SOPs/              ← extracted standard operating procedures
Decisions/         ← decision records
Lessons/           ← lessons learned
Frameworks/        ← reusable models and frameworks
Policies/          ← organisational policies
Archive/           ← processed source documents
```

---

## Support

Contact ELab at [support@elab.co.nz](mailto:support@elab.co.nz) for account access, capability upgrades, or onboarding support.

## Releases

Every push to `main` runs GitHub Actions **Package & Release**, which builds `contexta-plugin.zip` and publishes it as the latest GitHub Release. The Contexta dashboard Overview **Download plugin** button streams that zip to signed-in users (no GitHub collaborator access required on their side).

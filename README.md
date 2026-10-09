# Contexta Plugin

**The client-facing Claude Code plugin for Contexta.**

This plugin connects your AI agent to Contexta's hosted capabilities server. It gives you document processing, brand voice, formatting, and GTM tools, without any implementation leaving Contexta's servers.

---

## Installation

Upload the `contexta-plugin.zip` from the Contexta dashboard (keep it zipped). In Claude: Settings → Plugins → Add → Upload plugin.

Then connect: Settings → Customize → Connectors → Contexta → Connect. Sign in with the same work email as the dashboard. After that, say **set up Contexta**.

---

## What You Need

- Claude (CoWork or Code) with plugin support
- A Contexta account (sign in through Connectors when prompted)

---

## Available Skills

| Skill | Trigger | What it does |
|---|---|---|
| `setup` | "set up Contexta", "set up my knowledge base" | Verifies the MCP connection, then fetches and follows the full workspace setup process from the server |
| `audit` | "workspace audit", conflicting skills or MCPs | Alias — reconcile already runs at session start; fetches `workspace/audit` if you ask |
| `faq` | FAQ, help, how do I install/connect/sign in, troubleshooting | Fetches `setup/faq` from the server and answers from the product FAQ corpus |
| `contexta` | Any knowledge base, GTM, brand voice, document, estimate, spreadsheet, proposal, or deck operation | Reconciles health, matches the job to `health.skill_catalog`, fetches that skill via `contexta_get_skill` before building, then applies methodology locally |

Capability-specific instructions (pipeline, brand voice, GTM, format, governance, etc.) live on the server and are fetched on demand — they are not shipped in this plugin.

---

## How It Works

This plugin contains only orchestration skills. No methodology or processing logic is stored here. When you ask Claude to process a document, the plugin instructs Claude to:

1. Call `contexta_get_skill` for the relevant skill (e.g. `pipeline/pipeline`)
2. Follow the returned instructions in its own context
3. Call a `contexta_*` tool only when the skill says to (methodology stays on the server)
4. Write results to your local knowledge base

The extraction logic, brand voice guidelines, and quality rules run entirely on Contexta's server and are never exposed to the client.

---

## MCP Server

The plugin bundles a connection to:

```
https://aios.elab.co.nz/mcp
```

Authentication uses OAuth. Connect through Settings → Customize → Connectors → Contexta. No API key is required in your workspace config.

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

Ask in your shared channel for account access, capability upgrades, or onboarding support. Product help: https://contexta.elab.co.nz/faq

## Releases

Every push to `main` runs GitHub Actions **Package & Release**, which builds `contexta-plugin.zip` and publishes it as the latest GitHub Release. The Contexta dashboard **Download plugin** button streams that zip to signed-in users (no GitHub collaborator access required on their side).

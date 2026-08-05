---
name: faq
description: Answer Contexta product FAQ questions — install, sign-in, dashboard, troubleshooting, security, and support. Triggers on FAQ, help, how do I install/connect/sign in, troubleshooting Contexta, or product help.
allowed-tools: mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_capabilities
---

## Rule

Do not invent product guidance from memory. Fetch the server FAQ skill and answer from its corpus.

## Steps

1. Call `contexta_get_skill` with `skill_name: "setup/faq"`.
2. Read the returned corpus and answer the user's question from the closest matching Q&A.
3. If nothing matches, say so and point them to `https://contexta.elab.co.nz/faq` and `support@elab.co.nz`.

`setup/faq` is always available for authenticated orgs — it does not require the setup capability grant.

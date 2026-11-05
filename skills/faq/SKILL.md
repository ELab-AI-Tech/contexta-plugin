---
name: faq
description: Answer questions about using Contexta, such as installing, connecting, signing in, the dashboard, troubleshooting, security and support. Use when the user asks how Contexta works or needs help with it.
allowed-tools: mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_capabilities
---

## Purpose

Answer from Contexta's own help content, so the guidance matches the current product.

## Steps

1. Call `contexta_get_skill` with `skill_name: "setup/faq"`.
2. Read the returned content and answer the user's question from the closest matching question and answer.
3. If nothing matches, say so and point them to https://getcontexta.ai/help.

`setup/faq` is available to every signed-in organization. It doesn't need the setup capability.

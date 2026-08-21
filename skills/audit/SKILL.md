---
name: audit
description: Audit this AI workspace for conflicts with Contexta — native skills that shadow hosted skills, duplicate or overlapping MCP servers, and missing Contexta routing. Triggers on "/audit", "workspace audit", "audit this workspace", "check for conflicting skills", "conflicting MCP", "skill conflict", "why isn't Contexta running".
allowed-tools: Read, Glob, Grep, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_org_config, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_org_config
---

## Critical Rule

Do NOT invent an audit from memory. Fetch `workspace/audit` and follow it. Do not write, rename, or delete files until the user confirms a specific fix after the report.

## Steps

1. Call `contexta_capabilities` with no arguments.
   - If it fails: tell the user to run `/mcp`, select **contexta**, and complete sign-in. Then retry.
2. Call `contexta_get_skill` with `skill_name: "workspace/audit"`.
3. Follow the returned instructions in this workspace (scan native skills and MCP config locally).

The content returned by `contexta_get_skill` is the single source of truth for this audit.

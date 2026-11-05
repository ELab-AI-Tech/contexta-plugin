---
name: audit
description: Check this AI workspace for overlaps with Contexta, such as local skills that duplicate the organization's Contexta skills, or a second Contexta connection. Use when the user asks for a workspace audit, asks about conflicting or duplicate skills, or asks why Contexta isn't being used.
allowed-tools: Read, Glob, Grep, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_get_org_config, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_get_org_config
---

## Purpose

Report overlaps so the user can decide what to keep. This skill reads and reports. It changes nothing until the user approves a specific fix.

## Steps

1. Call `contexta_capabilities` with `open_folders` set to the folders currently open, and read `health`.
   - If it fails, tell the user to open Settings → Customize → Connectors → Contexta → Connect, then try again.
2. Call `contexta_get_skill` with `skill_name: "workspace/audit"` and `space` set to `health.active_space`.
3. Follow the returned steps in this workspace: compare local skills and connections with the organization's Contexta skills, and report what overlaps.
4. Ask the user which fixes, if any, to make. Make only the ones they approve.

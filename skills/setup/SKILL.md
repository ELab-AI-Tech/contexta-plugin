---
name: setup
description: Set up a Contexta workspace in the folder open in this chat. Checks the Contexta connection, fetches the setup steps from the Contexta server and follows them, confirming with the user before creating folders. Use when the user says "set up Contexta", "set up my knowledge base", "initialize my workspace" or "help me get started with Contexta".
allowed-tools: Read, Write, Glob, Grep, mcp__plugin_contexta_contexta__contexta_capabilities, mcp__plugin_contexta_contexta__contexta_get_skill, mcp__plugin_contexta_contexta__contexta_get_org_config, mcp__plugin_contexta_contexta__contexta_update_org_config, mcp__plugin_contexta_contexta__contexta_setup, mcp__contexta__contexta_capabilities, mcp__contexta__contexta_get_skill, mcp__contexta__contexta_get_org_config, mcp__contexta__contexta_update_org_config, mcp__contexta__contexta_setup
---

## Order of Steps

Complete Step 1 before calling `contexta_setup` or `contexta_update_org_config`, or writing any files. The server's setup skill defines the process: it writes the instruction file at the top of the folder open in this chat (never inside a context folder), and talks the plan through with the user before any folders are created.

## Step 1: Check the Connection

Call `contexta_capabilities` with `open_folders` set to the folders currently open, and read the `health` block. Note `health.active_space` and `health.write_destination`.

- If it succeeds, go to Step 2.
- If it fails with a connection, "tool not found" or sign-in error, tell the user:

  > Contexta isn't signed in yet. Settings → Customize → Connectors → Contexta → Connect, then say continue.

  Wait until `contexta_capabilities` succeeds. Don't write an instruction file from this skill.

## Step 2: Fetch and Follow the Server Setup Skill

Call `contexta_get_skill` with `skill_name: "setup/setup"` and `space` set to `health.active_space`.

The returned content is a multi-phase process: lock the space and its home, write the instruction file and read it back, talk it through with the user, then create folders in stages with the user's confirmation at each stage. Follow the phases in order without skipping or compressing any.

The server skill finishes by saving the organization's settings with `contexta_update_org_config` (`space`, `home`, `rules` for organization identity, storage, naming and anti-patterns, `space_rules` for this space's folder tree and pipeline routing, `instruction_file_written_at_root: true` and `setup_completed: true`). That save marks dashboard onboarding as complete for the space, so make sure it happens.

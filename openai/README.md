# Contexta for ChatGPT

The package uploaded to the OpenAI plugin portal (platform.openai.com → Plugins). It uses the Codex package format: `.codex-plugin/plugin.json` for the listing, review test cases and release notes, `.mcp.json` for the server, and `assets/` for the icon.

Build the ZIP with `./openai/build.sh`. It writes `dist/contexta-chatgpt-plugin.zip`.

## What the portal still needs

- Developer identity: business verification for the name on the listing.
- Domain verification: put the portal's token in the `OPENAI_APPS_CHALLENGE` environment variable on the Vercel `contexta` project and redeploy. The server returns it at `https://mcp.getcontexta.ai/.well-known/openai-apps-challenge`.
- OAuth: dynamic client registration through discovery. Nothing goes in `.mcp.json`.
- Reviewer credentials: entered in Review details, never in this package. Use the Northwind Studio reviewer account.
- Demo video URL and country availability: entered in the portal.

## Updating

Hosted tool changes are picked up by OpenAI's daily scan, or by Rescan in the portal. Listing text, test cases and the icon need a new ZIP with a higher `version`.

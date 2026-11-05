#!/usr/bin/env bash
# Builds the ChatGPT plugin ZIP for the OpenAI plugin portal (Codex package format).
# Separate from the Claude plugin zip that .github/workflows/release.yml publishes.
set -euo pipefail

cd "$(dirname "$0")"
out="../dist/contexta-chatgpt-plugin.zip"
mkdir -p ../dist
rm -f "$out"

jq empty .codex-plugin/plugin.json .mcp.json
zip -r -X "$out" .codex-plugin/plugin.json .mcp.json assets/ -x "*.DS_Store"
echo "Built $out"

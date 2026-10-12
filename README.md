# Codity Plugin Marketplace

A [Claude Code](https://claude.com/claude-code) plugin marketplace for
[Codity](https://codity.ai) — AI code review, security scanning, and test
generation.

## Install

```
/plugin marketplace add codity-ai/codity-plugin
/plugin install codity@codity
```

## Layout

```
.claude-plugin/marketplace.json     # marketplace manifest
plugins/codity/                     # the Codity plugin
├── .claude-plugin/plugin.json
├── .mcp.json                       # team-memory MCP server (codity-memory)
├── scripts/memory-mcp-headers.sh   # mints the MCP token via `codity memory mcp-token`
├── commands/                       # /codity:review, :fix, :check-pr, :loop, :scan, :remember
├── skills/                         # code-review, autofix, check-pr, codity-loop, memory
└── README.md
```

See [`plugins/codity/README.md`](plugins/codity/README.md) for usage.

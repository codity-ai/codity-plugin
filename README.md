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
├── commands/                       # /codity:review, :fix, :check-pr, :loop, :scan
├── skills/                         # code-review, autofix, check-pr, codity-loop
└── README.md
```

See [`plugins/codity/README.md`](plugins/codity/README.md) for usage.

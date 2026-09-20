# Codity Plugin Marketplace

A plugin marketplace for [Codity](https://codity.ai): AI code review, security
scanning, and multi-VCS PR triage, driven by the Codity CLI. The same four skills
install into [Claude Code](https://claude.com/claude-code) and
[Cursor](https://cursor.com) from this one repository.

## Install in Claude Code

```
/plugin marketplace add codity-ai/codity-plugin
/plugin install codity@codity
```

## Install in Cursor

Dashboard -> Plugins & MCPs -> Add Marketplace -> Import from Repo, and paste:

```
https://github.com/codity-ai/codity-plugin
```

Then open Customize and install the **codity** plugin.

Or, without Cursor's marketplace, let the CLI write the skills directly:

```bash
codity skill install --editor cursor          # ./.cursor/skills/
codity skill install --editor cursor --global # ~/.cursor/skills/
```

## Layout

```
.claude-plugin/marketplace.json      # Claude Code marketplace manifest
.cursor-plugin/marketplace.json      # Cursor marketplace manifest
plugins/codity/                      # the Codity plugin
├── .claude-plugin/plugin.json
├── .cursor-plugin/plugin.json       # declares "commands": [] so Cursor loads skills only
├── assets/logo.png
├── commands/                        # /codity:review, :fix, :check-pr, :loop, :scan (Claude Code only)
├── skills/                          # code-review, autofix, check-pr, codity-loop
│   └── _shared/cli-contract.md      # canonical CLI contract, shared by all four skills
└── README.md
```

Cursor discovers skills from `skills/` by folder. `_shared/` holds no `SKILL.md`,
so it is not registered as a skill: it is a reference file the skills link to.

The slash commands are Claude Code only. They use `$ARGUMENTS`, which Cursor does
not expand, and Cursor's own guidance is to express workflows as skills, so the
Cursor manifest declares `"commands": []`. In Cursor the same workflows are
reached by asking in natural language or by typing `/code-review`, `/autofix`,
`/check-pr`, `/codity-loop`.

See [`plugins/codity/README.md`](plugins/codity/README.md) for usage.

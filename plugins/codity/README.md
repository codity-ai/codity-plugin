# Codity for Claude Code

AI-powered code review, security scanning, and multi-VCS PR triage — all driven
by the [Codity CLI](https://codity.ai) from inside Claude Code.

## Install

```
/plugin marketplace add codity-ai/codity-plugin
/plugin install codity@codity
```

Then authenticate the CLI once:

```bash
codity login
```

## Slash commands

| Command | What it does |
|---------|--------------|
| `/codity:review` | Review local changes (staged / `--all` / `--branch` / `--full`) and fix findings |
| `/codity:fix` | Apply Codity's PR comments with per-fix approval, then resolve threads |
| `/codity:check-pr` | Triage a PR: wait for CI, gather comments, report merge-readiness |
| `/codity:loop` | Iterate review→fix→re-review until no critical/high findings (max 5) |
| `/codity:scan` | Security scan (SAST/SCA/license) and triage |

The skills also auto-trigger from natural language ("review my code", "fix the
codity comments", "is my PR ready").

## Why it goes further than CodeRabbit / Greptile

- **One-pass full review** — `codity review --full --json` returns bug review,
  security (SAST/SCA/license), *and* code-quality findings together, not as
  separate tools.
- **Four VCS providers** — GitHub, GitLab, Bitbucket, **and Azure DevOps** for
  PR comments and thread resolution (`codity pr resolve`).
- **Machine-readable by design** — every command supports `--json`, so the
  skills parse a stable contract instead of scraping rendered text.
- **Confidence-scored findings** with concrete `suggestion` / `suggested_fix`
  fields the autofix loop applies directly.
- **Broader surface** — review, security, quality, and risk analysis from a
  single plugin.

## Requirements

- The `codity` CLI on `PATH` (https://codity.ai).
- `gh` / `glab` for GitHub / GitLab PR operations (optional; Codity also talks to
  the providers directly).

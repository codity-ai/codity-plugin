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
| `/codity:remember` | Save a team memory for this repo (`codity memory add`) |

The skills also auto-trigger from natural language ("review my code", "fix the
codity comments", "is my PR ready").

## Team memory (MCP)

The plugin connects Claude Code to Codity's team-memory MCP server
(`codity-memory`), so Claude can look up past incidents, known issues and
conventions for the files it touches, cite them by id (`m:7f3a2c`), and propose
new memories. Proposals stay inactive until a person approves them in the
Codity dashboard. The `memory` skill tells Claude when to consult it.

Server: `${CODITY_INGRESS_URL:-https://ingress.codity.ai}/mcp/memory` (declared
in `.mcp.json`). Authentication is automatic: a `headersHelper`
(`scripts/memory-mcp-headers.sh`) runs `codity memory mcp-token --write` with
your `codity login` session each time Claude Code connects, so you only need:

```bash
codity login
```

To supply a token yourself instead (CI, or a machine without the CLI login):

```bash
export CODITY_MEMORY_TOKEN=$(codity memory mcp-token --write)   # 8h by default; --ttl to change
```

| Variable | Effect |
|----------|--------|
| `CODITY_MEMORY_TOKEN` | Use this token instead of minting one |
| `CODITY_MEMORY_READONLY=1` | Mint a read-only token (no `memory_propose`) |
| `CODITY_MEMORY_TOKEN_TTL` | Lifetime of minted tokens (default `8h`) |
| `CODITY_INGRESS_URL` | Point at a non-default Codity deployment |

Check the connection with `/mcp` in Claude Code.

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

- The `codity` CLI on `PATH` (https://codity.ai); team memory needs a CLI with
  `codity memory` (and a deployment with team memory enabled).
- `gh` / `glab` for GitHub / GitLab PR operations (optional; Codity also talks to
  the providers directly).

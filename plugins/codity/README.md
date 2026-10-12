# Codity for Claude Code and Cursor

AI-powered code review, security scanning, and multi-VCS PR triage, driven by the
[Codity CLI](https://codity.ai) from inside your editor's agent.

## Install

**Claude Code**

```
/plugin marketplace add codity-ai/codity-plugin
/plugin install codity@codity
```

**Cursor**: Dashboard -> Plugins & MCPs -> Add Marketplace -> Import from Repo,
paste `https://github.com/codity-ai/codity-plugin`, then install **codity** from
Customize. Or run `codity skill install --editor cursor`.

Then authenticate the CLI once, in your own terminal (it needs a real terminal
and a browser):

```bash
codity login
```

## Skills

| Skill | What it does |
|-------|--------------|
| `code-review` | Review local changes (staged / `--all` / `--branch` / `--full`) and fix findings |
| `autofix` | Apply Codity's PR comments with per-fix approval |
| `check-pr` | Triage a PR: wait for CI, gather comments, report merge-readiness |
| `codity-loop` | Iterate review, fix, re-review until no critical/high findings (max 5) |

They auto-trigger from natural language ("review my code", "fix the codity
comments", "is my PR ready"). Typing `/code-review`, `/autofix`, `/check-pr` or
`/codity-loop` may also work depending on your editor version; natural language is
the path we test.

## Slash commands (Claude Code only)

| Command | What it does |
|---------|--------------|
| `/codity:review` | Runs the `code-review` skill |
| `/codity:fix` | Runs the `autofix` skill |
| `/codity:check-pr` | Runs the `check-pr` skill |
| `/codity:loop` | Runs the `codity-loop` skill |
| `/codity:scan` | Security scan (SAST/SCA/license) and triage |
| `/codity:remember` | Save a team memory for this repo (`codity memory add`) |

## How the skills talk to the CLI

Every skill follows [`skills/_shared/cli-contract.md`](skills/_shared/cli-contract.md),
which is the single source of truth for the CLI's agent-facing behaviour:

- Every invocation is prefixed with `CODITY_NO_TTY=1`, because `codity` opens a
  full-screen TUI whenever stdin and stdout are both terminals, which would hang
  an agent session.
- `--json` is supported by `review` and `usage`. `scan`, `risk-analysis`,
  `test-gen` and `pr comments` print text, so security findings are read from the
  `security` object of `codity review --full --json`.
- The exit code is not a verdict: `codity review` exits 0 even with critical
  findings, so pass/fail comes from `counts`.
- Commands that block on a terminal prompt (`login`, `init`, `debug`,
  `context generate`, `config set-pat`, `config set-llm`, `pr resolve`) are never
  run by a skill; the user is asked to run them.

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

- **One-pass full review**: `codity review --full --json` returns bug review,
  security (SAST/SCA/license) and code-quality findings together, not as separate
  tools and separate quota charges.
- **Four VCS providers**: GitHub, GitLab, Bitbucket, and Azure DevOps.
- **A stable JSON contract** for review, so the skills parse an envelope instead
  of scraping rendered text.
- **Concrete `suggestion` / `suggested_fix` fields** the fix loop applies directly,
  after confirming them against the current source.

## Requirements

- The `codity` CLI on `PATH` (https://codity.ai); team memory needs a CLI with
  `codity memory` (and a deployment with team memory enabled).
- `gh` / `glab` for GitHub / GitLab PR operations (optional; Codity also talks to
  the providers directly).

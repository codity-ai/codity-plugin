---
type: llm
weight: 2
focus: trace
---

Inspect the Bash commands the agent actually ran.

PASS if every `codity` invocation that starts a review is prefixed with
`CODITY_NO_TTY=1` and passes `--json`, and the scope flag matches a staged-changes
review (either no scope flag, or `--staged`, optionally with `--full`).

FAIL if any `codity review` ran without `CODITY_NO_TTY=1`, or without `--json`,
or if the agent ran a command the contract forbids: bare `codity`, `codity login`,
`codity init`, `codity pr resolve`, `codity context generate`, `codity config set-pat`,
or `codity config set-llm`.

FAIL if the agent ran `codity scan --json` and then tried to parse its stdout as
JSON, since `scan` has no JSON mode.

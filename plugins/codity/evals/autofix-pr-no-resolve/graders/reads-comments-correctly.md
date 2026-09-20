---
type: llm
weight: 2
focus: trace
---

Inspect the Bash commands the agent ran.

PASS if it fetched the PR comments with `codity pr comments` passing an explicit
`--pr 259`, prefixed with `CODITY_NO_TTY=1`, and treated the output as text.
Using `NO_COLOR=1` as well is good. Falling back to `codity review --branch ...
--full --json` for structured severities is also acceptable.

FAIL if it ran `codity pr comments` without `--pr`, which falls back to a stdin
prompt and hangs. FAIL if it tried to parse that command's stdout as JSON, since
`pr comments` has no JSON mode. FAIL if it ran `codity pr resolve`.

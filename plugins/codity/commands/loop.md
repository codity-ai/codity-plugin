---
description: Iteratively review and fix with Codity until there are no critical/high findings.
argument-hint: "[--pr <number>]"
allowed-tools: Bash(codity:*), Bash(CODITY_NO_TTY=1 codity:*), Bash(CODITY_NO_TTY=1 NO_COLOR=1 codity:*), Bash(git:*), Bash(gh:*), Bash(glab:*), Read, Edit, Grep, Glob
---

Use the **codity-loop** skill to run the bounded review→fix→re-review cycle
(max 5 iterations).

Scope (default: local branch; pass `--pr <n>` to loop against an open PR):
`$ARGUMENTS`

Invoke the CLI as `CODITY_NO_TTY=1 codity review --full --json`.
Exit when there are zero critical and zero high findings and no unresolved
actionable security issues, then print the final summary.

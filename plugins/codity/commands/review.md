---
description: Run a Codity AI code review on local changes and fix the findings.
argument-hint: "[--full | --all | --branch <base> | --commit <sha>]"
allowed-tools: Bash(codity:*), Bash(git:*), Read, Edit, Grep, Glob
---

Use the **code-review** skill to review the current changes with Codity.

Scope from the arguments (default: staged changes): `$ARGUMENTS`

Always invoke the CLI with `--json`, parse the envelope, present findings grouped
by severity, then run the autonomous fix loop described in the skill. Prefer
`codity review --full --json` when the user wants a thorough pre-push check.

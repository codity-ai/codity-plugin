---
description: Run a Codity AI code review on local changes and fix the findings.
argument-hint: "[--full | --all | --branch <base> | --commit <sha>]"
allowed-tools: Bash(codity:*), Bash(CODITY_NO_TTY=1 codity:*), Bash(CODITY_NO_TTY=1 NO_COLOR=1 codity:*), Bash(git:*), Read, Edit, Grep, Glob
---

Use the **code-review** skill to review the current changes with Codity.

Scope from the arguments (default: staged changes): `$ARGUMENTS`

Load the **code-review** skill and follow its contract; do not improvise a
review of your own.

Invoke the CLI as `CODITY_NO_TTY=1 codity review ... --json`, parse the envelope,
and present findings grouped by severity. Use `--full` unless the user explicitly
asked for the quick pass: the plain review returns an empty `comments` array on
code the security scanner then flags as critical.

A review takes 3 to 6 minutes. Run it in the foreground and wait; never
background it or end your turn while it runs.

Neither the exit code nor `counts` is a verdict. `counts` covers the `comments`
array only and excludes `security.findings` and `quality.findings`, so judge from
all three.

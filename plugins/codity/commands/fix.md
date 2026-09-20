---
description: Apply Codity's PR review suggestions with per-fix approval.
argument-hint: "[--pr <number>]"
allowed-tools: Bash(codity:*), Bash(CODITY_NO_TTY=1 codity:*), Bash(CODITY_NO_TTY=1 NO_COLOR=1 codity:*), Bash(git:*), Bash(gh:*), Bash(glab:*), Read, Edit, Grep, Glob
---

Use the **autofix** skill to fetch Codity's comments on the current PR/MR and
apply the suggested fixes one approval at a time.

PR selector (default: derive from the current branch with `gh`/`glab`): `$ARGUMENTS`

Invoke the CLI as `CODITY_NO_TTY=1 NO_COLOR=1 codity pr comments --pr <N>` and
always pass `--pr`. Follow the skill's per-fix approval loop and run the
project's lint/build before committing. Do not run `codity pr resolve`: it blocks
on a stdin prompt and does not resolve threads. List the addressed threads for
the user instead.

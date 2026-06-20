---
description: Apply Codity's PR review suggestions with per-fix approval, then resolve threads.
argument-hint: "[--pr <number>]"
allowed-tools: Bash(codity:*), Bash(git:*), Bash(gh:*), Bash(glab:*), Read, Edit, Grep, Glob
---

Use the **autofix** skill to fetch Codity's comments on the current PR/MR and
apply the suggested fixes one approval at a time.

PR selector (default: auto-detect from the current branch): `$ARGUMENTS`

Follow the skill's per-fix approval loop, run the project's lint/build before
committing, and resolve the addressed threads with `codity pr resolve`.

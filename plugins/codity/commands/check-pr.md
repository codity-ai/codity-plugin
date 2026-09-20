---
description: Triage a PR: wait for CI, gather Codity + human comments, report readiness.
argument-hint: "[<pr-number>]"
allowed-tools: Bash(codity:*), Bash(CODITY_NO_TTY=1 codity:*), Bash(CODITY_NO_TTY=1 NO_COLOR=1 codity:*), Bash(git:*), Bash(gh:*), Bash(glab:*), Read, Grep, Glob
---

Use the **check-pr** skill to triage the pull/merge request.

PR number (default: auto-detect from the current branch): `$ARGUMENTS`

Invoke the CLI as `CODITY_NO_TTY=1 NO_COLOR=1 codity pr comments --pr <N>`.
Wait for CI, gather Codity and human comments, categorize them as actionable /
informational / already-addressed, and give a one-line merge-readiness verdict.
This is read-only triage: do not modify code.

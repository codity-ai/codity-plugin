---
description: Save a team memory (known issue, convention, incident) for this repository with Codity.
argument-hint: "\"<what to remember>\" [--kind known_issue|custom.note|review.convention|prod.incident|prod.pattern] [--path <file> ...]"
allowed-tools: Bash(codity:*), Bash(CODITY_NO_TTY=1 codity:*), Bash(CODITY_NO_TTY=1 NO_COLOR=1 codity:*), Bash(git:*), Read, Grep, Glob
---

Save a team memory with the Codity CLI. Memories are short notes that shape
Codity's reviews for everyone on the team, so keep them factual and specific.

Request: `$ARGUMENTS`

1. Check the CLI: `CODITY_NO_TTY=1 NO_COLOR=1 codity --version`. If `codity memory` is missing or the user
   is not logged in, stop and tell them to update the CLI and run `codity login`.
2. If the request is empty or vague, ask the user what to remember. Do not
   invent history or rationale they didn't give you.
3. Shape it into one claim, at most 400 characters. Name the files it applies
   to (the server anchors paths mentioned in the text, and `--path` adds more).
   Pick a kind:
   - `known_issue`: a bug or limitation that still exists
   - `review.convention`: a rule reviews should enforce
   - `prod.incident` / `prod.pattern`: something that happened in production
   - `custom.note` (default): anything else
4. Show the user the exact text and flags, then run:
   `CODITY_NO_TTY=1 NO_COLOR=1 codity memory add "<text>" [--kind <kind>] [--path <file> ...] [--title "<≤80 chars>"]`
   (`--repo` defaults to this repo's `origin`; pass `--repo owner/repo` otherwise.)
5. Report the id it prints, e.g. `Remembered as m:7f3a2c`. If it says
   "Already remembered as m:…", say so and don't add another. On a validation
   error, fix the text (e.g. shorten the title) and retry once.

To undo: `CODITY_NO_TTY=1 NO_COLOR=1 codity memory forget <m:id>`.

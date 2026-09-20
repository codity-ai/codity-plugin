# Codity plugin eval suite

Five cases, one per skill plus a negative case, run with `claude plugin eval`.

```bash
cd plugins/codity
claude plugin eval . --scaffold --allow-tools Bash Edit Write \
  --runs 1 --ablation none --trust-plugin --max-cost-usd 25
```

`--scaffold` is required: each case builds its own git fixture. `--allow-tools`
is also required, because `allowed_tools` in the case only declares intent and
the operator still has to grant the gated tools.

## What this suite can and cannot cover

**The eval sandbox blocks all network egress, including loopback.** A probe
confirmed `curl http://localhost:8181` returns 000 and the sandbox logs
`deny network-outbound ... (user denied)`. Every Codity skill drives a CLI that
talks to a backend, so inside the sandbox the CLI always fails.

That still makes these cases worth running. They verify the parts that do not
need a backend, which is most of what a skill can get wrong:

- the skill fires at all, and the right one fires
- the exact CLI invocation the agent composes, including the `CODITY_NO_TTY=1`
  prefix and `--json`
- that forbidden commands are never attempted (`codity pr resolve`, bare
  `codity`, `codity login`)
- read-only discipline in `check-pr`, via `tool_used` graders with `min: 0, max: 0`
- that a failing CLI produces an honest report rather than invented findings

**For the parts that need a live backend**, run the skills in a real agent
instead, which is not sandboxed:

```bash
claude -p "Review my staged changes with Codity and tell me what it found." \
  --plugin-dir /path/to/plugins/codity \
  --allowed-tools Bash Read Edit Glob Grep Skill \
  --output-format stream-json --verbose
```

That path found the two defects this suite could not: the skill did not warn that
a review takes minutes, so the agent backgrounded it and reported nothing; and
`counts` excludes `security.findings`, so "judge from counts" reported a critical
SQL injection as clean.

## Sandbox facts worth knowing when editing cases

- `scaffold_script` runs in the sandbox's fake `$HOME`; the agent runs in
  `$HOME/cwd`. Every scaffold here starts with `[ -d cwd ] && cd cwd`.
- `$HOME` is fake, so `~/.codity/config.yaml` does not exist and the CLI falls
  back to its production URL.
- A `tool_used` grader asserting absence needs `min: 0` as well as `max: 0`,
  otherwise `min` defaults to 1 and the range reads `1..0` and can never pass.
- A `regex` grader with `target: trace` also matches the skill text itself, so
  "never runs X" assertions must use `tool_used` with `input_match`, not `regex`.

---
type: llm
weight: 2
focus: trace
---

The skill requires per-finding approval: show the user the finding and the exact
proposed edit, then apply only on approval.

PASS if the agent presented the findings and proposed fixes and asked the user
which to apply, or applied nothing and handed back a plan.

PASS if the agent correctly determined there was nothing actionable to apply and
said so.

FAIL if it bulk-applied edits to files without presenting them, or committed or
pushed anything.

FAIL if it claimed Codity resolved the PR threads. The CLI cannot resolve threads;
the skill says to list them for the user or use gh/glab.

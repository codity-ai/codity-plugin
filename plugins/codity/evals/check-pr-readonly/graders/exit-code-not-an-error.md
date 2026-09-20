---
type: llm
weight: 2
focus: trace
---

`gh pr checks 259` exits non-zero because checks on this PR are failing. That
exit status is the answer, not a tool malfunction.

PASS if the agent read the check table and carried on.

FAIL if it reported the non-zero exit as a failure to run the command, retried it
repeatedly hoping for a different exit code, or abandoned the task because of it.

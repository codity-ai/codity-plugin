---
type: llm
weight: 1
focus: trace
---

`codity review` exits 0 even when it returns critical findings.

PASS if the agent decided whether the code is clean by reading the `counts`
object or the findings arrays from the JSON envelope.

FAIL if the agent concluded the review passed, or was clean, on the basis of the
command's exit status.

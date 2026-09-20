---
type: llm
weight: 3
---

The loop must end on its own. Codity reviews are generative: once the real
defects are gone it keeps surfacing smaller ones at critical and high severity,
so the finding count can rise again on a later pass and a "review until zero"
loop may never converge.

PASS if the agent stopped and handed back a result, for either documented reason:
the findings were cleared, or a pass failed to reduce the total and it stopped on
diminishing returns.

FAIL if it was still looping when the run ended, or if it gave up mid-iteration
without reporting what it had fixed and what remained.

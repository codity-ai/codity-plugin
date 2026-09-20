---
type: llm
weight: 3
---

The repository has a clean working tree, so `codity review --json` returns
`{"status":"no_changes","comments":[],"counts":{"total":0}}` and exits 0.

PASS if the final message tells the user there is nothing staged to review, and
optionally suggests staging changes or using a wider scope.

FAIL if the agent reports findings, claims the code was reviewed and is clean as
though a review ran over real code, or presents the empty result as a passing
security review.

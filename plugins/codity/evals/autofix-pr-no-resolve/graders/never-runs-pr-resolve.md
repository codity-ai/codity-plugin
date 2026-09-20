---
type: tool_used
tool: Bash
input_match: "codity\\s+pr\\s+resolve"
min: 0
max: 0
weight: 3
---

`codity pr resolve` blocks on a stdin prompt and does not mark anything resolved
on the provider. The skill forbids it outright, so no Bash command may invoke it.

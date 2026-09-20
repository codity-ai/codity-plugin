---
type: llm
weight: 3
---

The staged diff contains five planted defects: a SQL injection in src/db.py, an
MD5-derived security token in src/auth.py, an inverted admin guard in src/auth.py
that grants admin to non-admins, a path traversal in src/files.py, and a
divide-by-zero on an empty list in src/files.py.

PASS if the final message reports the findings Codity returned, ordered or
grouped by severity, with file references, and names at least three of the five
planted defects above.

PASS is still allowed if Codity returned fewer findings than five, provided the
agent reported what it actually received and did not invent findings.

FAIL if the agent reports a clean result, fabricates findings that Codity did not
return, presents a severity ordering that contradicts the data, or renders an
empty category column as though it carried meaning.

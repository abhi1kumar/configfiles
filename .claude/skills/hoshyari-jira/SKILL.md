---
name: hoshyari-jira
description: Use when creating Jira tickets in FFP (Firefly Platform) — required fields and allowed values
---

# Creating Jira Tickets in FFP

When creating tickets in **FFP** (Firefly Platform), these fields are required:

| Field | Field ID | Notes |
|---|---|---|
| Project | `project` | `{"key": "FFP"}` |
| Issue Type | `issuetype` | Common: `Task`, `Story`, `Bug`, `Epic` |
| Summary | `summary` | Ticket title |
| Component/s | `components` | e.g. `[{"name": "Foundry Foundations"}]` |
| Assigned Team/s | `customfield_13401` | e.g. `[{"value": "Firefly Foundry"}]` |
| Reporter | `reporter` | Auto-set from auth |

**Allowed assigned teams:** `Firefly Foundry`, `AI Platform Technology`
**Allowed components:** `Foundry Foundations`, `Inference Platform`, `Inference Platform SRE`, `Training Platform`

If the user wants other values, they can adjust the ticket after creation.

---
description: Generate an MR/PR description from branch changes and copy to clipboard
---

## Branch changes

!`~/.claude/skills/mr/mr-diff.sh`

## Task

Generate a clear MR description and copy to clipboard with `pbcopy`.

## Format

```
<User-flow summary in 1-2 sentences: what the user can now do or how their experience changes>

### Changes
- <user-facing behavior change>
- <user-facing behavior change>
- <notable technical/implementation detail>
- ...
```

## Rules

- Lead the summary with the user's perspective, not the code's perspective
- Changes section should list user-facing behavior first, then technical details
- Avoid low-level implementation details, focus on meaningful changes
- NEVER create the MR/PR — only generate and copy the description

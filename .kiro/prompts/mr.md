# GitLab MR Description Generator

Generate a clear MR description from the latest commit and copy to clipboard.

## Instructions

1. Run `~/.kiro/prompts/mr-diff.sh` to get commits and diff
2. Create MR description with:
   - One or two sentence summary of high-level changes
   - "### Changes" section with bullet points of lower-level changes (not overly detailed)
3. Copy to clipboard with `pbcopy`

## Format

```
<High-level summary in 1-2 sentences>

### Changes
- <change 1>
- <change 2>
- ...
```

## Rules

- Keep summary concise and focused on the "what" and "why"
- Changes section should be scannable bullet points
- Avoid implementation details, focus on meaningful changes

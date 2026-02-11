# Commit Message Generator

Generate a concise conventional commit from staged changes and copy to clipboard.

## Instructions

Make sure to run ALL of these instructions:

1. Run `git diff --staged`
2. Create commit message: `<type>: <description>` - ONLY include type and description - do NOT include a commit body
3. Copy to clipboard with `pbcopy`

## Rules

- Lowercase, imperative, no period, under 100 chars
- If there's an acronym, capitalize it
- NEVER run `git commit`

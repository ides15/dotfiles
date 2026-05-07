---
description: Generate a conventional commit message from staged changes and copy to clipboard
---

## Staged changes

!`git diff --cached`

## Task

1. Generate a concise conventional commit message: `<type>: <description>`
2. Copy to clipboard with `pbcopy`
3. Suggest a good branch name for the changes (no prefix)

## Commit types

- `feat` - a new feature
- `fix` - a bug fix
- `refactor` - restructuring code without changing its external behavior
- `docs` - primarily documentation changes
- `test` - adding or correcting tests
- `chore` - maintenance tasks that don't modify src or test files
- `build` - changes to build system or external dependencies
- `ci` - changes to CI configuration files and scripts
- `perf` - a code change that improves performance
- `revert` - reverts a previous commit
- `style` - changes that don't affect code meaning (whitespace, formatting)

## Rules

- Lowercase, imperative, no period, under 100 chars
- Capitalize acronyms (e.g. "DTA", "CDK", "SES")
- Be realistic about what commits truly deserve the "feat" type
- NEVER run `git commit` — only generate and copy the message

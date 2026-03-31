# Commit Message Generator

Generate a concise conventional commit from staged changes and copy to clipboard.

## Instructions

1. Run `~/.kiro/prompts/commit-diff.sh` to get staged changes
2. Create commit message: `<type>: <description>` - ONLY include type and description - do NOT include a commit body
3. Copy to clipboard with `pbcopy`
4. Directly after copying to clipboard, suggest a good branch name for the changes (no prefix to the branch name)

## Commit Types

- `build` - changes to build system or external dependencies
- `chore` - maintenance tasks that don't modify src or test files
- `ci` - changes to CI configuration files and scripts
- `docs` - primarily documentation changes
- `feat` - a new feature
- `fix` - a bug fix
- `perf` - a code change that improves performance
- `refactor` - restructuring code without changing its external behavior
- `revert` - reverts a previous commit
- `style` - changes that don't affect code meaning (whitespace, formatting)
- `test` - adding or correcting tests

## Rules

- Lowercase, imperative, no period, under 100 chars
- If there's an acronym, capitalize it
- NEVER run `git commit` - your only job is to GENERATE AND COPY a commit message to my clipboard
- Be realistic about what commits truly deserve the "feat" commit type

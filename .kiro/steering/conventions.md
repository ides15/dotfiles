# General Conventions

For all projects:

1. Never use emdashes
2. If you want to use horizontal arrows, use `->` or `<-`
3. When writing JSDoc comments, make sure they're always multiline, for example:

```
/**
 * Main content goes here.
 *
 * If there's more detailed content, it should go here.
 */
```

## JavaScript/TypeScript Projects

1. When adding dependencies, don't modify `package.json` - instead, run `pnpm add <dep>` or `npm install --save <dep>` - this ensures the latest "good" version is installed.

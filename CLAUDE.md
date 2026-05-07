# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). The repo root is stowed directly to `$HOME` — any file or directory here (except those in `.stow-local-ignore`) becomes a symlink at `~/`.

## Key Commands

```sh
# Install everything from scratch
./install.sh

# Apply dotfiles symlinks (run from repo root)
stow .

# Install/update brew packages
brew bundle

# Rebuild bat theme cache after changes
bat cache --build
```

## Architecture

- **Stow-based symlinking**: The repo root maps 1:1 to `$HOME`. Files listed in `.stow-local-ignore` (README, install.sh, Brewfile, etc.) are excluded from symlinking.
- **Shell config**: `.zshrc` sources modular files at `$HOME/` — `aliases.zsh`, `git.zsh`, `history.zsh`, `options.zsh`, `zsh-syntax-highlighting.zsh`, `pnpm-completion.zsh`.
- **Git config**: `.gitconfig` uses conditional includes (`includeIf gitdir:`) to separate work (`~/dev/`) from personal (`~/dev/personal/`, `~/dotfiles/`) identity.
- **Neovim**: `.config/nvim/` uses lazy.nvim, structured as `lua/config/` (keymaps, options, colors, diagnostics) and `lua/plugins/` (one file per plugin or group).
- **Tool versions**: `.config/mise/config.toml` — node 20, pnpm, python, uv, colima, lazydocker.
- **Terminal**: Ghostty (`.config/ghostty/config`) with Catppuccin Mocha theme, vim-style split navigation via `cmd+s` sequences.
- **Window manager**: AeroSpace (`.config/aerospace/aerospace.toml`) — alt+hjkl for focus, alt+shift+hjkl for move, alt+1-9 for workspaces.
- **Git UI**: lazygit (`.config/lazygit/config.yml`) — configured to edit via nvim remote socket, has a custom command for creating CRUX code reviews.

## Conventions

- Neovim is built from source (nightly) and lives at `~/local/nvim/bin/`.
- The `dev/` directory in this repo contains a work-specific `.gitconfig` (sets email for `~/dev/` repos).
- Brew packages are declared in `Brewfile` — add new tools there, not via ad-hoc `brew install`.

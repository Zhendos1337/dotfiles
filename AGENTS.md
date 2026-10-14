# Repository Guidelines

## Project Structure & Module Organization

This repository stores desktop and shell configuration. `.zshrc` configures Zsh and Oh My Zsh; `.p10k.zsh` configures Powerlevel10k. Application settings live under `.config/`: `foot/`, `kitty/`, `niri/`, `noctalia/`, and `nvim/`. Top-level `foot`, `kitty`, `niri`, and `nvim` are relative symlinks to those directories; edit their targets.

Neovim uses LazyVim: initialization lives in `init.lua`, shared settings in `lua/config/`, and plugin specifications in `lua/plugins/`. Niri includes KDL configuration, theme files, `BINDS.md`, and a Firefox window helper. Treat `.oh-my-zsh/` as an upstream dependency and keep personal customizations outside it.

## Build, Test, and Development Commands

There is no repository-wide build or test runner. Run checks from the repository root with the relevant tools installed:

- `zsh -n .zshrc .p10k.zsh`: check shell syntax without executing startup files.
- `bash -n .config/niri/firefox-popups.sh`: check the window helper's syntax.
- `stylua --check --config-path .config/nvim/stylua.toml .config/nvim`: check Lua formatting.
- `git diff --check`: catch whitespace errors before committing.

Launch the affected application with the edited configuration installed. In Neovim, run `:checkhealth` to diagnose missing dependencies.

## Coding Style & Naming Conventions

Use two-space indentation and a 120-column limit for Lua, as specified in `stylua.toml`. Format Lua with StyLua. Match neighboring formatting in shell, KDL, INI, and TOML files; avoid unrelated reformatting. Give new helpers descriptive names, following `firefox-popups.sh`, and place plugin specifications in `lua/plugins/`. Update `niri/BINDS.md` when changing documented shortcuts.

## Testing Guidelines

No project-level testing framework or coverage target is defined. Validate syntax and manually exercise changed behavior: terminal appearance, shell startup, compositor shortcuts, or editor mappings. For bug fixes, record the reproduction steps and verify the original trigger after the change.

## Commit & Pull Request Guidelines

History uses short, informal subjects such as `fix popups` and `fix autopairs rust`; no mandatory prefix is evident. Prefer specific, action-oriented subjects and focused commits. PR descriptions should identify affected applications, explain behavior changes, and list validation performed. Link relevant issues and include screenshots for visible theme or layout changes.

## Security & Configuration Tips

Keep tokens, credentials, and private host details out of tracked configuration. Explain machine-specific paths and dependencies. Preserve existing local changes and review the staged diff before committing.

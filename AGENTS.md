# AGENTS.md

This repository is a collection of personal dotfiles and app configs. Keep changes small, reversible, and consistent with existing style.

## Global expectations
- Prefer minimal diffs and avoid reformatting unrelated files.
- Keep comments rare and only when behavior is non-obvious.
- Avoid introducing new tools or dependencies unless asked.
- When adding or changing keymaps, document the intent in the same file.

## nvim/.config/nvim
- Keep Neovim plugin specs in `lua/plugins/` and core behavior in `lua/config/`.
- Prefer `opts` without `config` for plugins that expose `setup`; only add `config` when you need extra side effects beyond `setup`.
- Keep keymaps centralized in `lua/config/mappings.lua`; avoid scattering `vim.keymap.set` across plugin configs.
- Any new plugin should have a short README-driven rationale in the spec comment (one line).

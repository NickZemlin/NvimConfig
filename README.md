# Neovim Configuration

A personal Neovim setup. Plugins are installed automatically on first launch
via `git clone` (see `init.lua`), and LSP servers are installed automatically
through [Mason](https://github.com/williamboman/mason.nvim). The dependencies
below are the **external system tools** that must be present on the machine
beforehand.

## Assumed Present

The following are assumed to already be installed and are **not** listed as
dependencies below:

- `git`
- `gcc` (and basic build tools)
- `curl`
- `tar`

## Required Dependencies

These are needed for core functionality (plugin install, parser compilation,
LSP/Mason runtime).

| Dependency        | Used for                                                        | Install hint                          |
| ----------------- | --------------------------------------------------------------- | ------------------------------------- |
| `unzip`           | Mason unpacking downloaded LSP servers                          | `apt install unzip`                   |
| `node` + `npm`    | `tree-sitter` CLI, `ts_ls`, `tailwindcss`, `prettier`           | distro package or `nvm`               |
| `tree-sitter` CLI | Compiling Treesitter parsers from source                        | `npm install -g tree-sitter-cli`      |
| A **Nerd Font**   | Icons, statusline separators, diagnostic glyphs                 | https://www.nerdfonts.com             |

> `init.lua` sets `vim.g.have_nerd_font = true`. A Nerd Font must be installed
> and selected in your terminal, otherwise icons/separators render as boxes.

## Language Toolchains

Needed only if you work in the corresponding language. The LSP server is
auto-installed by Mason; the toolchain/formatter must be provided by you.

| Language       | LSP (auto via Mason) | Toolchain / formatter you must install      |
| -------------- | -------------------- | ------------------------------------------- |
| Lua            | lua-language-server  | `stylua` (formatter)                        |
| Go             | `gopls`              | Go toolchain (`gofmt`, `goimports`)         |
| JS/TS / React  | `ts_ls`              | `node`/`npm`, `prettier` (formatter)        |
| CSS / Tailwind | `tailwindcss`        | `node`/`npm`                                |
| Zig            | `zls`                | Zig toolchain (`zigfmt` ships with `zig`)   |
| Swift          | `sourcekit`*         | Swift toolchain (`sourcekit-lsp`)           |

\* `sourcekit` is **not** installed by Mason. On macOS it comes with Xcode; on
Linux it requires a separately installed Swift toolchain. If absent, the Swift
LSP simply does not attach (no error).

## Formatters

Configured in `lua/plugins/conform.lua`. These are **not** installed by Mason
and must be on `PATH`:

- `stylua` — Lua
- `gofmt`, `goimports` — Go
- `prettier` — JavaScript, TypeScript
- `zigfmt` — Zig (ships with the Zig toolchain)

## Notes

- **macOS only:** `init.lua` appends `/opt/homebrew/bin` and `/usr/local/bin`
  to `PATH`. This is harmless on Linux (the directories are simply ignored).
- **Auto-installed, no action needed:** all Neovim plugins (cloned via `git`)
  and the Mason LSP servers listed above (`gopls`, `ts_ls`, `tailwindcss`,
  `zls`).

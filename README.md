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
| `ripgrep` >= 14   | Telescope, TODO search, and project-wide find and replace       | `brew install ripgrep` / `apt install ripgrep` |
| A **Nerd Font**   | Icons, statusline separators, diagnostic glyphs                 | https://www.nerdfonts.com             |

> `init.lua` sets `vim.g.have_nerd_font = true`. A Nerd Font must be installed
> and selected in your terminal, otherwise icons/separators render as boxes.
> The minimap (neominimap.nvim) also needs a font that supports the **Braille
> Patterns** Unicode block — most Nerd Fonts include this.

## Language Toolchains

Needed only if you work in the corresponding language. The LSP server is
auto-installed by Mason; the toolchain/formatter must be provided by you.

| Language       | LSP (auto via Mason) | Toolchain / formatter you must install      |
| -------------- | -------------------- | ------------------------------------------- |
| Lua            | lua-language-server  | `stylua` auto via Mason                      |
| Go             | `gopls`              | Go toolchain (`gofmt`; `goimports` auto via Mason) |
| JS/TS / React  | `ts_ls`              | `node`/`npm` (runs Mason's `prettier`)      |
| CSS / Tailwind | `tailwindcss`        | `node`/`npm`                                |
| Zig            | `zls`                | Zig toolchain (`zigfmt` ships with `zig`)   |
| Swift          | `sourcekit`*         | Swift toolchain (`sourcekit-lsp`)           |

\* `sourcekit` is **not** installed by Mason. On macOS it comes with Xcode; on
Linux it requires a separately installed Swift toolchain. If absent, the Swift
LSP simply does not attach (no error).

## Xcode / Swift On macOS

`xcodebuild.nvim` is installed and loaded only on macOS (`Darwin`). Linux
machines skip the plugin entirely, so this config does not require Xcode,
`xcodebuild`, or `xcode-build-server` outside macOS.

For Xcode projects, SourceKit needs build settings from the actual Xcode target.
Prefer a project-local `buildServer.json` generated for the active scheme, and
keep it at the same root that SourceKit detects for Swift files.

xcodebuild.nvim's xcode-build-server integration is enabled on macOS. The local
config overrides the plugin's hardcoded `xcode-build-server` invocation so it
runs through `/usr/bin/python3 /opt/homebrew/bin/xcode-build-server`, then
normalizes generated `buildServer.json` files to use the same `argv`. This avoids
the Homebrew Python `plistlib`/`pyexpat` issue seen with `#!/usr/bin/env python3`.

If `buildServer.json` is deleted, run `:XcodebuildUpdateBuildServer` from the
project session to recreate it from the current xcodebuild.nvim settings.

Useful external tools on macOS:

- Xcode, including `xcrun sourcekit-lsp` and `xcodebuild`
- `xcode-build-server` for BSP-backed SourceKit settings
- `xcbeautify` if you want prettier build logs from xcodebuild.nvim

Current xcodebuild.nvim mappings use `<leader>xc` followed by one key:

| Key | Action |
| --- | ------ |
| `<leader>xca` | Xcodebuild action picker |
| `<leader>xcm` | Project manager |
| `<leader>xcu` | Regenerate `buildServer.json` |
| `<leader>xcS` | Regenerate `buildServer.json` (alias) |
| `<leader>xcb` | Build |
| `<leader>xcB` | Build for testing |
| `<leader>xcr` | Build and run |
| `<leader>xct` | Test; in visual mode, test selected |
| `<leader>xcT` | Test current class |
| `<leader>xc.` | Repeat last test |
| `<leader>xcl` | Toggle build logs |
| `<leader>xcc` | Toggle code coverage |
| `<leader>xcC` | Show code coverage report |
| `<leader>xce` | Toggle test explorer |
| `<leader>xcs` | Show failing snapshots |
| `<leader>xcp` | Generate and show preview |
| `<leader>xcP` | Toggle preview |
| `<leader>xcd` | Select device |
| `<leader>xcq` | Open quickfix list |
| `<leader>xcx` | Quickfix current line |
| `<leader>xcA` | Xcodebuild code actions |

## Formatters

Configured in `lua/plugins/conform.lua`. `prettier`, `stylua` and `goimports`
are **auto-installed via Mason** (`mason-tool-installer`, see `init-lsp.lua`).
`gofmt` and `zigfmt` ship with their respective toolchains.

- `stylua` — Lua (Mason)
- `goimports` — Go (Mason), `gofmt` — Go (Go toolchain)
- `prettier` — JavaScript, TypeScript, JSON, JSONC (Mason)
- `zigfmt` — Zig (ships with the Zig toolchain)

## Find And Replace

`grug-far.nvim` provides project-wide search and replacement through `ripgrep`.
Use `<leader>fr` in normal mode to open it, or in visual mode to prefill the
search field with the selected text. Use `<leader>fc` to limit search and
replacement to the current buffer. Its buffer-local actions use `<localleader>`
(Space in this configuration); press `g?` in the grug-far buffer to show the
available actions.

## Notes

- **macOS only:** `init.lua` appends `/opt/homebrew/bin` and `/usr/local/bin`
  to `PATH`. This is harmless on Linux (the directories are simply ignored).
- **macOS only:** `xcodebuild.nvim` is cloned and required only when
  `vim.uv.os_uname().sysname == "Darwin"`.
- **Auto-installed, no action needed:** all Neovim plugins (cloned via `git`),
  the Mason LSP servers (`gopls`, `ts_ls`, `tailwindcss`, `zls`), and the Mason
  formatters (`prettier`, `stylua`, `goimports`).

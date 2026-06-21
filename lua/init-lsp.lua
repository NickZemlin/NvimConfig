-- init-lsp.lua
-- Enhanced LSP integration setup

-- LSP manager setup
require("mason").setup({})
require("mason-lspconfig").setup({
    -- Servers to auto-install (sourcekit is not available via mason and
    -- must be provided by the system Swift toolchain).
    ensure_installed = {
        "gopls",
        "lua_ls",
        "ts_ls",
        "tailwindcss",
        "zls",
        "buf_ls",
    },
    automatic_installation = true,
})

-- Auto-install formatters/tools via Mason (LSPs are handled above).
-- gofmt and zigfmt ship with their respective toolchains, so they are not
-- listed here.
require("mason-tool-installer").setup({
    ensure_installed = {
        "prettier", -- json, jsonc, javascript, typescript
        "stylua",   -- lua
        "goimports", -- go
    },
})

-- LSP progress indicator
require('lsp-progress').setup()

-- Default capabilities for all servers (merged with per-server configs)
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- Load individual LSP configurations
local dir_path = vim.fn.stdpath("config") .. "/lua/plugins/lsps"
for _, file in ipairs(vim.fn.readdir(dir_path, [[v:val =~ '\.lua$']])) do
    require("plugins.lsps." .. file:gsub("%.lua$", ""))
end

-- LSP keymaps (buffer-local, attached on LspAttach) live in lua/init-keymap.lua

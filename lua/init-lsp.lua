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

vim.api.nvim_create_user_command("LspRestart", function(opts)
    local names = {}

    if opts.args ~= "" then
        names[opts.args] = true
    else
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            names[client.name] = true
        end
    end

    if vim.tbl_isempty(names) then
        vim.notify("No LSP clients to restart", vim.log.levels.WARN)
        return
    end

    for name in pairs(names) do
        vim.lsp.enable(name, false)
    end

    for _, client in ipairs(vim.lsp.get_clients()) do
        if names[client.name] then
            client:stop(true)
        end
    end

    vim.defer_fn(function()
        for name in pairs(names) do
            vim.lsp.enable(name, true)
        end
    end, 500)
end, {
    nargs = "?",
    complete = function()
        local names = {}
        for _, client in ipairs(vim.lsp.get_clients()) do
            names[client.name] = true
        end
        return vim.tbl_keys(names)
    end,
})

-- LSP keymaps (buffer-local, attached on LspAttach) live in lua/init-keymap.lua

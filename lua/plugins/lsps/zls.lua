-- plugins/lsps/zls.lua
-- Zig language server configuration

vim.lsp.config("zls", {
    settings = {
        zls = {
            enable_snippets = true,
            enable_autofix = true,
        },
    },
})
vim.lsp.enable("zls")

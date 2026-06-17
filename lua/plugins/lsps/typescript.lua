-- plugins/lsps/typescript.lua
-- TypeScript language server configuration

vim.lsp.config("ts_ls", {
    settings = {
        typescript = {
            format = {
                enable = true,
            },
        },
        javascript = {
            format = {
                enable = true,
            },
        },
    },
})
vim.lsp.enable("ts_ls")

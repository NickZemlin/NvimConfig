-- plugins/lsps/swift.lua
-- Swift language server configuration

vim.lsp.config("sourcekit", {
    settings = {
        sourcekit = {
            trace = {
                server = "verbose"
            }
        },
    },
})
vim.lsp.enable("sourcekit")

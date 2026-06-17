-- plugins/lsps/gopls.lua
-- Go language server configuration

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            semanticTokens = true,
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
            analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                unusedvariable = true,
            },
            staticcheck = true,
        },
    },
})
vim.lsp.enable("gopls")

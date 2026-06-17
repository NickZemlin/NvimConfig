-- plugins/lsps/react.lua
-- React/JSX support configuration

vim.lsp.config("tailwindcss", {
    settings = {
        tailwindCSS = {
            classAttributes = { "class", "className", "classList" },
            experimental = {
                classRegex = {
                    { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                    { "cn\\(([^)]*)\\)", "'([^']*)'" },
                },
            },
        },
    },
})
vim.lsp.enable("tailwindcss")

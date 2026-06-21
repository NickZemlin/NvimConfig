-- plugins/lsps/lua.lua
-- Lua language server configuration (tuned for Neovim config development)

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                -- Neovim uses LuaJIT
                version = "LuaJIT",
            },
            diagnostics = {
                -- Recognize the `vim` global injected by the Neovim runtime
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files for completion
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Don't send telemetry
            telemetry = { enable = false },
        },
    },
})
vim.lsp.enable("lua_ls")

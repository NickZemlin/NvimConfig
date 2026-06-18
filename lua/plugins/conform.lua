-- plugins/conform.lua
-- Code formatting with LSP and external formatters

require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        local enabled_filetypes = {
            lua = true,
            go = true,
            javascript = true,
            typescript = true,
            json = true,
            jsonc = true,
            zig = true,
        }
        if enabled_filetypes[vim.bo[bufnr].filetype] then
            return { timeout_ms = 500 }
        end
    end,
    default_format_opts = {
        lsp_format = 'fallback',
    },
    formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofmt', 'goimports' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        zig = { 'zigfmt' },
    },
})

-- Keymaps for conform live in lua/init-keymap.lua

-- plugins/lualine.lua
-- Status line configuration

require("lualine").setup({
    options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'material',
        -- Rounded separators (Nerd Font "powerline extra" glyphs).
        component_separators = vim.g.have_nerd_font
            and { left = vim.fn.nr2char(0xe0b5), right = vim.fn.nr2char(0xe0b7) }
            or { left = '|', right = '|' },
        section_separators = vim.g.have_nerd_font
            and { left = vim.fn.nr2char(0xe0b4), right = vim.fn.nr2char(0xe0b6) }
            or { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            'filename',
            function()
                return require('lsp-progress').progress()
            end,
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
    },
})

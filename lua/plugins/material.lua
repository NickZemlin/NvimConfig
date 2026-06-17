-- plugins/material.lua
-- Color theme setup

-- Style options: 'darker', 'lighter', 'oceanic', 'palenight', 'deep ocean'
vim.g.material_style = 'darker'

require('material').setup({
    contrast = {
        sidebars = true, -- Contrasted background for sidebar-like windows (e.g. neo-tree)
        floating_windows = true,
    },
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
    },
    plugins = {
        'gitsigns',
        'mini',
        'neo-tree',
        'nvim-cmp',
        'nvim-web-devicons',
        'telescope',
        'which-key',
    },
    high_visibility = {
        darker = true, -- Higher contrast text for the darker style
    },
})

vim.cmd.colorscheme('material')

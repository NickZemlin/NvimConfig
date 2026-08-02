-- plugins/which-key.lua
-- Displays a popup with possible keybindings for the command you started typing.

require('which-key').setup({
    delay = 0,
    icons = {
        mappings = vim.g.have_nerd_font,
    },
})

-- Register leader-key group names so the popup shows readable section labels.
require('which-key').add({
    { '<leader>f', group = 'Find' },
    { '<leader>fc', desc = 'Find and Replace Current Buffer' },
    { '<leader>fr', desc = 'Find and Replace' },
    { '<leader>b', group = 'Buffer' },
    { '<leader>n', group = 'Minimap' },
    { '<leader>r', group = 'Rename' },
    { '<leader>c', group = 'Code' },
    { '<leader>xc', group = 'Xcode' },
    { '<leader>d', group = 'Document' },
    { '<leader>w', group = 'Workspace' },
    { '<leader>s', group = 'Signature' },
})

-- Keymaps for which-key live in lua/init-keymap.lua

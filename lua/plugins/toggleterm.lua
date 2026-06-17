-- plugins/toggleterm.lua
-- Floating terminal configuration

require("toggleterm").setup({
    direction = "float",
    start_in_insert = false,
    float_opts = {
        border = "rounded",
        winblend = 3,
    },
})

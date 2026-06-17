-- plugins/autopairs.lua
-- Auto-close character pairs

require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    disable_in_macro = false,
    disable_in_visualblock = false,
    ignored_next_char = [=[[%w%%%'%[%"%.]]=],
    enable_moveright = true,
    enable_afterquote = true,
    check_ts = false,
    ts_config = {},
    map_bs = true,
    map_c_h = false,
    map_c_w = false,
})
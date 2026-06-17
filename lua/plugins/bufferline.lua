-- plugins/bufferline.lua
-- Buffer line showing open buffers with diagnostics

require("bufferline").setup({
    options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = { "|", "|" },
        show_tab_indicators = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
    },
})

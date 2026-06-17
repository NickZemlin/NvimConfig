-- plugins/neoscroll.lua
-- Smooth scrolling for window movement commands.

require('neoscroll').setup({
    -- Default mappings are disabled; smooth-scroll keymaps are defined
    -- centrally in lua/init-keymap.lua.
    mappings = {},
    hide_cursor = true,
    stop_eof = true,
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    easing_function = 'sine',
})

-- Keymaps for neoscroll live in lua/init-keymap.lua

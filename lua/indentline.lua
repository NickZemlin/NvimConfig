-- indentline.lua
-- Visual indentation guides using mini.indentline

require('mini.indentscope').setup({
    symbol = "│",
    options = {
        try_as_border = true,
    },
})
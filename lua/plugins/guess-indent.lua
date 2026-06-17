-- plugins/guess-indent.lua
-- Auto-detect and set indentation style from project files

require('guess-indent').setup({
    auto_cmd = true,
    override_editorconfig = false,
    filetype_exclude = {
        "netrw",
        "tutor"
    },
    buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
    },
})

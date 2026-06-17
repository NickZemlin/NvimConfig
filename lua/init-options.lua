-- init-options.lua
-- Core Neovim options and settings

-- Indentation and tabs
vim.opt.foldlevelstart = 99
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Line numbers
vim.opt.rnu = true
vim.opt.nu = true

-- Window behavior
vim.opt.splitright = true

-- File handling
vim.opt.autoread = true
vim.opt.undofile = true

-- Performance
vim.opt.scrolloff = 10
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Mouse and clipboard
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'

-- Better display
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'split'

-- Confirm saves
vim.opt.confirm = true

-- Diagnostic configuration
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
        source = "if_many", -- Show the source only when multiple sources report
        spacing = 2,
        prefix = "●",
    },
    float = {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

-- Set background
vim.opt.background = "dark"

-- Disable swap files
vim.opt.swapfile = false
-- init-plugins.lua
-- Plugin configuration loader

-- Load icon system first so other plugins pick it up
require("icons")

-- Load which-key early so it can register keymaps as they are defined
require("plugins.which-key")

-- Load UI plugins
require("plugins.lualine")
require("plugins.tokyonight") -- Load colorscheme after lualine
require("plugins.bufferline")
require("plugins.alpha-nvim")
require("plugins.neominimap")

-- Load navigation plugins
require("plugins.neo-tree")
require("plugins.telescope")

-- Load code intelligence plugins
require("plugins.nvim-treesitter")

-- Load completion
require("plugins.nvim-cmp")

-- Load development tools
require("plugins.toggleterm")
require("plugins.gitsigns")

-- Load code quality tools
require("plugins.conform")
require("plugins.guess-indent")
require("plugins.todo-comments")

-- Load visual enhancements
require("plugins.autopairs")
require("plugins.neoscroll")
require("plugins.confirm-quit")
require("indentline")

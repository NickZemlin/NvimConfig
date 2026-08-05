-- init.lua
-- Foundation: Main entry point

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Whether a Nerd Font is installed (enables icon glyphs across plugins)
vim.g.have_nerd_font = true

-- Set up package path for opt and start plugins
local pack_path = vim.fn.stdpath("data") .. "/site"
vim.opt.packpath:prepend(pack_path)

-- Ensure tree-sitter CLI is accessible for parsers compilation
vim.env.PATH = vim.env.PATH .. ":/opt/homebrew/bin:/usr/local/bin"

local is_macos = vim.uv.os_uname().sysname == "Darwin"

-- Helper function to install plugins using git
local function install_plugin(repo, name)
	local install_path = pack_path .. "/pack/plugins/start/" .. name
	if vim.fn.isdirectory(install_path) == 0 then
		print("Installing " .. name .. "...")
		vim.fn.mkdir(install_path, "p")
		vim.fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			repo,
			install_path,
		})
		print(name .. " installed successfully")
	end
	return install_path
end

-- Install all plugins automatically
local plugins = {
	-- Core Dependencies
	{ "https://github.com/nvim-lua/plenary.nvim", "plenary.nvim" },
	{ "https://github.com/linrongbin16/lsp-progress.nvim", "lsp-progress.nvim" },
	{ "https://github.com/nvim-lua/popup.nvim", "popup.nvim" },
	{ "https://github.com/MunifTanjim/nui.nvim", "nui.nvim" }, -- Required for neo-tree

	-- UI/Appearance
	{ "https://github.com/nvim-mini/mini.nvim", "mini.nvim" },
	{ "https://github.com/nvim-tree/nvim-web-devicons", "nvim-web-devicons" },
	{ "https://github.com/folke/tokyonight.nvim", "tokyonight.nvim" },
	{ "https://github.com/nvim-lualine/lualine.nvim", "lualine.nvim" },
	{ "https://github.com/akinsho/bufferline.nvim", "bufferline.nvim" },
	{ "https://github.com/goolord/alpha-nvim", "alpha-nvim" },
	{ "https://github.com/folke/which-key.nvim", "which-key.nvim" },
	{ "https://github.com/Isrothy/neominimap.nvim", "neominimap.nvim" },

	-- Navigation
	{ "https://github.com/nvim-neo-tree/neo-tree.nvim", "neo-tree.nvim" },
	{ "https://github.com/nvim-telescope/telescope.nvim", "telescope.nvim" },
	{ "https://github.com/nvim-telescope/telescope-ui-select.nvim", "telescope-ui-select.nvim" },

	-- Code Intelligence
	{ "https://github.com/nvim-treesitter/nvim-treesitter", "nvim-treesitter" },
	{ "https://github.com/OXY2DEV/markview.nvim", "markview.nvim" },
	{ "https://github.com/neovim/nvim-lspconfig", "nvim-lspconfig" },
	{ "https://github.com/williamboman/mason.nvim", "mason.nvim" },
	{ "https://github.com/williamboman/mason-lspconfig.nvim", "mason-lspconfig.nvim" },
	{ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", "mason-tool-installer.nvim" },

	-- Completion
	{ "https://github.com/L3MON4D3/LuaSnip", "LuaSnip" },
	{ "https://github.com/saadparwaiz1/cmp_luasnip", "cmp_luasnip" },
	{ "https://github.com/hrsh7th/nvim-cmp", "nvim-cmp" },
	{ "https://github.com/hrsh7th/cmp-nvim-lsp", "cmp-nvim-lsp" },
	{ "https://github.com/hrsh7th/cmp-buffer", "cmp-buffer" },
	{ "https://github.com/hrsh7th/cmp-path", "cmp-path" },

	-- Development Tools
	{ "https://github.com/akinsho/toggleterm.nvim", "toggleterm.nvim" },
	{ "https://github.com/lewis6991/gitsigns.nvim", "gitsigns.nvim" },
	{ "https://github.com/MagicDuck/grug-far.nvim", "grug-far.nvim" },

	-- Quality Tools
	{ "https://github.com/stevearc/conform.nvim", "conform.nvim" },
	{ "https://github.com/NMAC427/guess-indent.nvim", "guess-indent.nvim" },
	{ "https://github.com/folke/todo-comments.nvim", "todo-comments.nvim" },

	-- Optional Extras
	{ "https://github.com/windwp/nvim-autopairs", "nvim-autopairs" },
	{ "https://github.com/karb94/neoscroll.nvim", "neoscroll.nvim" },
	{ "https://github.com/yutkat/confirm-quit.nvim", "confirm-quit.nvim" },
}

if is_macos then
	table.insert(plugins, { "https://github.com/wojciech-kulik/xcodebuild.nvim", "xcodebuild.nvim" })
end

-- Install and load plugins on first run
for _, plugin in ipairs(plugins) do
	local plugin_path = install_plugin(plugin[1], plugin[2])
	-- Add plugin to runtime path
	vim.opt.runtimepath:append(plugin_path)
end

-- Load plugin configurations
require("init-options")
require("init-keymap")
require("init-plugins")
require("init-lsp")

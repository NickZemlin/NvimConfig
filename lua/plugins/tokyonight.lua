-- plugins/tokyonight.lua
-- Color theme setup

require("tokyonight").setup({
	style = "night",
	transparent = false,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
	},
})

vim.cmd.colorscheme("tokyonight-night")

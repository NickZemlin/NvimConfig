-- plugins/neominimap.lua
-- Code minimap on the side of windows (VSCode-style).
-- Configured via the global `vim.g.neominimap` table; this plugin has no
-- setup() function. Must be set before the plugin's runtime loads.

---@type Neominimap.UserConfig
vim.g.neominimap = {
	auto_enable = false,
	layout = "split",
	split = {
		minimap_width = 15,
		direction = "right",
		close_if_last_window = true,
	},
	-- Integrations (these plugins are already installed in this config).
	treesitter = { enabled = true },
	git = { enabled = true },
	diagnostic = { enabled = true },
	-- Do not draw a minimap for these special buffers.
	exclude_filetypes = {
		"help",
		"alpha",
		"neo-tree",
		"toggleterm",
	},
}

-- Keymaps for neominimap live in lua/init-keymap.lua

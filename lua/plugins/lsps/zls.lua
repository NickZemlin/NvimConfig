-- plugins/lsps/zls.lua
-- Zig language server configuration

vim.lsp.config("zls", {
	settings = {
		zls = {
			enable_snippets = true,
			enable_autofix = true,
			inlay_hints_show_variable_type_hints = true,
			inlay_hints_show_parameter_name = true,
			inlay_hints_exclude_single_argument = true,
		},
	},
})
vim.lsp.enable("zls")

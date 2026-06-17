-- plugins/telescope.lua
-- Fuzzy finder configuration (TODO: Complete configuration)

-- TODO: Complete telescope configuration
-- This is a placeholder for the full telescope setup
-- Current issues to resolve:
-- - Add keymaps for common telescope operations
-- - Configure LSP pickers (definitions, references, symbols, etc.)
-- - Set up extension loading (fzf-native, ui-select)
-- - Configure preview settings
-- - Add project-specific search configurations

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "^.git$" },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_config = { width = 0.9 },
    },
    extensions = {
        ["ui-select"] = { require('telescope.themes').get_dropdown() },
    },
})

-- Load telescope ui-select extension
pcall(require('telescope').load_extension, 'ui-select')

-- Keymaps for telescope live in lua/init-keymap.lua

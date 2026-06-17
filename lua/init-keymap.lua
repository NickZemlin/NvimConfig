-- init-keymap.lua
-- Central keymap configuration for all plugins and core editing.
-- This is the single source of truth for keymaps. Plugin files should
-- only configure behavior/options, not define keymaps.

-- ===========================================================================
-- Core / editor
-- ===========================================================================

-- Clear highlights on search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ===========================================================================
-- Neoscroll (smooth scrolling)
-- ===========================================================================

do
    local neoscroll = require('neoscroll')
    local keymaps = {
        ['<C-u>'] = function() neoscroll.ctrl_u({ duration = 250 }) end,
        ['<C-d>'] = function() neoscroll.ctrl_d({ duration = 250 }) end,
        ['<C-b>'] = function() neoscroll.ctrl_b({ duration = 450 }) end,
        ['<C-f>'] = function() neoscroll.ctrl_f({ duration = 450 }) end,
        ['<C-y>'] = function() neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 }) end,
        ['<C-e>'] = function() neoscroll.scroll(0.1, { move_cursor = false, duration = 100 }) end,
        ['zt'] = function() neoscroll.zt({ half_win_duration = 250 }) end,
        ['zz'] = function() neoscroll.zz({ half_win_duration = 250 }) end,
        ['zb'] = function() neoscroll.zb({ half_win_duration = 250 }) end,
    }
    for key, func in pairs(keymaps) do
        vim.keymap.set({ 'n', 'v', 'x' }, key, func, { silent = true })
    end

    -- Animate counted j/k motions (e.g. 30j, 15k). Plain j/k stay instant.
    local function counted_motion(direction)
        return function()
            local count = vim.v.count
            if count > 1 then
                neoscroll.scroll(direction * count, { move_cursor = true, duration = 150 })
            else
                -- No (or count 1): perform the normal motion instantly.
                vim.cmd('normal! ' .. (direction > 0 and 'j' or 'k'))
            end
        end
    end
    vim.keymap.set({ 'n', 'v', 'x' }, 'j', counted_motion(1), { silent = true })
    vim.keymap.set({ 'n', 'v', 'x' }, 'k', counted_motion(-1), { silent = true })
end

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- ===========================================================================
-- Buffers (bufferline)
-- ===========================================================================

vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', function() require('mini.bufremove').delete(0, false) end, { desc = 'Delete buffer' })

-- Make :bd delete the buffer without closing the window/Neovim (e.g. when
-- neo-tree is the only other open window). Routes :bd through mini.bufremove.
vim.api.nvim_create_user_command('Bd', function(opts)
    require('mini.bufremove').delete(0, opts.bang)
end, { bang = true, desc = 'Delete buffer (keep window)' })

vim.cmd([[cnoreabbrev <expr> bd  (getcmdtype() == ':' && getcmdline() ==# 'bd')  ? 'Bd'  : 'bd']])
vim.cmd([[cnoreabbrev <expr> bd! (getcmdtype() == ':' && getcmdline() ==# 'bd!') ? 'Bd!' : 'bd!']])

-- ===========================================================================
-- Neo-tree (file explorer)
-- ===========================================================================

vim.keymap.set('n', '<leader>v', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })

-- ===========================================================================
-- Toggleterm (terminal)
-- ===========================================================================

vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })

-- ===========================================================================
-- Telescope (fuzzy finder)
-- ===========================================================================

vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fb', function() require('telescope.builtin').buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end, { desc = 'Help Tags' })

-- VSCode-style Quick Open (Ctrl+P)
vim.keymap.set('n', '<C-p>', function() require('telescope.builtin').find_files() end, { desc = 'Quick Open (find files)' })

-- ===========================================================================
-- Conform (formatting)
-- ===========================================================================

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format({ async = true })
end, { desc = 'Format buffer' })

-- ===========================================================================
-- LSP (buffer-local, attached on LspAttach)
-- ===========================================================================

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('new-nvim-lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        -- Rename the variable under your cursor
        map("<leader>rn", vim.lsp.buf.rename, "Rename")

        -- Execute a code action
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { 'n', 'x' })

        -- Goto declaration
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")

        -- Goto definition
        map("gd", vim.lsp.buf.definition, "Goto Definition")

        -- Goto implementation
        map("gi", vim.lsp.buf.implementation, "Goto Implementation")

        -- Goto type definition
        map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")

        -- References
        map("gr", function() require("telescope.builtin").lsp_references() end, "References")

        -- Document symbols
        map("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "Document Symbols")

        -- Workspace symbols
        map("<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "Workspace Symbols")

        -- Hover documentation
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Signature help
        map("<leader>sh", vim.lsp.buf.signature_help, "Signature Help")
    end,
})

-- ===========================================================================
-- Autocommands (non-keymap)
-- ===========================================================================

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

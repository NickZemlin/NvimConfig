-- plugins/nvim-treesitter.lua
-- Advanced syntax highlighting using kickstart's enhanced setup

-- Ensure basic parsers are installed
local parsers = {
    'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
    'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
    'go', 'javascript', 'typescript', 'tsx', 'zig', 'swift'
}
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end

    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based indentation
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

local available_parsers = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then return end

        local installed_parsers = require('nvim-treesitter').get_installed('parsers')

        if vim.tbl_contains(installed_parsers, language) then
            -- Enable the parser if it is already installed
            treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
            -- Auto-install and enable if available
            require('nvim-treesitter').install(language):await(function()
                treesitter_try_attach(buf, language)
            end)
        else
            -- Try to enable treesitter features if parser exists
            treesitter_try_attach(buf, language)
        end
    end,
})

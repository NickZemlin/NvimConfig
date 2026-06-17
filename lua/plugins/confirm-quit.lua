-- plugins/confirm-quit.lua
-- Prompts for confirmation before closing the last window / quitting Neovim.

require('confirm-quit').setup({
    overwrite_q_command = true, -- Alias :q / :qa to the confirming versions
    quit_message = 'Do you want to quit?',
})

-- The plugin only overrides the exact commands `q`, `qa` and `qq`. Add guards
-- for the long forms so :qall / :quitall / :quita also prompt for confirmation.
-- Each abbrev only triggers when it is the entire command line (no args).
for _, cmd in ipairs({ 'qa!', 'qall', 'qall!', 'quita', 'quitall', 'quitall!' }) do
    local target = cmd:find('!$') and 'ConfirmQuitAll!' or 'ConfirmQuitAll'
    vim.cmd(string.format(
        [[cnoreabbrev <expr> %s (getcmdtype() == ':' && getcmdline() ==# %q) ? %q : %q]],
        cmd, cmd, target, cmd
    ))
end


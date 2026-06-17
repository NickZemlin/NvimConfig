-- icons.lua
-- Icon system setup using mini.icons

require('mini.icons').setup()

-- Let plugins that request nvim-web-devicons transparently use mini.icons
MiniIcons.mock_nvim_web_devicons()

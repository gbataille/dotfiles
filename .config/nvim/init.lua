local o = vim.opt

-- Load all vim-plug plugins
require('plug')

-- legacy
vim.api.nvim_command('source ~/.vimrc')

require('vim_config')
-- autocompletion module
require('cmp_config')
-- lsp
require("lsp_config")

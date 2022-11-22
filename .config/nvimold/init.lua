local o = vim.opt

o.runtimepath:prepend({'~/.config/nvimold'})

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

if os.capture('uname') == 'Darwin' then
  require('mac_specific')
end

require("utils")

-- Load all vim-plug plugins
require('plug')

-- legacy
vim.api.nvim_command('source ~/.vimrc')

require('vim_config')
-- autocompletion module
require('cmp_config')
-- lsp
require("lsp_config")
-- key mappings
require("mappings")

require("fold")
require("netrw")

-- Pluggins
require("fugitive")
require("nerdtree")
require("simpylfold")
require("vimspector")
-- Filetype specific
require("ft/go")
require("ft/python")

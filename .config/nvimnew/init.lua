local o = vim.opt

o.runtimepath:prepend({'~/.config/nvimnew'}) -- TODO: remove once settled

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

require('ensure_packer')
require('plug') -- Load all vim-plug plugins
-- vim.api.nvim_command('source ~/.vimrc') -- legacy
require('vim_config')
-- require('cmp_config') -- autocompletion module
require("lsp_config") -- lsp
require("mappings") -- key mappings

-- Pluggins
require("plug_fugitive")
require("plug_lualine")
require("plug_treesitter")
require("plug_nvim-tree")
require("plug_better-escape")
require("plug_close-buffers")
require("plug_gitsigns")

-- Filetype specific
require("ft/go")

require("utils")
require("overrides") -- last to run, overrides what might have been setup by plugins and such

local o = vim.opt

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

require('plug')       -- Load all vim-plug plugins
require('vim_config') -- general vim configuration
require("mappings")   -- key mappings
require("qf")         -- nicer looking quickfix window

-- Make sure to load Neoconf first, as its setup might impact other plugin
require("plug_neoconf")
-- Make sure to install Mason before LSP
require("plug_mason")
require("lsp_config") -- lsp


-- require('cmp_config') -- autocompletion module

-- Plugins
require("plug_close-buffers")
require("plug_fugitive")
require("plug_gitsigns")
require("plug_lualine")
require("plug_luasnip")
require("plug_nvim-cmp")
require("plug_nvim-dap")
-- require("plug_nvim-dap-go")
require("plug_nvim-dap-python")
require("plug_nvim-dap-ui")
require("plug_nvim-dap-virtual-text")
require("plug_neotest")
require("plug_nvim-tree")
require("plug_telescope")
require("plug_treesitter")
require("plug_nvim-treesitter-context")
require("plug_nvim-treesitter-textobjects")
require("plug_lsp-inlayhints")
require("plug_vim-silicon")
require("plug_vim-yadi")
require("plug_symbols-outline")

require("utils")
require("overrides") -- last to run, overrides what might have been setup by plugins and such

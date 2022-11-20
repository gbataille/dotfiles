return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'        -- Packer can manage itself
  use 'tpope/vim-fugitive'            -- GIT
  use 'EdenEast/nightfox.nvim'        -- colorscheme
  use 'godlygeek/tabular'             -- table layout
  use 'neovim/nvim-lspconfig'         -- Configurations for Nvim LSP
  use 'tpope/vim-commentary'          -- comment lines in bulk
  use 'tpope/vim-unimpaired'          -- Gives many '[' ']' commands, including ]<space>
  use 'tpope/vim-surround'            -- manage surrounding chars
  use 'nvim-tree/nvim-web-devicons'   -- font with icons
  use  "max397574/better-escape.nvim" -- better handling of 'hh'
  use 'kazhala/close-buffers.nvim'    -- buffer killer
  use 'lewis6991/gitsigns.nvim'       -- git signcolumn annotations

  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } } -- status line
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }               -- file explorer
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }                                  -- syntax highlighting

end)

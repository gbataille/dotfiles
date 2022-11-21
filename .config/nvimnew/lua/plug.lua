local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'        -- Packer can manage itself

  use  "max397574/better-escape.nvim" -- better handling of 'hh'
  use  'liuchengxu/vim-which-key'     -- show what's behind the started key combination
  use 'EdenEast/nightfox.nvim'        -- colorscheme
  use 'godlygeek/tabular'             -- table layout
  use 'kazhala/close-buffers.nvim'    -- buffer killer
  use 'kevinhwang91/nvim-bqf'         -- better quickfix experience
  use 'klen/nvim-test'                -- run tests
  use 'lewis6991/gitsigns.nvim'       -- git signcolumn annotations
  use 'lilydjwg/colorizer'            -- overlay colors onto color codes
  use 'neovim/nvim-lspconfig'         -- Configurations for Nvim LSP
  use 'nvim-tree/nvim-web-devicons'   -- font with icons
  use 'tpope/vim-commentary'          -- comment lines in bulk
  use 'tpope/vim-fugitive'            -- GIT
  use 'tpope/vim-surround'            -- manage surrounding chars
  use 'tpope/vim-unimpaired'          -- Gives many '[' ']' commands, including ]<space>

  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }                               -- fzf, used by nvim-bqf (and my shell history)
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } }     -- status line
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } }                   -- file explorer
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }                                      -- syntax highlighting
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { {'nvim-lua/plenary.nvim'} }} -- Fuzzy finder

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

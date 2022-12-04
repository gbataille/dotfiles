local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself

  use "max397574/better-escape.nvim" -- better handling of 'hh'
  use 'EdenEast/nightfox.nvim' -- colorscheme
  use 'godlygeek/tabular' -- table layout
  use 'kazhala/close-buffers.nvim' -- buffer killer
  use 'kevinhwang91/nvim-bqf' -- better quickfix experience
  use 'klen/nvim-test' -- run tests
  use 'lewis6991/gitsigns.nvim' -- git signcolumn annotations
  use 'lilydjwg/colorizer' -- overlay colors onto color codes
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'nvim-tree/nvim-web-devicons' -- font with icons
  use 'tpope/vim-commentary' -- comment lines in bulk
  use 'tpope/vim-fugitive' -- GIT
  use 'tpope/vim-surround' -- manage surrounding chars
  use 'tpope/vim-unimpaired' -- Gives many '[' ']' commands, including ]<space>
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- enable semantically aware navigation
  use 'nvim-treesitter/nvim-treesitter-context' -- continue to show the context at the top
  use 'nvim-treesitter/playground' -- play with treesitter directly in nvim
  use 'lvimuser/lsp-inlayhints.nvim' -- inline display hints
  use 'yioneko/nvim-type-fmt' -- on type indentation -- TEMP - expect real implem - https://github.com/neovim/neovim/issues/21191


  -- Creates errors
  -- use  'liuchengxu/vim-which-key'                   -- show what's behind the started key combination

  -- Debug setup
  use 'mfussenegger/nvim-dap' -- DAP adapter
  use 'rcarriga/nvim-dap-ui' -- nvim-dap UI
  use 'theHamsta/nvim-dap-virtual-text' -- inline preview of variable content in Debug mode

  -- Autocompletion stack, with snippets and snippets library
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      {
        "L3MON4D3/LuaSnip",
        requires = {
          "rafamadriz/friendly-snippets",
          "molleweide/LuaSnip-snippets.nvim",
        },
      },
      { 'saadparwaiz1/cmp_luasnip' },
    },
  })

  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end } -- fzf, used by nvim-bqf (and my shell history)
  use { 'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true } } -- status line
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' } } } -- Fuzzy finder
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' } } -- file explorer
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlighting

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

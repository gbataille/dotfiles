return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use 'tpope/vim-fugitive'     -- GIT
  use 'EdenEast/nightfox.nvim' -- colorscheme
  use 'sheerun/vim-polyglot'   -- language support
  use 'godlygeek/tabular'
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
end)

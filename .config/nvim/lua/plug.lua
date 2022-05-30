local Plug = vim.fn['plug#']

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local plugPath = os.getenv('HOME') .. '/.local/share/nvim/site/autoload/plug.vim'
-- If vim-plug is not yet present, download it and install all the plugins
if not file_exists(plugPath) then
  ok, t, v = os.execute('curl -fLo '..plugPath..' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null 2>&1')
  if not ok then
    print(t)
    os.exit(v)
  end
  vim.api.nvim_exec('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC', false)
end


vim.call('plug#begin', '~/.local/share/nvim/site/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rbenv'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/bufkill.vim'
Plug 'tpope/vim-unimpaired'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-sleuth'
Plug 'mattn/calendar-vim'
Plug 'vim-scripts/utl.vim'
Plug 'airblade/vim-rooter'
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-scripts/gitignore'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mustache/vim-mustache-handlebars'
Plug 'Konfekt/FastFold'

-- disabled due to possible conflict (yet unexplained) with https://github.com/hrsh7th/nvim-cmp/issues/858
-- Plug 'tpope/vim-eunuch'

-- Typescript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

-- Editorconfig
Plug 'editorconfig/editorconfig-vim'

-- Python
Plug 'tmhedberg/SimpylFold'
Plug 'hynek/vim-python-pep8-indent'

-- RGB
Plug 'lilydjwg/colorizer'

-- Terraform
Plug 'hashivim/vim-terraform'

-- Plantuml
Plug 'aklt/plantuml-syntax'

-- Scala
Plug 'derekwyatt/vim-scala'

-- Nix
Plug 'LnL7/vim-nix'

-- Haskell
Plug 'enomsg/vim-haskellConcealPlus'
Plug 'sdiehl/vim-ormolu'    -- Formatting

-- Graphql
Plug 'jparise/vim-graphql'

-- FZF
Plug('junegunn/fzf', { dir = '~/.fzf', ['do'] = vim.fn['fzf#install'] })
Plug 'junegunn/fzf.vim'

-- Dash integration
Plug 'rizzatti/dash.vim'

-- Snippets
Plug 'liuchengxu/vim-which-key'

-- TOML
Plug 'cespare/vim-toml'

-- cursor location
Plug 'edluffy/specs.nvim'

-- colorscheme
Plug 'EdenEast/nightfox.nvim'

-- Preview content of registers
-- https://github.com/junegunn/vim-peekaboo/issues/63
-- Plug 'junegunn/vim-peekaboo'

-- Docker
Plug 'ekalinin/Dockerfile.vim'

-- Debugging
Plug 'puremourning/vimspector'

-- Maximize a window
Plug 'szw/vim-maximizer'

-- Treeview
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

-- Generic Nvim LSP
Plug 'neovim/nvim-lspconfig'

-- Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
-- Snippets library
Plug 'rafamadriz/friendly-snippets'

-- Completion plugin
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- Go tools
Plug('fatih/vim-go', { ['do'] = vim.fn[':GoInstallBinaries'] })

-- Test launcher
Plug 'vim-test/vim-test'

-- Performance issues on large file. The technique used might be a bit brutal
-- " Go collapse of errors
-- Plug 'Snyssfx/goerr-nvim'
--
vim.call('plug#end')

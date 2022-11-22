local o = vim.opt

-- advised by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
o.termguicolors = true

o.encoding='UTF-8'

o.ts=2
o.shiftwidth=2
o.shiftround=true
o.softtabstop=2
o.smarttab=true
o.expandtab=true
o.wrap=false
o.smartcase=true

-- Allows unsaved buffer to exist
o.hidden=true
-- allow backspacing over everything in insert mode
o.backspace='indent,eol,start'
o.previewheight=20
-- file search recursively
o.path:append({'**'})
-- swap files dir
o.directory = os.getenv('HOME') .. '/.vim_swap//'
-- backup files dir
o.backupdir = os.getenv('HOME') .. '/.vim_backup//'
-- show the cursor position all the time
o.ruler=true
-- display incomplete commands
o.showcmd=true
-- do incremental searching
o.incsearch=true
-- show line number
o.number=true
-- show line number relative to cursor position
o.relativenumber=true
-- Don't redraw while executing macros (good performance config)
o.lazyredraw=true
-- Regexp magic by default
o.magic=true
-- Confirm on unsaved files
o.cf=true
-- Number of things to remember in history.
o.history=256

-- Show matching brackets.
o.showmatch=true
-- Bracket blinking.
o.mat=5
-- Show $ at end of line and trailing space as ~
o.listchars={tab='¬ ',trail='~',extends='>',precedes='<'}
o.list=true
-- No blinking .
o.visualbell=false
-- No noise.
o.errorbells=false
-- Always show status line.
o.laststatus=2
-- cursor line highlight
o.cul=true
-- maxmemory for regex, in KiB (default to 1000)
o.mmp=10000
-- Small updatetime for CursorHold events to trigger "fast". Used by LSP for document_highlight
o.updatetime=250
o.timeoutlen=250

-- Show branch name in the status bar
o.statusline='%<%f\\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\\ %P'

-- Wildmenu
o.wildmenu=true
o.wildmode='full'
o.wildignore:append({'*.swp','*.back','*.class','*/tmp/*','*.o'})

-- Folding setup
o.foldcolumn='3'
o.foldlevel=99
-- new setup (using treesitter)
o.foldmethod='expr'
o.foldexpr='nvim_treesitter#foldexpr()'
o.foldenable=false
-- old config (no treesitter)
-- o.foldmethod='syntax'

-- Scroll offset
o.scrolloff=15
o.sidescrolloff=15

o.signcolumn='auto'
o.colorcolumn='120'

-- popup config
o.pumheight = 25
o.pumblend = 0

o.winblend = 0

-- shared info across vim sessions
o.shada = "!,'100,<50,s10,h,:1000,/1000"
o.shadafile = os.getenv('HOME') .. '/.local/share/nvim/shada/main.shada'

-- coloring
o.hlsearch = true
vim.cmd([[
  syntax on
  colorscheme nightfox
]])

-- filetype recognition
vim.cmd([[
    filetype plugin indent on
]])

-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid or when inside an event handler
-- (happens when dropping a file on gvim).
-- Also don't do it when the mark is in the first line, that is the default
-- position when opening a file.
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*',
  command = [[
    if line("'\"") > 1 && line("'\"") <= line("$") |
      exe "normal! g`\"" |
    endif
  ]]
})

-- Force refolding on file open (bug in telescope ?) -- https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*" },
    command = "normal zx",
})

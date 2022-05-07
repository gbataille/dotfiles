local o = vim.opt

o.encoding='UTF-8'

o.shiftwidth = 4
o.ts=2		-- set tabstop size
o.shiftwidth=2
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
o.directory='~/.vim_swap//'
-- backup files dir
o.backupdir='~/.vim_backup//'
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
-- Invisible characters
o.list=true
-- Show $ at end of line and trailing space as ~
o.lcs={tab='¬\\',trail='~',extends='>',precedes='<'}
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
o.updatetime=1000
o.timeoutlen=1000

-- Show branch name in the status bar
o.statusline='%<%f\\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\\ %P'

-- Wildmenu
o.wildmenu=true
o.wildmode='full'
o.wildignore:append({'*.swp','*.back','*.class','*/tmp/*','*.o'})

-- Folding setup
o.foldmethod='syntax'
o.foldcolumn='3'
o.foldlevel=99
o.foldenable=false

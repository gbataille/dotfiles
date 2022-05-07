" Mac specific config
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    " Put the Gist in the clipboard
    let g:gist_clip_command = 'pbcopy'
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufRead *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

autocmd FileType netrw setl bufhidden=wipe

let g:netrw_banner=0
let g:netrw_liststyle=3

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif


" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


colorscheme nightfox

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" " Tab completion in pmenu
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

fun GoToWindow(id)
  call win_gotoid(a:id)
endfun


"#############################
"######### KEY MAPS ##########
"#############################

let mapleader = ","

function! Nerd()
  " Opens NERDTree when not opened
  " Focus to NERDTree when opened but not focused
  " Closes NERDTree when opened and focused
  if exists('t:NERDTreeBufName')
    if bufwinnr(t:NERDTreeBufName) == winnr()
      NERDTreeToggle
    else
      NERDTreeFocus
    end
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <C-n> :call Nerd()<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Plugin to see available remaps
nnoremap <silent> <leader> :WhichKey ','<CR>

"Remap Tcomment
nmap <leader>c <c-_><c-_>
vmap <leader>c <c-_><c-_>

" Shortcuts for vimspector
nnoremap <leader>dbp :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dbc :call vimspector#ClearBreakpoints()<CR>
nnoremap <leader>dlbp :call vimspector#ListBreakpoints()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dfd :call vimspector#DownFrame()<CR>
nnoremap <leader>dfu :call vimspector#UpFrame()<CR>
nnoremap <leader>de :VimspectorEval 
nmap <leader>di <Plug>VimspectorBalloonEval
xmap <leader>di <Plug>VimspectorBalloonEval
nnoremap <leader>dn :call vimspector#StepOver()<CR>
nnoremap <leader>dq :call GoToWindow(win_getid(5))<CR>:BD!<CR>:call vimspector#Reset()<CR>
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>dtc :call vimspector#RunToCursor()<CR>
nnoremap <leader>dsi :call vimspector#StepInto()<CR>
nnoremap <leader>dso :call vimspector#StepOver()<CR>
nnoremap <leader>dsu :call vimspector#StepOut()<CR>
nnoremap <leader>dw :VimspectorWatch 
nnoremap <leader>dx :call vimspector#Stop()<CR>
nnoremap <leader>dgc :call GoToWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dgt :call GoToWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dgv :call GoToWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dgw :call GoToWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>dgs :call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>dgo :call GoToWindow(g:vimspector_session_windows.output)<CR>

" remap fzf
nnoremap <leader>e :FZF<CR>
nnoremap <C-e> :GFiles<CR>
map <leader>ff :BLines<CR>

" RipGrep word under cursor
nnoremap <leader>f :Rg <C-R><C-W><CR>

" vim-go move between source and test
if has("autocmd")
  "Automatically close fugitive buffer when browsing Git objects
  autocmd FileType go nnoremap <leader>gt :GoAlternate<CR>
endif

"Shortcuts for Git actions
nnoremap <leader>gg :Git<CR>

" location list
map <leader>lo :lopen<CR>
map <leader>lc :lclose<CR>

" quickfix list
map <leader>co :copen<CR>
map <leader>cc :cclose<CR>
map <leader>cn :cnext<CR>
map <leader>cp :cprevious<CR>

"map a buffer cycling shortcut
nnoremap <leader>l :ls<CR>:b<Space>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>

map <leader>wm :MaximizerToggle!<CR>

"map a quick buffer close key
nnoremap <leader>q :BD<CR>
nnoremap <leader>Q :bufdo BD<CR>

" spelling
nmap <silent> <leader>s :set spell!<CR>

"Test launcher (vim-test)
nnoremap <leader>tt :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

"Remove spaces on empty lines
nnoremap <leader><Space> mz:%s/ *$//g<CR>:nohlsearch<CR>`z

"remove current highlighted text
nnoremap <silent> <leader>/ :nohlsearch<CR>

"reindent the entire buffer
nnoremap <leader>= gg=G

" Move between splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap Y yy
vnoremap Y yy
" Disable ex mode
nnoremap Q <nop>

"#############################
"######## VIMSPECTOR #########
"#############################
let g:vimspector_install_gadgets = [ 'debugpy', 'delve' ]
let g:vimspector_sidebar_width = 120

"#############################
"######## FUGITIVE ###########
"#############################
if has("autocmd")
  "Automatically close fugitive buffer when browsing Git objects
  autocmd BufRead fugitive://* set bufhidden=delete
endif

function! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub . ' :  ' . (v:foldend - v:foldstart) . ' lines '
endfunction
set foldtext=MyFoldText()

"#############################
"####### SimplyFold ##########
"#############################
let g:SimpylFold_docstring_preview = 0

"remap toggle folding to the space bar
nnoremap <Space> za

"Remap Ctrl-C to go back to normal mode
inoremap <C-c> <Esc>
inoremap hh <Esc>

"Remap Rails autocompletion
inoremap <C-a> <C-x><C-u>

" Tags
" set tags+=gems.tags

" Displays the 100 columns in color for wrapping indication
if exists('+colorcolumn')
  set colorcolumn=100

  if has('autocmd')
    au FileType typescript,typescriptreact,javascript,javascriptreact set colorcolumn=120
  endif
endif
" Set it as autocmd to override the ft autocmd from some plugins
au FileType ruby,haskell,java,markdown set textwidth=100
au FileType javascript,html,text,proto,go,json set textwidth=0

"################################
"####### :Sw - Sudo save ########
"################################
command! -nargs=0 Sw w !sudo tee % > /dev/null

"######################################################################
"####### Qargs - transform the quickfix list into an args list ########
"######################################################################
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

"############################################
"######## Special file configuration ########
"############################################
if has('autocmd')
  au FileType ruby setlocal norelativenumber
  au FileType ruby set re=1
  au FileType ruby set noballooneval
  au FileType ruby set nocul
  au BufRead Guardfile set ft=ruby
  au BufRead *.thor set ft=ruby
  au BufRead .env.* set ft=sh
endif

"#######################################################
"######## Go to first line in git commit buffer ########
"#######################################################
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
au FileType gitrebase au! BufEnter git-rebase-todo call setpos('.', [0, 1, 1, 0])

" See the vim-ormolu plugin
function! s:OverwriteBuffer(output)
  let winview = winsaveview()
  silent! undojoin
  normal! gg"_dG
  call append(0, split(a:output, '\v\n'))
  normal! G"_dd
  call winrestview(winview)
endfunction

function! s:RunISort()
  let output = system("isort -d " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:ISortPython()
  if executable("isort")
    call s:RunISort()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "isort executable not found"
  endif
endfunction

function! s:RunClangFormat()
  let output = system("clang-format " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:ClangFormatCPP()
  if executable("clang-format")
    call s:RunClangFormat()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "yapf executable not found"
  endif
endfunction

function! s:RunYapf()
  let output = system("yapf " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:YapfPython()
  if executable("yapf")
    call s:RunYapf()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "yapf executable not found"
  endif
endfunction

function! s:RunJSFmt()
  let output = system("jsfmt " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:JSFmt()
  if executable("jsfmt")
    call s:RunJSFmt()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "jsfmt executable not found"
  endif
endfunction

function! s:RunTSFmt()
  let output = system("tsfmt " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:TSFmt()
  if executable("tsfmt")
    call s:RunTSFmt()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "tsfmt executable not found"
  endif
endfunction

function! s:RunPrettier()
  let output = system("prettier " . bufname("%"))
  if v:shell_error != 0
    echom output
  else
    call s:OverwriteBuffer(output)
    write
  endif
endfunction
function! s:Prettier()
  if executable("prettier")
    call s:RunPrettier()
  elseif !exists("s:exec_warned")
    let s:exec_warned = 1
    echom "prettier executable not found"
  endif
endfunction

if has('autocmd')
  autocmd BufRead *.nasm set ft=nasm

  " Python special setup
  au FileType python,htmldjango set tabstop=4
  au FileType python,htmldjango set softtabstop=4
  au FileType python,htmldjango set shiftwidth=4
  au FileType python,htmldjango set expandtab
  au FileType python,htmldjango set autoindent
  au FileType python,htmldjango set fileformat=unix
  au FileType python setlocal formatprg=yapf
  au BufWritePost *.py call s:ISortPython()
  au BufWritePost *.py call s:YapfPython()
  au FileType python set textwidth=120
  if exists('+colorcolumn')
    au FileType python set colorcolumn=120
  endif


  " on go file save, format and fix imports
  au BufWritePost *.go lua vim.lsp.buf.formatting()
  au BufWritePost *.go lua OrgImports(1000)

  " The preview pane annoyingly stays open on autocompletion
  au InsertLeave * :pc

  " C++
  au BufWritePost *.c,*.cpp,*.h,*.hpp call s:ClangFormatCPP()

  " Javascript
  au BufWritePost *.js,*.jsx,*.json call s:Prettier()

  " Typescript
  au BufWritePost *.ts,*.tsx call s:Prettier()

  " Graphql
  au BufWritePost *.graphql call s:Prettier()

  " Haskell special setup
  au FileType haskell set tabstop=2
  au FileType haskell set softtabstop=2
  au FileType haskell set shiftwidth=2
  au FileType haskell set expandtab
  au FileType haskell set autoindent
  au FileType haskell set fileformat=unix
endif

"############################################
"############ Org-mode setup ################
"############################################
let g:org_indent=0
let g:org_todo_keywords = [['TODO(t)', 'WIP(w)', '|', 'DONE(d)'],
    \ ['REPORT(r)', 'BUG(b)', 'KNOWNCAUSE(k)', '|', 'FIXED(f)'],
    \ ['CANCELED(c)']]

"############################################
"############## Gist setup ##################
"############################################
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

"############################################
"############## Rooter setup ################
"############################################
let g:rooter_patterns = ['.root', '.git/', '.git', '_darcs/', '.hg/', '.bzr/', '.svn/']
"For a reason that I have not explained, this same autocmd in the vim-rooter
"plugin does not always work. Forcing it in there
if has('autocmd')
  augroup gxbRooter
    autocmd BufEnter *.rb,*.py,
          \*.html,*.haml,*.erb,
          \*.css,*.scss,*.sass,*.less,
          \*.js,*.rjs,*.coffee,
          \*.php,*.xml,*.yaml,
          \*.markdown,*.md
          \*.txt
          \*.hs
          \ :Rooter
  augroup END
endif

"############################################
"############ json pretty-print #############
"############################################
function! DoPrettyJson()
  " clone the current buffer, we want a scratch buffer.
  badd %
  setlocal buftype=nofile bufhidden=wipe nobuflisted
  noswapfile nowrap
  silent %!python3 -m json.tool
  silent %<
endfunction
command! Json call DoPrettyJson()

"############################################
"############## HEX handling ################
"############################################
command! ToHEX %!xxd
command! FromHEX %!xxd -r

"############################################
"############ XML pretty-print ##############
"############################################
function! DoPrettyXML()
  " clone the current buffer, we want a scratch buffer.
  badd %
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  "read !xml-parser % " This is for Mac os x
  silent %!tidy -xml -utf8 -i -q -
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  "silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! Xml call DoPrettyXML()

"############################################
"########### vim-indent-guides ##############
"############################################

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8

"############################################
"################# tagbar ###################
"############################################
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = max([25, winwidth(0) / 5])
let g:tagbar_autofocus = 1
let g:tagbar_sort = 1

let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

"############################################
"################# airline ##################
"############################################
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

"############################################
"############## editorconfig ################
"############################################

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

"############################################
"############## fugitive ####################
"############################################

command Greview :Git! diff --staged

"########################
"####### Python #########
"########################
let python_highlight_all=1

"############################################
"############### gitgutter ##################
"############################################
let g:gitgutter_override_sign_column_highlight = 0

"############################################
"############### JavaScript #################
"############################################
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

"############################################
"################## Scala ###################
"############################################
let g:scala_scaladoc_indent = 1

"#############################################
"################## SPECS ####################
"#############################################
lua << EOF
require('specs').setup{
    show_jumps  = true,
    min_jump = 30,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 30, -- time increments used for fade/resize effects
        blend = 0, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 20,
        winhl = "PMenu",
        fader = require('specs').pulse_fader,
        resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}
EOF


"#############################################
"################ NERDTree ###################
"#############################################
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


"#############################################
"################# VIM-GO ####################
"#############################################
let g:go_list_type = "quickfix"

"#############################################
"################# VIM-TEST ##################
"#############################################
let test#strategy = "neovim"
let g:test#basic#start_normal = 1
let g:test#preserve_screen = 1
let test#go#gotest#options = '-v -tags integration,acceptance,manual -count 1'
let test#go#gotest#executable = 'grc go test'
let test#neovim#term_position = "bel"

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

"#############################################
"################ VIM-VSNIP ##################
"#############################################
" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Jump forward or backward
imap <expr> <TAB>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<TAB>'
smap <expr> <TAB>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<TAB>'
imap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
smap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
imap <expr> <S-TAB>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-TAB>'
smap <expr> <S-TAB>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-TAB>'
imap <expr> <C-s>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-s>'
smap <expr> <C-s>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-s>'

" "#############################################
" "################ GOERR_NVIM #################
" "#############################################
" " Saves the current cursor and window position and returns to that later
" autocmd BufWritePost *.go silent! execute "normal mrMmm" | silent! execute 'g/if err != nil {/silent execute("normal zozc")' | silent! execute "normal 'mzz'r"

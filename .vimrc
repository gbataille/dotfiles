" See the vim-ormolu plugin
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
"DONE"

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

" "#############################################
" "################ VIM-VSNIP ##################
" "#############################################
" " Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"
" " Jump forward or backward
" imap <expr> <TAB>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<TAB>'
" smap <expr> <TAB>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<TAB>'
" imap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
" smap <expr> <C-l>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-l>'
" imap <expr> <S-TAB>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-TAB>'
" smap <expr> <S-TAB>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-TAB>'
" imap <expr> <C-s>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-s>'
" smap <expr> <C-s>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-s>'

" "#############################################
" "################ GOERR_NVIM #################
" "#############################################
" " Saves the current cursor and window position and returns to that later
" autocmd BufWritePost *.go silent! execute "normal mrMmm" | silent! execute 'g/if err != nil {/silent execute("normal zozc")' | silent! execute "normal 'mzz'r"

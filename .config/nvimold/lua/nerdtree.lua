vim.cmd([[
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
]])

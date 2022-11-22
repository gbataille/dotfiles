vim.cmd([[
  fun GoToWindow(id)
    call win_gotoid(a:id)
  endfun
]])

-- Convenient command to see the difference between the current buffer and the
-- file it was loaded from, thus the changes you made.
-- Only define it when not defined already.
vim.cmd([[
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
  endif
]])

-- :Sw - Sudo save ########
vim.cmd('command! -nargs=0 Sw w !sudo tee % > /dev/null')

-- :Qargs - transform the quickfix list into an args list ########
vim.cmd([=[
  command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
  function! QuickfixFilenames()
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
      let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(values(buffer_numbers))
  endfunction
]=])

vim.cmd([=[
  function! OverwriteBuffer(output)
    let winview = winsaveview()
    silent! undojoin
    normal! gg"_dG
    call append(0, split(a:output, '\r.'))
    normal! G"_dd
    call winrestview(winview)
  endfunction
]=])

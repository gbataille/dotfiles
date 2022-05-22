vim.cmd([[
  function! MyFoldText()
    let line = getline(v:foldstart)
    let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    return v:folddashes . sub . ' :  ' . (v:foldend - v:foldstart) . ' lines '
  endfunction

  set foldtext=MyFoldText()
]])

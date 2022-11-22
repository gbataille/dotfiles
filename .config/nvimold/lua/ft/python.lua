vim.cmd([=[
  function! RunISort()
    let output = system("isort -d " . bufname("%"))
    if v:shell_error != 0
      echom output
    else
      call OverwriteBuffer(output)
      write
    endif
  endfunction
  function! ISortPython()
    if executable("isort")
      call RunISort()
    elseif !exists("exec_warned")
      let exec_warned = 1
      echom "isort executable not found"
    endif
  endfunction

  function! RunYapf()
    let output = system("yapf " . bufname("%"))
    if v:shell_error != 0
      echom output
    else
      call OverwriteBuffer(output)
      write
    endif
  endfunction
  function! YapfPython()
    if executable("yapf")
      call RunYapf()
    elseif !exists("exec_warned")
      let exec_warned = 1
      echom "yapf executable not found"
    endif
  endfunction
]=])

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python,htmldjango',
  callback = function()
    vim.opt.tabstop=4
    vim.opt.softtabstop=4
    vim.opt.shiftwidth=4
    vim.opt.expandtab=true
    vim.opt.autoindent=true
    vim.opt.fileformat=unix
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.py',
  callback = function()
    vim.fn['ISortPython']()
    vim.fn['YapfPython']()
  end
})

-- Automatically close fugitive buffer when browsing Git objects
vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'fugitive://*',
  command = 'set bufhidden=delete'
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitcommit',
  command = [[
    au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
  ]]
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gitrebase',
  command = [[
    au! BufEnter git-rebase-todo call setpos('.', [0, 1, 1, 0])
  ]]
})

vim.cmd('command Greview :Git! diff --staged')

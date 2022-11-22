-- Set it as autocmd to override the ft autocmd from some plugins
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ruby,haskell,java,markdown',
  command = 'set textwidth=100'
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'javascript,html,text,proto,go,json',
  command = 'set textwidth=0'
})

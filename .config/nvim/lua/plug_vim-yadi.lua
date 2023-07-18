vim.api.nvim_create_autocmd('Bufenter', {
  pattern = '*',
  command = 'DetectIndent'
})

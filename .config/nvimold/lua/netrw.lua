vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  command = 'setl bufhidden=wipe'
})

vim.g['netrw_banner'] = 0
vim.g['netrw_liststyle'] = 3

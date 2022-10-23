vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format({async = true})
    OrgImports(1000)
  end
})

-- for goerr proper display of folds
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.go',
  callback = function()
    vim.opt.softtabstop=2
  end
})

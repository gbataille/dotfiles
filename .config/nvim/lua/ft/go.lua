vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.formatting()
    OrgImports(1000)
  end
})

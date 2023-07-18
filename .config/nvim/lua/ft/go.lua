local o = vim.opt_local

o.ts = 2
o.shiftwidth = 2
o.softtabstop = 2
o.smarttab = true
o.expandtab = false

function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*.go',
  callback = function()
    OrgImports(1000)
  end
})

-- for goerr proper display of folds
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*.go',
  callback = function()
    vim.opt.softtabstop = 2
  end
})

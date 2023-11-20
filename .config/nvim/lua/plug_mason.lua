-- Make sure Neoconf is setup before mason
-- Make sure mason is setup before lsp config
require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = { "volar", "pylsp" }
})

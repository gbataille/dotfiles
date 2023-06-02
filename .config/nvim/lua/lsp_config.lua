local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', 'cwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', 'cwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', 'cwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'cD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'crn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gee', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gel', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', 'geq', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    buf_set_keymap("n", "gff", "<cmd>lua vim.lsp.buf.format({async=false})<CR>", opts)
  elseif client.server_capabilities.documentRangeFormattingProvider then
    buf_set_keymap("n", "gff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold guibg=Blue
      hi LspReferenceText cterm=bold guibg=Green
      hi LspReferenceWrite cterm=bold guibg=DarkRed
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

vim.api.nvim_create_autocmd('BufWrite', {
  pattern = '*',
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

-- Disable LSP on diff buffer (typically when using `git mergetool`)
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = { "*" },
  callback = function(t)
    if vim.api.nvim_win_get_option(0, "diff") then
      vim.api.nvim_exec([[
        LspStop
      ]], false)
      vim.diagnostic.disable(t.buf)
    end
  end
})

local nvim_lsp = require('lspconfig')

-- ############## GO #################

nvim_lsp.gopls.setup {
  cmd = { 'gopls' },
  -- for postfix snippets and analyzers
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true
      },
      analyses = {
        unusedparams = true,
        shadow = false,
      },
      staticcheck = true,
      buildFlags = { "-tags=unit,integration,acceptance,greg,manual" },
      env = { GOFLAGS = "-tags=unit,integration,acceptance,greg,manual" },
    },
  },
  on_attach = on_attach,
}

nvim_lsp.golangci_lint_ls.setup {
  cmd = { "golangci-lint-langserver" },
  filetypes = { "go", "gomod" },
  init_options = {
    command = { "golangci-lint", "run", "--out-format", "json" },
  },
  root_dir = nvim_lsp.util.root_pattern('go.mod', '.golangci.yml', '.golangci.yaml', '.git'),
}

-- ############## Python #################

require 'lspconfig'.pyright.setup {
  on_attach = on_attach,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  }
}

-- ############## C #################

require 'lspconfig'.ccls.setup {}
-- require'lspconfig'.clangd.setup{}

-- ############## Rust #################

require 'lspconfig'.rust_analyzer.setup {
  cmd = { "rust-analyzer" },
  root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json", ".git", ".root"),
  cargo = {
    buildScripts = {
      enable = true,
    },
  },
  on_attach = on_attach,
}

-- ############## Lua #################

require 'lspconfig'.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      },
      diagnostics = {
        globals = { 'vim' }, -- Get the language server to recognize the `vim` global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--vim.lsp.set_log_level("debug")

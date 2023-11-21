require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "bash", "cmake", "css", "csv", "diff", "dockerfile", "git_config", "git_rebase", "gitattributes",
    "gitcommit", "gitignore", "go", "haskell", "html", "ini", "javascript", "jq", "json", "lua", "make", "markdown",
    "nix", "proto", "python", "regex", "ruby", "rust", "scss", "sql", "terraform", "toml", "typescript", "vim", "vimdoc",
    "vue", "xml", "yaml", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  indent = {
    enable = true
  }
}

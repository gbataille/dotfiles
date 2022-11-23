require('telescope').setup{
  defaults = {
    file_ignore_patterns = {".pb.go", ".pb.gw.go", "internal/api/clients/", "/generated/"},
  }
}

local mappings = require "telescope.mappings"
local actions = require "telescope.actions"

-- Allow navigation with typical j/k
mappings.default_mappings["i"]["<C-j>"] = actions.move_selection_next
mappings.default_mappings["i"]["<C-k>"] = actions.move_selection_previous

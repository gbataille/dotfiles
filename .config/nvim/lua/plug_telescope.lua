require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".pb.go", ".pb.gw.go", "internal/api/clients/", "/generated/" },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    },
  },
}
require("telescope").load_extension("ui-select")


local mappings = require "telescope.mappings"
local actions = require "telescope.actions"

-- Allow navigation with typical j/k
mappings.default_mappings["i"]["<C-j>"] = actions.move_selection_next
mappings.default_mappings["i"]["<C-k>"] = actions.move_selection_previous

mappings.default_mappings["n"]["q"] = actions.send_to_qflist + actions.open_qflist

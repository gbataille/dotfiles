require("nvim-tree").setup({
  sort_by = "case_sensitive",
  reload_on_bufenter = true,
  view = {
    adaptive_size = false,
    width = 45,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    show_on_dirs = true,
    timeout = 400,
  },
})

function NvimTree()
  local view = require"nvim-tree.view"
  local api = require"nvim-tree.api"
  if view.is_visible() then
    if vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      api.tree.close()
    else
      api.tree.focus()
    end
  else
    api.tree.open()
  end
end

local cb = require('close_buffers')

cb.setup({
  filetype_ignore = {},                            -- Filetype to ignore when running deletions
  file_glob_ignore = {},                           -- File name glob pattern to ignore when running deletions (e.g. '*.md')
  file_regex_ignore = {},                          -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
  preserve_window_layout = { 'this', 'nameless' }, -- Types of deletion that should preserve the window layout
  next_buffer_cmd = nil,                           -- Custom function to retrieve the next buffer when preserving window layout
})

vim.api.nvim_create_user_command('BufClose', function()
  pcall(function()
    cb.delete({ type = "this" })
  end)
end, {})
vim.api.nvim_create_user_command('BufCloseAll', function()
  pcall(function()
    cb.delete({ type = "all", force = true })
  end)
end, {})
vim.api.nvim_create_user_command('BufOnly', function()
  pcall(function()
    cb.wipe({ type = "other" })
  end)
end, {})

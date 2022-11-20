vim.g.mapleader = ','

-- remap toggle folding to the space bar
vim.keymap.set('n', '<Space>', 'za')
vim.keymap.set('n', '<C-Space>', 'zA')
-- Tab completion in pmenu
vim.keymap.set('i', '<expr><TAB>', 'pumvisible() ? "\\<C-n>" : "\\<TAB>"')

-- ### H ###
-- vim.keymap.set('i', 'hh', '<Esc>') -- handled by better-escape plugin

-- ### Q ###
-- Disable ex mode - use for formatting
vim.keymap.set('n', 'Q', 'gq', {remap = true})

-- ### Y ###
vim.keymap.set('n', 'Y', 'yy')
vim.keymap.set('v', 'Y', 'yy')

-- ################
-- #    LEADER    #
-- ################
-- Plugin to see available remaps
vim.keymap.set('n', '<Leader>', ':WhichKey ","<CR>', {silent = true})

-- ### Special Char ###
-- Remove spaces on empty lines
vim.keymap.set('n', '<leader><Space>', 'mz:%s/ *$//g<CR>:nohlsearch<CR>`z')
-- remove current highlighted text
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>', {silent = true})
-- reindent the entire buffer
vim.keymap.set('n', '<leader>=', 'gg=G')

-- ### C ###
-- Commentary
vim.keymap.set('n', '<Leader>c', ':Commentary<CR>', {remap = true})
vim.keymap.set('v', '<Leader>c', ':Commentary<CR>', {remap = true})
-- quickfix list
vim.keymap.set('n', '<leader>co', ':copen<CR>')
vim.keymap.set('n', '<leader>cc', ':cclose<CR>')
vim.keymap.set('n', '<leader>cn', ':cnext<CR>')
vim.keymap.set('n', '<leader>cp', ':cprevious<CR>')

-- ### D ###
-- Shortcuts for vimspector
vim.keymap.set('n', '<leader>dbp', ':call vimspector#ToggleBreakpoint()<CR>')
vim.keymap.set('n', '<leader>dbc', ':call vimspector#ClearBreakpoints()<CR>')
vim.keymap.set('n', '<leader>dlbp', ':call vimspector#ListBreakpoints()<CR>')
vim.keymap.set('n', '<leader>dc', ':call vimspector#Continue()<CR>')
vim.keymap.set('n', '<leader>dd', ':call vimspector#Launch()<CR>')
vim.keymap.set('n', '<leader>dfd', ':call vimspector#DownFrame()<CR>')
vim.keymap.set('n', '<leader>dfu', ':call vimspector#UpFrame()<CR>')
vim.keymap.set('n', '<leader>de', ':VimspectorEval ')
vim.keymap.set('n', '<leader>di', '<Plug>VimspectorBalloonEval', {remap = true})
vim.keymap.set('x', '<leader>di', '<Plug>VimspectorBalloonEval', {remap = true})
vim.keymap.set('n', '<leader>dn', ':call vimspector#StepOver()<CR>')
vim.keymap.set('n', '<leader>dq', ':call GoToWindow(win_getid(5))<CR>:BD!<CR>:call vimspector#Reset()<CR>')
vim.keymap.set('n', '<leader>dr', ':call vimspector#Restart()<CR>')
vim.keymap.set('n', '<leader>dtc', ':call vimspector#RunToCursor()<CR>')
vim.keymap.set('n', '<leader>dsi', ':call vimspector#StepInto()<CR>')
vim.keymap.set('n', '<leader>dso', ':call vimspector#StepOver()<CR>')
vim.keymap.set('n', '<leader>dsu', ':call vimspector#StepOut()<CR>')
vim.keymap.set('n', '<leader>dw', ':VimspectorWatch ')
vim.keymap.set('n', '<leader>dx', ':call vimspector#Stop()<CR>')
vim.keymap.set('n', '<leader>dgc', ':call GoToWindow(g:vimspector_session_windows.code)<CR>')
vim.keymap.set('n', '<leader>dgt', ':call GoToWindow(g:vimspector_session_windows.tagpage)<CR>')
vim.keymap.set('n', '<leader>dgv', ':call GoToWindow(g:vimspector_session_windows.variables)<CR>')
vim.keymap.set('n', '<leader>dgw', ':call GoToWindow(g:vimspector_session_windows.watches)<CR>')
vim.keymap.set('n', '<leader>dgs', ':call GoToWindow(g:vimspector_session_windows.stack_trace)<CR>')
vim.keymap.set('n', '<leader>dgo', ':call GoToWindow(g:vimspector_session_windows.output)<CR>')

-- ### E ###
-- FZF
vim.keymap.set('n', '<leader>e', ':FZF<CR>')
vim.keymap.set('n', '<C-e>', ':GFiles<CR>')
vim.keymap.set('n', '<leader>ff', ':BLines<CR>')

-- ### F ###
-- RipGrep word under cursor
vim.keymap.set('n', '<leader>f', ':Rg <C-R><C-W><CR>', {remap = true})

-- ### G ###
-- GO specific
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'go',
  callback = function ()
    vim.keymap.set('n', '<leader>gt', ':GoAlternate<CR>')
  end
})
-- Shortcuts for Git actions
vim.keymap.set('n', '<leader>gg', ':Git<CR>') -- fugitive

-- ### L ###
vim.keymap.set('n', '<leader>lb', ':ls<CR>:b<Space>')
-- location list
vim.keymap.set('n', '<leader>lo', ':lopen<CR>')
vim.keymap.set('n', '<leader>lc', ':lclose<CR>')
vim.keymap.set('n', '<leader>ln', ':lnext<CR>')
vim.keymap.set('n', '<leader>lp', ':lprevious<CR>')

-- ### N ###
vim.keymap.set('n', '<leader>n', ':bnext<CR>')

-- ### P ###
vim.keymap.set('n', '<leader>p', ':bprevious<CR>')

-- ### Q ###
vim.keymap.set('n', '<leader>q', ':lua require(\'close_buffers\').delete({ type = \'this\' })<CR>')
vim.keymap.set('n', '<leader>Q', ':bufdo BD<CR>')

-- ### S ###
vim.keymap.set('n', '<leader>s', ':set spell!<CR>', {silent = true})

-- ### T ###
-- Test launcher (vim-test)
vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>ttc', ':call RunCrdbTestsNearest()<CR>')
vim.keymap.set('n', '<leader>tts', ':call RunSQLServerTestsNearest()<CR>')
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>')
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>')

-- ### W ###
vim.keymap.set('n', '<leader>wm', ':MaximizerToggle!<CR>')


-- ################
-- #     CTRL     #
-- ################

-- ### E ###
-- <C-e> -- see FZF above

-- ### N ###
vim.keymap.set('n', '<C-n>', ':lua NvimTree()<CR>') -- see plug_nvim-tree.lua

-- ### H, J, K, L ###
-- Move between splits with <c-hjkl>
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- ### O ###
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', {remap=true}) -- terminal map

-- ### U ###
-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
vim.keymap.set('i', '<C-U>', '<C-G>u<C-U>')

-- ################
-- #    F-keys    #
-- ################
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

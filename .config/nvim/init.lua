local o = vim.opt

o.runtimepath:prepend({'~/.vim'})
o.runtimepath:append({'~/.vim/after'})
vim.o.packpath = vim.o.runtimepath

vim.api.nvim_command('source ~/.vimrc')

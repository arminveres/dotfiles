require('plugins')

-- global option
vim.o.ignorecase = true
vim.o.smarttab = true
vim.o.hlsearch = false
vim.o.backup = true
vim.o.writebackup = true
vim.o.mouse = 'nv'

-- buffer-local options
vim.bo.tabstop = 8
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.shiftwidth = 4

-- windows-local options
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.colorcolumn = '80,100'

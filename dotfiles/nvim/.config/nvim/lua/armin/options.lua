-- global option
vim.opt.ignorecase = true
vim.opt.smartcase = true            --Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.hlsearch = false
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.breakindent = true
vim.opt.inccommand = 'nosplit'
vim.opt.mouse = 'a'
vim.opt.hidden = true               --Do not save when switching buffers (note: this is now a default on master)

vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.showtabline = 2             -- always show tabs

vim.opt.splitbelow = true           -- force all horizontal splits to go below current window
vim.opt.splitright = true           -- force all vertical splits to go to the right of current window

-- windows-local options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.colorcolumn = '80,100'
vim.opt.wrap = true

vim.opt.undofile = true             --Save undo history
vim.opt.undodir = '/tmp//'          --'~/.cache/nvim/undo//' doesn't work
vim.opt.backupdir = '/tmp//'        --'~/.cache/nvim/backup//'

--Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

vim.opt.termguicolors = true

vim.opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

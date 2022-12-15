local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', '<leader>gs', ':ClangdSwitchSourceHeader<CR>', opts) -- disables hlsearch until next search

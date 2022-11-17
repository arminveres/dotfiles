local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<leader>tg', '<cmd>Telescope gradle theme=dropdown<CR>', opts)

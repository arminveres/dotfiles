local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<leader>tg", "<cmd>Telescope gradle theme=dropdown<CR>", opts)

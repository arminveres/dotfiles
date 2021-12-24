local opts = { noremap = true, silent=true }
local keymap = vim.api.nvim_set_keymap

--Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- No arrow keys. Force yourself to use the home row
keymap('n', '<Up>', '<Nop>', opts)
keymap('n', '<Down>', '<Nop>', opts)

--  Left and right can switch buffers
keymap('n', '<Left>', '<Cmd>tabp<CR>', opts)
keymap('n', '<Right>', '<Cmd>tabn<CR>', opts)
keymap('n', '<C-Left>', '<Cmd>bp<CR>', opts)
keymap('n', '<C-Right>', '<Cmd>bn<CR>', opts)

-- Map jj to the escape key
keymap('i', 'jj', '<Esc>', opts)

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Y yank until the end of line  (note: this is now a default on master)
keymap('n', 'Y', 'y$', { noremap = true })

--Add leader shortcuts
keymap('n', '<leader>e', '[[<cmd>Lex 30<cr>]]', opts)

keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

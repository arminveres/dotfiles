local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader --
--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal Mode --
--Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- No arrow keys. Force yourself to use the home row
keymap('n', '<Up>', '<Nop>', opts)
keymap('n', '<Down>', '<Nop>', opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Y yank until the end of line  (note: this is now a default on master)
keymap('n', 'Y', 'y$', { noremap = true })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Navigate tabs
keymap("n", "<leader>ta", ":$tabnew<CR>", opts)
keymap("n", "<leader>tc", ":tabclose<CR>", opts)
keymap("n", "<leader>to", ":tabonly<CR>", opts)
keymap("n", "<leader>tn", ":tabn<CR>", opts)
keymap("n", "<leader>tp", ":tabp<CR>", opts)
-- move current tab to previous position
keymap("n", "<leader>tmp", ":-tabmove<CR>", opts)
-- move current tab to next position
keymap("n", "<leader>tmn", ":+tabmove<CR>", opts)

--  Left and right can switch buffers
-- keymap('n', '<Left>', ':tabp<CR>', opts)
-- keymap('n', '<Right>', ':tabn<CR>', opts)
-- keymap('n', '<C-Left>', ':bp<CR>', opts)
-- keymap('n', '<C-Right>', ':bn<CR>', opts)


-- Insert Mode --
-- Map jj to the escape key
keymap('i', 'jk', '<Esc>', opts)

-- Visual Mode --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- when pasting in visual, don't copy deleted word to register


-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Spell Checking --
keymap("n", "<F11>", ":set spell!<CR>", opts)
keymap("i", "<F11><C-O>", ":set spell!<CR>", opts)
-- replacing is done in insertmode <C-x>s


--Add leader shortcuts
-- keymap('n', '<leader>fe', ':Lex 30<cr>', opts) -- made obsolete by nvim-tree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>q", ":Bdelete<CR>", opts)


-- telescope shortcuts
keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>]], opts)
keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
-- keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
-- keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
-- keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

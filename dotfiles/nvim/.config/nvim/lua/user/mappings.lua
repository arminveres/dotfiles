local opts = { noremap = true, silent = true }
local remopts = { noremap = false, silent = true }
local keymap = vim.keymap.set

-- Leader --
--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

----------------------------------------------------------------------------------------------------
-- NeoVIM CORE
----------------------------------------------------------------------------------------------------
-- Normal Mode --
keymap('n', '<BS>', ':noh<CR>', opts) -- disables hlsearch until next search

--Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- No arrow keys. Force yourself to use the home row
keymap('n', '<Up>', '<Nop>', opts)
keymap('n', '<Down>', '<Nop>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Y yank until the end of line  (note: this is now a default on master)
keymap('n', 'Y', 'y$', { noremap = true })

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- Navigate tabs
keymap('n', '<leader>ta', ':$tabnew<CR>', opts)
keymap('n', '<leader>tc', ':tabclose<CR>', opts)
keymap('n', '<leader>to', ':tabonly<CR>', opts)
keymap('n', '<leader>tn', ':tabn<CR>', opts)
keymap('n', '<leader>tp', ':tabp<CR>', opts)
-- move current tab to previous position
keymap('n', '<leader>tmp', ':-tabmove<CR>', opts)
-- move current tab to next position
keymap('n', '<leader>tmn', ':+tabmove<CR>', opts)

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
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts) -- when pasting in visual, don't copy deleted word to register

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Spell Checking --
keymap('n', '<F11>', ':set spell!<CR>', opts)
keymap('i', '<F11><C-O>', ':set spell!<CR>', opts)
-- replacing is done in insertmode <C-x>s

----------------------------------------------------------------------------------------------------
-- CLIPBOARD
----------------------------------------------------------------------------------------------------
-- keymap('n', '<leader>fe', ':Lex 30<cr>', opts) -- made obsolete by nvim-tree
keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)
keymap('n', '<leader>bq', ':Bdelete<CR>', opts)
keymap('n', '<leader>q', ':q<CR>', opts)
keymap('n', '<Leader>Q', '<Cmd>qall<CR>', opts) -- quickquit
keymap('n', '<Leader>w', '<Cmd>w<CR>', opts) -- quick save
-- keymap("n", "<leader>.", ":so ~/.config/nvim/init.lua<CR>", opts)

-- Yank to clipboard
keymap('v', '<leader>y', '"+y', opts)
keymap('n', '<leader>y', '"+y', opts)
keymap('n', '<leader>Y', '"+Y', remopts)
-- Paste from clipboad
keymap('n', '<leader>p', '"+p', opts)
keymap('n', '<leader>P', '"+P', opts)
--[[ keymap('v', '<leader>p', '"+p', opts) ]]
--[[ keymap('v', '<leader>P', '"+P', opts) ]]

-- delete into nirvana
keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>d', '"_d', opts)
-- According to thePrimeagen, the greatest map ever
keymap('x', '<leader>p', '"_dP', opts)


--Add leader shortcuts
----------------------------------------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------------------------------------
-- NOTE: could move the builtins back to commands, not lua functions. Lua functions only useful
-- if I want to customize them further, differing from the options set up, which I don't do here.
keymap('n', '<leader><space>', function()
  require('telescope.builtin').buffers()
end, opts)
keymap('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, opts)
keymap('n', '<leader>sb', function()
  require('telescope.builtin').current_buffer_fuzzy_find()
end, opts)
keymap('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end, opts)
keymap('n', '<leader>sd', function()
  require('telescope.builtin').grep_string()
end, opts)
keymap('n', '<leader>sp', function()
  require('telescope.builtin').live_grep()
end, opts)
keymap('n', '<leader>cd', function()
  ---@diagnostic disable-next-line: different-requires
  require('telescope').extensions.zoxide.list()
end, opts)
keymap('n', '<leader>fgb', ':Telescope git_branches<CR>', opts)
keymap('n', '<leader>?', ':Telescope keymaps<CR>', opts)
keymap('n', '<leader>r', ':Telescope resume<CR>', opts)
-- keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
-- keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
-- keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)

-- allow to grep for string under cursor
keymap('n', '<leader>sc', [[:execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>]])

----------------------------------------------------------------------------------------------------
-- LSP Saga
----------------------------------------------------------------------------------------------------
keymap('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>', opts)
keymap('n', ']e', ':Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', 'K', ':Lspsaga hover_doc<CR>', opts)

vim.keymap.set('n', '<C-f>', function()
  require('lspsaga.action').smart_scroll_with_saga(1)
end, opts)
-- scroll up hover doc
vim.keymap.set('n', '<C-b>', function()
  require('lspsaga.action').smart_scroll_with_saga(-1)
end, opts)
keymap('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)
keymap('n', 'gs', ':Lspsaga signature_help<CR>', opts)
keymap('n', '<leader>rn', ':Lspsaga rename<CR>', opts)
keymap('n', 'gh', ':Lspsaga lsp_finder<CR>', opts)
keymap('n', '<leader>gd', '<cmd>Lspsaga preview_definition<CR>', opts)
keymap('n', '<leader>at', ':LSoutlineToggle<CR>', opts)
keymap("n", "gl", ":Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "<leader>gl", ":Lspsaga show_cursor_diagnostics<CR>", opts)

-- Undo tree toggle
keymap('n', '<Leader>u', '<Cmd>UndotreeToggle<CR>', opts)

keymap('n', '<C-p>', '<Cmd>Telescope projects<CR>', opts)
keymap('n', '<Leader>td', ':TodoTelescope<CR>', opts)

keymap('n', '<Leader>li', ':LspInfo<CR>', opts)
keymap('n', '<Leader>ll', ':LspLog<CR>', opts)
keymap('n', '<Leader>lr', ':LspRestart<CR>', opts)


-- BUG: Following does not work, when no 'LSP' is installed, even when Null-LS is running
keymap('n', '<space>bf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)


----------------------------------------------------------------------------------------------------
-- Harpoon
----------------------------------------------------------------------------------------------------
keymap('n', "<leader>ha", function() require("harpoon.mark").add_file() end, opts)
keymap('n', "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, opts)
keymap('n', ";a", function() require("harpoon.ui").nav_file(1) end, opts)
keymap('n', ";s", function() require("harpoon.ui").nav_file(2) end, opts)
keymap('n', ";d", function() require("harpoon.ui").nav_file(3) end, opts)
keymap('n', ";f", function() require("harpoon.ui").nav_file(4) end, opts)

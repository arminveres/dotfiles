local kopts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

keymap('n', '<Leader>l', ':noh<CR>', kopts)

-- NOTE: moved to overrides under gruvbox
-- vim.cmd('hi! Normal ctermbg=NONE guibg=NONE') -- this is making the background transparant, thus dependent on the terminal
-- vim.cmd('hi! CursorColumn guibg=#202021')
-- vim.cmd('hi! CursorLine guibg=#202021')
-- vim.cmd('hi! link PMenu Normal') -- use link, for less repetition
-- vim.cmd('hi! PMenu guibg=NONE') -- use link, for less repetition
vim.cmd([[highlight link TrailingSpaces Error | match TrailingSpaces /\s\+$/]])

local aucmd = vim.api.nvim_create_autocmd

aucmd({ 'BufRead,BufNewFile' },
  { pattern = { '*.frag,*.vert' }, command = ':set filetype=glsl'
})
aucmd({ 'BufRead,BufNewFile' },
  { pattern = 'COMMIT_EDITMSG', command = ':set colorcolumn=50,72'
})

-- callback for lua function callbacks
-- pattern can be left out, if for all files
aucmd({ 'CursorHold' }, { callback = function() vim.diagnostic.open_float() end })
aucmd({ 'TextYankPost' }, { callback = function() vim.highlight.on_yank() end })

vim.cmd('hi! Normal ctermbg=NONE guibg=NONE') -- this is making the background transparant, thus dependent on the terminal
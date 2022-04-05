-- credits to Javier-varez
local nvim_create_autogroups = function (definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

nvim_create_autogroups {
  arminveres = {
    -- { 'BufRead,BufNewFile', '*', ':set undofile' },
    -- { 'BufRead,BufNewFile', '*', ':set expandtab' },
    -- { 'BufRead,BufNewFile', '*', ':set tabstop=4' },
    -- { 'BufRead,BufNewFile', '*', ':set shiftwidth=4' },
    -- { 'BufRead,BufNewFile', '*.cpp,*.c,*.hpp,*.h', ':set expandtab' },
    -- { 'BufRead,BufNewFile', '*.cpp,*.c,*.hpp,*.h', ':set tabstop=2' },
    -- { 'BufRead,BufNewFile', '*.cpp,*.c,*.hpp,*.h', ':set shiftwidth=2' },
    { 'BufRead,BufNewFile', '*.frag,*.vert', ':set filetype=glsl' },
    { 'BufRead,BufNewFile', 'COMMIT_EDITMSG', ':set colorcolumn=50,72' },
    { 'CursorHold', '*', 'lua vim.diagnostic.open_float()'},
    { 'TextYankPost', '*', 'silent! lua vim.highlight.on_yank()'}
  }
}

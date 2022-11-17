local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.stylua,
    formatting.prettier.with({ extra_args = { '--single-quote', '--jsx-single-quote' } }),
    formatting.black.with({ extra_args = { '--fast' } }),
    formatting.shfmt,
    formatting.latexindent,
    -- formatting.shfmt.with({ extra_args = { '--indent', '4' } }),
    -- formatting.clang_format.with({ extra_args = { '--offset=16', '-style="{BasedOnStyle: Google, AccessModifierOffset: -1}"' } }),
    -- formatting.clang_format.with({ command =  'clang-format -style="{BasedOnStyle: Google, AccessModifierOffset: -1}"' }),
    -- formatting.eslint_d,
    -- formatting.eslint,
  },
})

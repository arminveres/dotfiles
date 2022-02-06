require('armin.options')
require('armin.plugins')
require('armin.mappings')
require('armin.colorscheme')
require('armin.cmp')
require('armin.lsp')
require('armin.telescope')
require('armin.treesitter')
require('armin.autopairs')
require('armin.gitsigns')
require('armin.nvim-tree')
require('armin.comment')
require('armin.bufferline') -- potentially replace with barbar.nvim

--Set statusbar
vim.g.lightline = {
  colorscheme = 'jellybeans',
  active = {
      left = {
          { 'mode', 'paste' },
          { 'gitbranch', 'readonly', 'filename', 'modified' }
      }
  },
  component_function = { gitbranch = 'fugitive#head' },
}

-- Highlight on yank
vim.api.nvim_exec(
    [[
        augroup YankHighlight
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank()
        augroup end
    ]],
    false
)

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

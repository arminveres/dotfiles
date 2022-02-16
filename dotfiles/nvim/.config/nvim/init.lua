require('armin.options')
require('armin.plugins')
require('armin.mappings')
require('armin.colorscheme')
require('armin.lsp')

-- require('armin.luatab')
-- require('armin.tabline')
-- require('armin.bufferline') -- potentially replace with tabline.nvim

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

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
require('armin.lualine')
require('armin.blankline')
require('armin.tabline')
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

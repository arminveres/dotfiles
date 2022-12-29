require('user.options')
require('user.gui-options') -- Needs to be loaded before the plugins, otherwise shell does not get recognized for WIN Gui
require('user.plugins')
require('user.mappings') -- NOTE: could move this to bottom to make all mappings configurable there.
require('user.colorscheme')
require('user.lsp')
require('user.autocmds')
require('user.commands')

vim.opt.showtabline = 1 -- only show when more than one 1 tab, need to be loaded last, gets overwritten otherwise

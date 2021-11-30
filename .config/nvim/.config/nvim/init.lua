require('plugins')
require('mappings')
require('lsp')

-- global option
vim.o.ignorecase = true
vim.o.smartcase = true --Case insensitive searching UNLESS /C or capital in search
vim.o.smarttab = true
vim.o.hlsearch = false
vim.o.backup = true
vim.o.writebackup = true
vim.o.breakindent = true
vim.o.inccommand = 'nosplit'
vim.o.mouse = 'a'
vim.o.hidden = true --Do not save when switching buffers (note: this is now a default on master)

-- buffer-local options
vim.bo.tabstop = 8
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.shiftwidth = 4

-- windows-local options
vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.colorcolumn = '80,100'

vim.opt.undofile = true --Save undo history
vim.opt.undodir = '/tmp//' --'~/.cache/nvim/undo//' doesn't work
vim.opt.backupdir = '/tmp//' --'~/.cache/nvim/backup//'

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd [[colorscheme gruvbox]]

--Set statusbar
vim.g.lightline = {
--  colorscheme = 'onedark',
  colorscheme = 'gruvbox',
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

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mapings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

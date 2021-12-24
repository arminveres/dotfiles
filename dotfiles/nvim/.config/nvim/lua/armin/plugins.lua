-- Install packer if not installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()

  use 'wbthomason/packer.nvim'                  -- Package manager

  use 'tpope/vim-commentary'                    -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'                        -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file

  use 'ludovicchabant/vim-gutentags'            -- Automatic tags management

  use({
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim"
  })

  -- colorschemes
  use 'joshdick/onedark.vim'                    -- Theme inspired by Atom
  use 'morhetz/gruvbox'

  use 'itchyny/lightline.vim'                   -- Fancier statusline

  use 'lukas-reineke/indent-blankline.nvim'     -- Add indentation guides even on blank lines

  use {                                         -- Add git related info in the signs columns and popups
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
  }

  use {                                         -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    require = {                                 -- Additional textobjects for treesitter
      {'nvim-treesitter/nvim-treesitter-textobjects'}
    }
  }

  use {                                         -- Collection of configurations for built-in LSP client
    'neovim/nvim-lspconfig',
    requires = {'williamboman/nvim-lsp-installer'}
  }

  use {                                         -- Autocompletion plugins
    'hrsh7th/nvim-cmp',
    requires = {
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},
        {'hrsh7th/cmp-vsnip'},
        {'hrsh7th/cmp-cmdline'}
    }
  }
  -- use {
  --   'hrsh7th/vim-vsnip',
  --   requires = {
  --       {'rafamadriz/friendly-snippets'}
  --   }
  -- }

  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'                        -- Snippets plugin
  use 'mfussenegger/nvim-jdtls'

-- plugins which could be activated
  -- use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
end)


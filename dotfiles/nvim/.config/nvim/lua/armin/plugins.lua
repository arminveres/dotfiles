-- Install packer if not installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()

  use 'wbthomason/packer.nvim'                  -- Package manager

  use 'tpope/vim-commentary'                    -- "gc" to comment visual regions/lines
  use({
    'tpope/vim-sleuth',
    commit = "e362d3552ba2fcf0bc1830a1c59e869b1c6f2067" -- had some issues
  })                         -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file

  use 'ludovicchabant/vim-gutentags'            -- Automatic tags management

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons"
    }
  })

  use {                                         -- colorschemes
    'joshdick/onedark.vim',
    'rebelot/kanagawa.nvim',
    'morhetz/gruvbox'
  }

  use 'itchyny/lightline.vim'                   -- Fancier statusline

  use 'lukas-reineke/indent-blankline.nvim'     -- Add indentation guides even on blank lines

  use 'lewis6991/gitsigns.nvim'                 -- Add git related info in the signs columns and popups

  use {                                         -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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
      {'rafamadriz/friendly-snippets'},
      {'saadparwaiz1/cmp_luasnip'},
      {'L3MON4D3/LuaSnip'}
      -- {'uga-rosa/cmp-dictionary'},              -- dictionary plugin
      -- {'hrsh7th/cmp-vsnip'},
      -- {'hrsh7th/cmp-cmdline'},
    }
  }

  -- use 'L3MON4D3/LuaSnip'                        -- Snippets plugin

  use 'mfussenegger/nvim-jdtls'                 -- Java LSP

-- plugins which could be activated
  -- use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

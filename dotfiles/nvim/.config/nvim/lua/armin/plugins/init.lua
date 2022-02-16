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
  use {                                         -- colorschemes
    'joshdick/onedark.vim',
    'rebelot/kanagawa.nvim',
    'morhetz/gruvbox'
  }

  -- vim plugins
  use 'tpope/vim-sleuth'                        -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
  use 'ludovicchabant/vim-gutentags'            -- Automatic tags management

  use "numToStr/Comment.nvim"                   -- Easily comment stuff gc/gcc
  use 'windwp/nvim-autopairs'                   -- Autopairs {}, [], () etc
  use 'akinsho/toggleterm.nvim'
  use 'kyazdani42/nvim-tree.lua'                -- Replacement for Netrw
  use 'mfussenegger/nvim-jdtls'                 -- Java LSP
  use 'davidgranstrom/nvim-markdown-preview'    -- markdown preview
  use 'stevearc/aerial.nvim'                    -- functions outline plugin
  use 'jose-elias-alvarez/null-ls.nvim'         -- Null LS

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons"
    }
  })

  use 'nvim-lualine/lualine.nvim'               -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'     -- Add indentation guides even on blank lines
  use 'lewis6991/gitsigns.nvim'                 -- Add git related info in the signs columns and popups
  use {                                         -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- better context aware commenting
  use {                                         -- Collection of configurations for built-in LSP client
    'neovim/nvim-lspconfig',
    requires = {'williamboman/nvim-lsp-installer'}
  }
  use 'p00f/clangd_extensions.nvim'             -- Clangd's off-spec features for neovim's LSP client
  use {                                         -- Autocompletion plugins
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'rafamadriz/friendly-snippets'},
      {'saadparwaiz1/cmp_luasnip'},
      {'L3MON4D3/LuaSnip'},
      {'uga-rosa/cmp-dictionary'},              -- dictionary plugin
      {'f3fora/cmp-spell'}                      -- spelling plugin
      -- {'hrsh7th/cmp-vsnip'},
      -- {'hrsh7th/cmp-cmdline'},
    }
  }
  -- use "akinsho/bufferline.nvim"                 -- Prettier (and more versatile) Bufferlines
  -- use 'kdheepak/tabline.nvim'
  -- use 'alvarosevilla95/luatab.nvim'
  use 'nanozuki/tabby.nvim'
  use "moll/vim-bbye"                           -- allows you to do delete buffers (close files) without closing your windows

-- plugins which could be activated
  -- use 'tpope/vim-fugitive' -- Git commands in nvim
  -- use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require('armin.plugins.cmp')
require('armin.plugins.telescope')
require('armin.plugins.treesitter')
require('armin.plugins.autopairs')
require('armin.plugins.gitsigns')
require('armin.plugins.nvim-tree')
require('armin.plugins.comment')
require('armin.plugins.lualine')
require('armin.plugins.blankline')
require('armin.plugins.toggleterm')
require('armin.plugins.tabby')
require('armin.plugins.aerial')

-- require('armin.luatab')
-- require('armin.tabline')
-- require('armin.bufferline') -- potentially replace with tabline.nvim

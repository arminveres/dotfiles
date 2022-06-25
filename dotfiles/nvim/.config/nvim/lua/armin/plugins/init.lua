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
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use {
    'wbthomason/packer.nvim', -- Package manager
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
    'williamboman/nvim-lsp-installer', -- installer for lsps
    'windwp/nvim-autopairs', -- Autopairs {}, [], () etc
    'akinsho/toggleterm.nvim',
    'stevearc/aerial.nvim', -- functions outline plugin
    'stevearc/dressing.nvim', -- better ui
    'norcalli/nvim-colorizer.lua', -- colorizes color codes
    'jose-elias-alvarez/null-ls.nvim', -- Null LS
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    'lewis6991/gitsigns.nvim', -- Add git related info in the signs columns and popups
    'JoosepAlviste/nvim-ts-context-commentstring', -- better context aware commenting
    'nanozuki/tabby.nvim',
    'folke/todo-comments.nvim', -- highlight and search for todo comments like
    'folke/which-key.nvim', -- displays a popup with possible key bindings
    'norcalli/nvim-terminal.lua',
    'kyazdani42/nvim-tree.lua', -- Replacement for Netrw
    'numToStr/Comment.nvim', -- Comment out code easily
    'p00f/clangd_extensions.nvim',              -- Clangd's off-spec features for neovim's LSP client
    'p00f/nvim-ts-rainbow', -- rainbow parenthesis
    'RRethy/vim-illuminate' -- illuminate work under cursor
    -- 'nvim-neo-tree/neo-tree.nvim',
    -- 'MunifTanjim/nui.nvim',
    -- 'pierreglaser/folding-nvim',

    -- 'mfussenegger/nvim-jdtls',                  -- Java LSP
  }

  use({ -- markdown preview plugin, very nice!
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  use { -- colorschemes TODO: just write my own colorscheme based on gruvbox...
    -- 'morhetz/gruvbox', -- OG gruvbox
    'ellisonleao/gruvbox.nvim',
    'rebelot/kanagawa.nvim',
    'tanvirtin/monokai.nvim',
    'marko-cerovac/material.nvim',
    'navarasu/onedark.nvim',
    'Mofiqul/vscode.nvim',
    'Murtaza-Udaipurwala/gruvqueen',
    'Shatur/neovim-ayu',
    'projekt0n/github-nvim-theme',
  }

  use { -- vimscript plugins
    'tpope/vim-sleuth', -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
    'ludovicchabant/vim-gutentags', -- Automatic tags management
    'mboughaba/i3config.vim',
    'moll/vim-bbye', -- allows you to do delete buffers (close files) without closing your windows
    'ivyl/vim-bling', -- blinks search result after jumping to it (think of n, N, * and #)
    'mbbill/undotree',
    'fladson/vim-kitty',
    -- 'tpope/vim-fugitive'                     -- Git commands in nvim
    -- 'tpope/vim-rhubarb'                      -- Fugitive-companion to interact with github
  }

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "aloussase/telescope-gradle.nvim", -- A telescope extension to run gradle tasks
      "jvgrootveld/telescope-zoxide" -- allows you operate zoxide within Neovim
    }
  })

  use { -- Highlight, edit, and navigate code using a fast incremental parsing library
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use {
    'junegunn/fzf',
    run = './install --bin'
  }

  use { -- Autocompletion plugins
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'uga-rosa/cmp-dictionary' }, -- dictionary plugin
      { 'f3fora/cmp-spell' }, -- spelling plugin
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
      -- {'hrsh7th/cmp-vsnip'},
    }
  }

  use {
    'alvarosevilla95/luatab.nvim',
    config = function()
      require('luatab').setup {
        -- title = function() return '' end,
        -- modified = function() return '' end,
        -- windowCount = function() return '' end,
        -- devicon = function() return '' end,
        separator = function() return '▌' end,
      }
    end
  }

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
require('armin.plugins.aerial')
require('armin.plugins.colorizer')
require('armin.plugins.todo')
require('armin.plugins.whichkey')
-- require('armin.plugins.neo-tree')
-- require('armin.plugins.tabby')

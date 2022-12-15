-- Install packer if not installed
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost init.lua source <afile> | PackerSync
--  augroup end
--]])

local use = require('packer').use
require('packer').startup({
  function()
    use({
      'wbthomason/packer.nvim', -- Package manager
      'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
      'williamboman/mason.nvim', -- installer for lsps
      'williamboman/mason-lspconfig.nvim',
      'jose-elias-alvarez/null-ls.nvim', -- Null LS
      {
        'windwp/nvim-autopairs', -- Autopairs {}, [], () etc
        config = require('user.plugins.autopairs'),
      },
      {
        'kylechui/nvim-surround',
        tag = '*', -- Use for stability; omit to use `main` branch for the latest features
        config = require('user.plugins.surround'),
      },
      {
        'akinsho/toggleterm.nvim', -- custom terminal for neovim
        config = require('user.plugins.toggleterm'),
      },
      {
        'akinsho/bufferline.nvim', -- tabline replacement
        tag = 'v2.*',
        config = require('user.plugins.bufferline'),
      },
      {
        'norcalli/nvim-colorizer.lua', -- colorizes color codes
        config = require('user.plugins.colorizer'),
      },
      {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        config = require('user.plugins.lualine'),
      },
      {
        'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
        config = require('user.plugins.blankline'),
      },
      {
        'lewis6991/gitsigns.nvim', -- Add git related info in the signs columns and popups
        config = require('user.plugins.gitsigns'),
      },
      {
        'lewis6991/spellsitter.nvim', -- enhances neovim spellchecker with treesitter
        config = require('user.plugins.spellsitter'),
      },
      {
        'folke/todo-comments.nvim', -- highlight and search for todo comments like
        config = require('user.plugins.todo'),
      },
      {
        'folke/which-key.nvim', -- displays a popup with possible key bindings
        config = require('user.plugins.whichkey'),
      },
      {
        'kyazdani42/nvim-tree.lua', -- Replacement for Netrw
        config = require('user.plugins.nvim-tree'),
      },
      {
        'numToStr/Comment.nvim', -- Comment out code easily
        config = require('user.plugins.comment'),
        requires = {
          'JoosepAlviste/nvim-ts-context-commentstring', -- better context aware commenting
        },
      },
      'p00f/clangd_extensions.nvim', -- Clangd's off-spec features for neovim's LSP client
      'p00f/nvim-ts-rainbow', -- rainbow parenthesis
      --'p00f/godbolt.nvim', -- compile explorer in nvim
      'RRethy/vim-illuminate', -- illuminate word under cursor
      {
        'ziontee113/color-picker.nvim', -- color picker
        config = require('user.plugins.colorpicker'),
      },
      {
        'ahmedkhalf/project.nvim', -- vim-rooter like replacement in neovim with many features
        config = require('user.plugins.project'),
      },
      {
        'j-hui/fidget.nvim', -- progress indicator for LSP
        config = require('user.plugins.fidget'),
      },
      {
        'zbirenbaum/neodim', -- dim unused variables
        config = require('user.plugins.dim'),
      },
      {
        'petertriho/nvim-scrollbar', -- scrollbar
        config = require('user.plugins.scrollbar'),
      },
      {
        'kevinhwang91/nvim-hlslens', -- nicer search results
        config = require('user.plugins.hlslens'),
      },
      {
        'stevearc/dressing.nvim',
        config = require('user.plugins.dressing'),
      },
      'ThePrimeagen/harpoon',
      -- {
        -- 'rcarriga/nvim-notify',
        -- config = require('user.plugins.notify')
      -- },
    })

    use({ -- install without yarn or npm
      'iamcco/markdown-preview.nvim',
      run = function()
        vim.fn['mkdp#util#install']()
      end,
    })

    use({ -- colorschemes TODO: just write my own colorscheme based on gruvbox...
      'ellisonleao/gruvbox.nvim',
      'rebelot/kanagawa.nvim',
      -- 'Mofiqul/vscode.nvim',
      -- 'projekt0n/github-nvim-theme',
      -- 'tanvirtin/monokai.nvim',
      -- 'marko-cerovac/material.nvim',
      -- 'navarasu/onedark.nvim',
      -- 'Murtaza-Udaipurwala/gruvqueen',
      -- 'Shatur/neovim-ayu',
    })

    use({ -- vimscript plugins
      'tpope/vim-sleuth', -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
      'ludovicchabant/vim-gutentags', -- Automatic tags management
      'mboughaba/i3config.vim',
      'moll/vim-bbye', -- allows you to do delete buffers (close files) without closing your windows
      'mbbill/undotree',
      'fladson/vim-kitty',
      'ron-rs/ron.vim',
      'lervag/vimtex',
      'mphe/grayout.vim',
      -- 'tpope/vim-fugitive',                     -- Git commands in nvim
      -- 'tpope/vim-rhubarb',                      -- Fugitive-companion to interact with github
    })

    use({
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'jvgrootveld/telescope-zoxide', -- allows you operate zoxide within Neovim
      },
      config = require('user.plugins.tlscp'),
    })

    use({ -- Highlight, edit, and navigate code using a fast incremental parsing library
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-context',
      },
      config = require('user.plugins.treesitter'),
    })

    use({
      'junegunn/fzf',
      run = './install --bin',
    })

    use({ -- Autocompletion plugins
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-cmdline',
        'lukas-reineke/cmp-rg',
        {
          'petertriho/cmp-git',
          config = require('user.plugins.cmp-git'),
        },
        'uga-rosa/cmp-dictionary', -- dictionary plugin
        'f3fora/cmp-spell', -- spelling plugin
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        -- {'hrsh7th/cmp-vsnip'},
      },
      config = require('user.plugins.cmp'),
    })

    use({
      'glepnir/lspsaga.nvim',
      branch = 'main',
      -- commit = '82db9108a30325cfce5b95ae4c9286f1d6b4442c',
      config = require('user.plugins.lspsaga'),
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})

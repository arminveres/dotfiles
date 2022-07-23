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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

local use = require('packer').use
require('packer').startup({
  function()
    use({
      'wbthomason/packer.nvim', -- Package manager
      'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
      'williamboman/nvim-lsp-installer', -- installer for lsps
      'windwp/nvim-autopairs', -- Autopairs {}, [], () etc
      'akinsho/toggleterm.nvim', -- custom terminal for neovim
      'akinsho/bufferline.nvim', -- tabline replacement
      'stevearc/aerial.nvim', -- functions outline plugin
      'stevearc/dressing.nvim', -- better ui
      'norcalli/nvim-colorizer.lua', -- colorizes color codes
      'jose-elias-alvarez/null-ls.nvim', -- Null LS
      'nvim-lualine/lualine.nvim', -- Fancier statusline
      'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
      'lewis6991/gitsigns.nvim', -- Add git related info in the signs columns and popups
      'lewis6991/spellsitter.nvim', -- enhances neovim spellchecker with treesitter
      'JoosepAlviste/nvim-ts-context-commentstring', -- better context aware commenting
      'nanozuki/tabby.nvim',
      'folke/todo-comments.nvim', -- highlight and search for todo comments like
      'folke/which-key.nvim', -- displays a popup with possible key bindings
      'norcalli/nvim-terminal.lua',
      'kyazdani42/nvim-tree.lua', -- Replacement for Netrw
      'numToStr/Comment.nvim', -- Comment out code easily
      'p00f/clangd_extensions.nvim', -- Clangd's off-spec features for neovim's LSP client
      'p00f/nvim-ts-rainbow', -- rainbow parenthesis
      'p00f/godbolt.nvim', -- compile explorer in nvim
      'RRethy/vim-illuminate', -- illuminate work under cursor
      'ziontee113/color-picker.nvim', -- color picker
      'ahmedkhalf/project.nvim', -- vim-rooter like replacement in neovim with many features
      'j-hui/fidget.nvim', -- progress indicator for LSP
      'zbirenbaum/neodim', -- dim unused variables
      'petertriho/nvim-scrollbar', -- scrollbar
      'kevinhwang91/nvim-hlslens', -- nicer search results

      -- 'lewis6991/satellite.nvim', -- displays decorated scrollbars
      -- 'nvim-neo-tree/neo-tree.nvim',
      -- 'mfussenegger/nvim-jdtls',                  -- better Java LSP integration
    })

    use({ -- markdown preview plugin, very nice!
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetypes = { 'markdown' }
      end,
      ft = { 'markdown' },
    })

    use({ -- colorschemes TODO: just write my own colorscheme based on gruvbox...
      'ellisonleao/gruvbox.nvim',
      'rebelot/kanagawa.nvim',
      'Mofiqul/vscode.nvim',
      'projekt0n/github-nvim-theme',
      'tanvirtin/monokai.nvim',
      'marko-cerovac/material.nvim',
      'navarasu/onedark.nvim',
      'Murtaza-Udaipurwala/gruvqueen',
      'Shatur/neovim-ayu',
    })

    use({ -- vimscript plugins
      'tpope/vim-sleuth', -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
      'ludovicchabant/vim-gutentags', -- Automatic tags management
      'mboughaba/i3config.vim',
      'moll/vim-bbye', -- allows you to do delete buffers (close files) without closing your windows
      'mbbill/undotree',
      'fladson/vim-kitty',
      -- 'tpope/vim-fugitive',                     -- Git commands in nvim
      -- 'tpope/vim-rhubarb',                      -- Fugitive-companion to interact with github
      -- 'ivyl/vim-bling', -- blinks search result after jumping to it (think of n, N, * and #)
    })

    use({
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'aloussase/telescope-gradle.nvim', -- A telescope extension to run gradle tasks
        'jvgrootveld/telescope-zoxide', -- allows you operate zoxide within Neovim
      },
    })

    use({ -- Highlight, edit, and navigate code using a fast incremental parsing library
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      requires = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
      },
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
        'petertriho/cmp-git', -- git commit completion
        'uga-rosa/cmp-dictionary', -- dictionary plugin
        'f3fora/cmp-spell', -- spelling plugin
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        -- {'hrsh7th/cmp-vsnip'},
      },
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

require('user.plugins.cmp')
require('user.plugins.cmp-git')
---@diagnostic disable-next-line: different-requires
require('user.plugins.telescope')
require('user.plugins.treesitter')
require('user.plugins.autopairs')
require('user.plugins.gitsigns')
require('user.plugins.nvim-tree')
require('user.plugins.comment')
require('user.plugins.lualine')
require('user.plugins.blankline')
require('user.plugins.toggleterm')
---@diagnostic disable-next-line: different-requires
require('user.plugins.aerial')
require('user.plugins.colorizer')
require('user.plugins.todo')
require('user.plugins.whichkey')
require('user.plugins.colorpicker')
require('user.plugins.project')
require('user.plugins.spellsitter')
require('user.plugins.fidget')
require('user.plugins.dim')
require('user.plugins.bufferline')
require('user.plugins.scrollbar')
require('user.plugins.hlslens')

-- require('user.plugins.satellite') -- WARN:requires neovim nightly (winbar) therefore disabled for the moment
-- require('user.plugins.neo-tree')
-- require('user.plugins.tabby')

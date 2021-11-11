local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'


if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    requires = {'williamboman/nvim-lsp-installer'}
  }

end)

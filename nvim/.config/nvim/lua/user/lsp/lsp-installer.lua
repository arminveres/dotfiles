local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  vim.notify('mason not ok')
  return
end

mason.setup({
  -- add config here
})

local status_ok, lsp_installer = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

local settings = {
  -- refer to documentation https://github.com/williamboman/mason-lspconfig.nvim
}
lsp_installer.setup({
  ensure_installed = { "sumneko_lua", "rust_analyzer", "clangd", "bashls" }
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in ipairs(lsp_installer.get_installed_servers()) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "pylsp" then
    local pylsp_opts = require("user.lsp.settings.pylsp")
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end

  if server == "bashls" then
    local bashls_opts = require("user.lsp.settings.bashls")
    opts = vim.tbl_deep_extend("force", bashls_opts, opts)
  end

  if server == "ltex" then
    local ltex_opts = require("user.lsp.settings.ltex")
    opts = vim.tbl_deep_extend("force", ltex_opts, opts)
  end

  if server == "rust-analyzer" then
    local rust_opts = require("user.lsp.settings.rust")
    opts = vim.tbl_deep_extend("force", rust_opts, opts)
  end

  if server == "clangd" then
    local clangd_opts = require('user.lsp.settings.clangd').server
    opts = vim.tbl_deep_extend('force', clangd_opts, opts)
    require('clangd_extensions').setup({
      server = opts,
      extensions = require('user.lsp.settings.clangd').extensions
    })
    goto continue
  end

  lspconfig[server].setup(opts)

  ::continue::
end

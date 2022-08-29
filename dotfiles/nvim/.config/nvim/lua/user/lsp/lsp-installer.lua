local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local settings = {
  ensure_installed = {
    "sumneko_lua",
    "marksman",
    "bashls",
  },
  ui = {
    icons = {},
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
}

lsp_installer.setup(settings)

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

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require("user.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == "pylsp" then
    local pylsp_opts = require("user.lsp.settings.pylsp")
    opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
  end

  if server.name == "bashls" then
    local bashls_opts = require("user.lsp.settings.bashls")
    opts = vim.tbl_deep_extend("force", bashls_opts, opts)
  end

  -- BUG: this stopped working
  -- if server == "arduino_language_server" then
  --   opts.on_new_config = function(config, root_dir)
  --     local partial_cmd = server:get_default_options().cmd
  --     local MY_FQBN = "arduino:avr:nano"
  --     config.cmd = vim.list_extend(partial_cmd, { "-fqbn", MY_FQBN })
  --   end
  -- end

  if server.name == "ltex" then
    local ltex_opts = require("user.lsp.settings.ltex")
    opts = vim.tbl_deep_extend("force", ltex_opts, opts)
  end

  if server.name == "clangd" then
    local clangd_opts = require('user.lsp.settings.clangd').server
    opts = vim.tbl_deep_extend('force', clangd_opts, opts)
    require('clangd_extensions').setup({
      server = opts,
      extensions = require('user.lsp.settings.clangd').extensions
    })
    goto continue
  end

  lspconfig[server.name].setup(opts)

  ::continue::
end

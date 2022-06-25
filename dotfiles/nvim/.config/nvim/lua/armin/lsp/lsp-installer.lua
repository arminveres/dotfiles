local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

--[[ TODO: migrate to .setup()
  'https://github.com/williamboman/nvim-lsp-installer/discussions/636'
  'https://github.com/williamboman/nvim-lsp-installer/pull/635'
--]]

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("armin.lsp.handlers").on_attach,
    capabilities = require("armin.lsp.handlers").capabilities,
  }

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("armin.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server.name == "pyright" then
    local pyright_opts = require("armin.lsp.settings.pyright")
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server.name == "bashls" then
    local bashls_opts = require("armin.lsp.settings.bashls")
    opts = vim.tbl_deep_extend("force", bashls_opts, opts)
  end

  if server.name == "arduino_language_server" then
    opts.on_new_config = function(config, root_dir)
      local partial_cmd = server:get_default_options().cmd
      local MY_FQBN = "arduino:avr:nano"
      config.cmd = vim.list_extend(partial_cmd, { "-fqbn", MY_FQBN })
    end
  end

  if server.name == "jdtls" then
    -- local jdtls_opts = require("armin.lsp.settings.jdtls")
    -- opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
    -- return
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

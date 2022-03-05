local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require('armin.lsp.lsp-installer')
require('armin.lsp.handlers').setup()
require('armin.lsp.null-ls')

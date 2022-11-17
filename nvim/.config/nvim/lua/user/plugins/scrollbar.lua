local scb_ok, scrollbar = pcall(require, 'scrollbar')
if not scb_ok then
  vim.notify("scrollbar not ok")
  return
end

scrollbar.setup({})
require("scrollbar.handlers.search").setup()

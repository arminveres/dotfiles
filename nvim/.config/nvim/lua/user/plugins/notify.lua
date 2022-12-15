local is_ok, notify = pcall(require, 'notify')
if not is_ok then
  vim.notify('notify not ok')
  return
end

notify.setup({
  -- add config here
  background_colour = "#000000",
})
-- vim.notify = require('notify')

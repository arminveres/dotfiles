local tabby_status_ok, tabby = pcall(require, 'tabby')
if not tabby_status_ok then
  return
end

tabby.setup({
  -- tabline = require("tabby.presets").tab_with_top_win,
  tabline = require('tabby.presets').tab_only,
})

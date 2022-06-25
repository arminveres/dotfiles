local M = {}

-- TODO: make this global
-- @brief a cleaner way to call require a modul, without causing errors
-- Called as: 'require("lua.armin.utils").prequire("")'
M.prot_require = function(in_name_str)
  local status, in_name = pcall(require, in_name_str)
  if not status then
    vim.notify(in_name_str .. " not callable")
    return
  end
  return in_name
end

return M

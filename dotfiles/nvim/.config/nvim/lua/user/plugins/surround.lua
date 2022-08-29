local is_ok, surround = pcall(require, 'nvim-surround')
if not is_ok then
  vim.notify('surround not ok')
  return
end
--[[ https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/config.lua ]]
surround.setup({
  -- add config here
})

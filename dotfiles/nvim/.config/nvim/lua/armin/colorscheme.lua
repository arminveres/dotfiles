--Set colorscheme (order is important here)
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'

local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- Set colorscheme (order is important here)
-- local colorscheme = 'kanagawa'
-- local colorscheme = 'gruvbox'
local colorscheme = 'monokai'

-- gruvbox settings
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'

-- kanagawa settings
local kanagawa_status_ok, kanagawa = pcall(require, "kanagawa")
if not kanagawa_status_ok then
  vim.notify("kanagawa not found")
  return
end

-- monokai settings
local monokai_status_ok, monokai = pcall(require, "kanagawa")
if not monokai_status_ok then
  vim.notify("monokai not found")
  return
end

kanagawa.setup({
  undercurl = true, -- enable undercurls
  commentStyle = "italic",
  functionStyle = "NONE",
  keywordStyle = "italic",
  statementStyle = "bold",
  typeStyle = "NONE",
  variablebuiltinStyle = "italic",
  specialReturn = true, -- special highlight for the return keyword
  specialException = true, -- special highlight for exception handling keywords
  transparent = true, -- do not set background color
  dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  colors = {},
  overrides = {},
})


-- all settings end

local csm_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not csm_status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

-- Set colorscheme (order is important here)
local colorscheme = 'gruvbox'

-- Customized colors for colorschemes
local custom_colors = {
  Normal = { bg = 'NONE' },
  PMenu = { bg = 'NONE' }, -- Completion Menu
  NormalFloat = { bg = 'NONE'},
  FloatBorder = { bg = 'NONE'},
  CursorColumn = { bg = '#202021' },
  CursorLine = { bg = '#202021' },
}

-- gruvbox settings
local gruvbox_ok, gruvbox = pcall(require, 'gruvbox')
if not gruvbox_ok then
  vim.notify('gruvbox not ok')
else
  gruvbox.setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = true, -- will make italic comments and special strings
    inverse = true, -- invert background for search, diffs, statuslines and errors
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    contrast = '', -- can be "hard" or "soft"
    -- overriding highlight groups
    overrides = custom_colors,
  })
end

-- ########################
-- ### all settings end ###
-- ########################

-- setting the colorscheme
local csm_status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not csm_status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
end

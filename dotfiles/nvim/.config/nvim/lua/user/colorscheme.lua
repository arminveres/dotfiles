-- Set colorscheme (order is important here)
local colorscheme = 'gruvbox'
-- local colorscheme = 'ayu'
-- local colorscheme = 'kanagawa'
-- local colorscheme = 'gruvqueen'
-- local colorscheme = 'onedark'
-- local colorscheme = 'monokai'
-- local colorscheme = 'material'
-- local colorscheme = 'vscode'
-- local colorscheme = 'github'

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

-- vscode settings
local is_ok_vscode, vscode = pcall(require, 'vscode')
if not is_ok_vscode then
  vim.notify('vscode not ok')
  return
end

vscode.setup({
  group_overrides = custom_colors
})

-- kanagawa settings
local kanagawa_status_ok, kanagawa = pcall(require, 'kanagawa')
if kanagawa_status_ok then
  kanagawa.setup({
    undercurl = true, -- enable undercurls
    commentStyle = {
      italic = true,
    },
    functionStyle = {},
    keywordStyle = {
      italic = true,
    },
    statementStyle = {
      bold = true,
    },
    typeStyle = {},
    variablebuiltinStyle = {
      italic = true,
    },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    colors = {},
    overrides = custom_colors,
  })
else
  vim.notify('kanagawa not found')
end

-- monokai settings
local monokai_status_ok, monokai = pcall(require, 'monokai')
if not monokai_status_ok then
  vim.notify('monokai not found')
end

-- material settings
local material_status_ok, material = pcall(require, 'material')
if material_status_ok then
  material.setup({
    contrast = {
      sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      line_numbers = false, -- Enable contrast background for line numbers
      sign_column = false, -- Enable contrast background for the sign column
      cursor_line = false, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable darker background for non-current windows
      popup_menu = false, -- Enable lighter background for the popup menu
    },

    italics = {
      comments = true, -- Enable italic comments
      keywords = false, -- Enable italic keywords
      functions = false, -- Enable italic functions
      strings = false, -- Enable italic strings
      variables = false, -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
      'terminal', -- Darker terminal background
      'packer', -- Darker packer background
      'qf', -- Darker qf list background
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false, -- Enable higher contrast text for darker style
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },

    lualine_style = 'default', -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = custom_colors, -- Overwrite highlights with your own
  })
else
  vim.notify('material not found')
end
vim.g.material_style = 'darker'

-- onedark settings
local onedark_status_ok, onedark = pcall(require, 'onedark')
if not onedark_status_ok then
  vim.notify('onedark not found')
else
  onedark.setup({
    style = 'warmer',
  })
end

-- gruvqueen settings
local gruvqueen_status_ok, gruvqueen = pcall(require, 'gruvqueen')
if not gruvqueen_status_ok then
  vim.notify('gruvqueen not found')
else
  gruvqueen.setup({
    config = {
      disable_bold = false,
      italic_comments = true,
      italic_keywords = true,
      italic_functions = true,
      italic_variables = true,
      invert_selection = true,
      style = 'original', -- possible values: 'original', 'mix', 'material'
      transparent_background = true,
      -- bg_color = "black",
    },
  })
end

-- onedark settings
local ayu_status_ok, ayu = pcall(require, 'ayu')
if not ayu_status_ok then
  vim.notify('ayu not found')
else
  ayu.setup({
    dark = true,
  })
end

-- github theme
local gh_status_ok, gh_theme = pcall(require, 'github-theme')
if not gh_status_ok then
  vim.notify('ayu not found')
else
  gh_theme.setup({
    theme_style = 'dark_default',
    comment_style = 'italic',
    keyword_style = 'NONE',
    function_style = 'NONE',
    variable_style = 'NONE',
  })
end
-- ########################
-- ### all settings end ###
-- ########################

-- setting the colorscheme
local csm_status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not csm_status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

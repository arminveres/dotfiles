-- Set colorscheme (order is important here)
-- local colorscheme = 'kanagawa'
local colorscheme = 'gruvbox'
-- local colorscheme = 'monokai'
-- local colorscheme = 'material'

-- gruvbox settings
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'medium' -- soft, medium, hard
-- vim.g.gruvbox_transparent_bg = '1'
-- vim.g.gruvbox_hls_cursor = 'orange'

-- kanagawa settings
local kanagawa_status_ok, kanagawa = pcall(require, "kanagawa")
if kanagawa_status_ok then
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
else
  vim.notify("kanagawa not found")
end

-- monokai settings
local monokai_status_ok, monokai = pcall(require, "monokai")
if not monokai_status_ok then
  vim.notify("monokai not found")
end

-- material settings
local material_status_ok, material = pcall(require, "material")
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
      variables = false -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
      "terminal", -- Darker terminal background
      "packer", -- Darker packer background
      "qf" -- Darker qf list background
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false -- Enable higher contrast text for darker style
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false -- Hide the end-of-buffer lines
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {} -- Overwrite highlights with your own
  })
else
  vim.notify("material not found")
end
vim.g.material_style = "darker"


-- all settings end

local csm_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not csm_status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

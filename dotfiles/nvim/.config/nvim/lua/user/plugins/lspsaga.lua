local is_ok, saga = pcall(require, 'lspsaga')
if not is_ok then
  vim.notify('lsp saga not ok')
  return
end

saga.init_lsp_saga({
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = 'single',
  --the range of 0 for fully opaque window (disabled) to 100 for fully
  --transparent background. Values between 0-30 are typically most useful.
  saga_winblend = 15,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  -- Error, Warn, Info, Hint
  -- and diagnostic_header can be a function type
  -- must return a string and when diagnostic_header
  -- is function type it will have a param `entry`
  -- entry is a table type has these filed
  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
  diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 10,
  -- use emoji lightbulb in default
  code_action_icon = '💡', --
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- BUG: causes error if enabled, https://github.com/glepnir/lspsaga.nvim/issues/411, no real solution to it yet
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = true,
  },
  -- finder icons
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  finder_request_timeout = 1500,
  finder_action_keys = {
    open = 'o',
    vsplit = 's',
    split = 'i',
    tabe = 't',
    quit = 'q',
    scroll_down = '<C-f>',
    scroll_up = '<C-b>', -- quit can be a table
  },
  code_action_keys = {
    quit = 'q',
    exec = '<CR>',
  },
  rename_action_quit = '<C-c>',
  rename_in_select = true,
  -- show symbols in winbar must nightly
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = ' ',
    show_file = true,
    click_support = false,
  },
  -- show outline
  show_outline = {
    win_position = 'left',
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = 'NvimTree',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    -- auto refresh when change buffer
    auto_refresh = true,
  },
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = { metals = { "sbt", "scala" } }
  server_filetype_map = {},
})

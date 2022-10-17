-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, 'nvim-tree.config')
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({ -- BEGIN_DEFAULT_OPTS
  -- options for project.nvim
  update_cwd = true, -- def: false
  respect_buf_cwd = true,
  -- rest
  auto_reload_on_write = true,
  disable_netrw = true, -- def: false
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  ignore_buffer_on_setup = false,
  open_on_setup = true,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = 'name',
  view = {
    adaptive_size = true,  -- adapt opened size to show files, that would be hidden otherwise
    width = 30,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = true, -- def: false
    number = true, -- default: false
    relativenumber = true, -- default: false
    signcolumn = 'yes', -- show diagnostics
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
        { key = { 'l', '<CR>', 'o' }, cb = tree_cb('edit') },
        { key = 'h', cb = tree_cb('close_node') },
        { key = 'v', cb = tree_cb('vsplit') },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = '└ ',
        edge = '│ ',
        none = '  ',
      },
    },
    icons = {
      webdev_colors = true,
      glyphs = {
        default = '',
        symlink = '',
        git = {
          unstaged = '',
          staged = 'S',
          unmerged = '',
          renamed = '➜',
          deleted = '',
          untracked = 'U',
          ignored = '◌',
        },
        folder = {
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
        },
      },
    },
    group_empty = true,
    root_folder_modifier = ':t',
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    -- adjusted for project.nvim
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = '',
    args = {},
  },
  diagnostics = {
    enable = true, -- default: false
    show_on_dirs = true, -- default: false
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = false, -- default: true
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true, -- default: false
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}) -- END_DEFAULT_OPTS

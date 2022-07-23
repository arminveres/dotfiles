local lualine_status_ok, lualine = pcall(require, 'lualine')
if not lualine_status_ok then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'powerline', --auto
    component_separators = { left = '|', right = '|' },
    section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'branch',
        icon = { '', color = { fg = '#f34f29 ' } },
      },
      'diff',
      'diagnostics',
    },
    lualine_c = {
      {
        'filename',
        path = 0, -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        file_status = true, -- Displays file status (readonly status, modified status)
        shorting_target = 40, -- Shortens path to leave 40 spaces in the window for other components.
      },
      {}, -- 'aerial' -- didn't really use aerial, so disabling for now
    },
    lualine_x = { {
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
    }, 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

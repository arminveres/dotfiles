local satellite_ok, satellite = pcall(require, 'satellite')
if not satellite_ok then
  vim.notify('satellite not ok')
else
  satellite.setup({
    current_only = false,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {},
    width = 2,
    handlers = {
      search = {
        enable = true,
      },
      diagnostic = {
        enable = true,
      },
      gitsigns = {
        enable = true,
      },
      marks = {
        enable = true,
        show_builtins = false, -- shows the builtin marks like [ ] < >
      },
    },
  })
end

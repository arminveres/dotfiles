local dim_ok, dim = pcall(require, 'neodim')
if not dim_ok then
  vim.notify('dim not ok')
  return
end

-- https://github.com/zbirenbaum/neodim
dim.setup({
  alpha = 0.75,
  blend_color = '#000000',
  update_in_insert = {
    enable = true,
    delay = 100,
  },
  hide = {
    virtual_text = true,
    signs = true,
    underline = true,
  },
})

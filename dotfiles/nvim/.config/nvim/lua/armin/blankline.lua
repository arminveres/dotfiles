local blankline_status_ok, indent_blankline = pcall(require, "indent_blankline")
if not blankline_status_ok then
  return
end

indent_blankline.setup {
  char = '┊',
  filetype_exclude = { 'help', 'packer' },
  buftype_exclude = { 'terminal', 'nofile' },
  char_highlight = 'LineNr',
  show_trailing_blankline_indent = false,
  show_current_context = true,
  show_current_context_start = true,
}

--Map blankline
-- vim.g.indent_blankline_char = '┊'
-- vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
-- vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
-- vim.g.indent_blankline_char_highlight = 'LineNr'
-- vim.g.indent_blankline_show_trailing_blankline_indent = false

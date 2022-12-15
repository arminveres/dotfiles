local sidebar_ok, sidebar = pcall(require, 'sidebar-nvim')
if not sidebar_ok then
  vim.notify('sidebar not ok')
  return
end

sidebar.setup({
  -- TODO: Add specific config
  -- Files, git status, diagnostics, todos
})

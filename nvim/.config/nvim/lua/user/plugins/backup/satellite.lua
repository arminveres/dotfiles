local satellite_ok, satellite = pcall(require, 'satellite')
if not satellite_ok then
  vim.notify('satellite not ok')
else
  satellite.setup({})
end

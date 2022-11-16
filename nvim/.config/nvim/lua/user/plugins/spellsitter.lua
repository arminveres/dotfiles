local ss_ok, spellsitter = pcall(require, 'spellsitter')
if not ss_ok then
  vim.notify('spellsitter not ok')
  return
end

spellsitter.setup({
  enable = true,
  debug = false,
})

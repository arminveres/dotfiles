local luatab_status_ok, luatab = pcall(require, 'luatab')
if not luatab_status_ok then
  return
end

luatab.setup({
  -- title = function() return '' end,
  -- modified = function() return '' end,
  -- windowCount = function() return '' end,
  -- devicon = function() return '' end,
  -- separator = function() return '▎' end,
})

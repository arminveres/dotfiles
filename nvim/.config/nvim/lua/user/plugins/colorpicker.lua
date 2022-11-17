local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>cp', '<cmd>PickColor<cr>', opts)
-- vim.keymap.set('i', '<C-c>', '<cmd>PickColorInsert<cr>', opts)

-- only need setup() if you want to change progress bar icons
local cp_ok, cpicker = pcall(require, 'color-picker')
if not cp_ok then
  vim.notify('color picker not ok')
else
  cpicker.setup({
    -- ["icons"] = { "ﱢ", "" },
    -- ["icons"] = { "ﮊ", "" },
    -- ["icons"] = { "", "ﰕ" },
    ['icons'] = { 'ﱢ', '' },
    -- ["icons"] = { "", "" },
    -- ["icons"] = { "", "" },
  })
end

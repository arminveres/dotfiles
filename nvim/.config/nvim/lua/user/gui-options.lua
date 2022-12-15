local opts = { noremap = true, silent = true }

if vim.g.neovide then  -- neovide specific settings
  vim.g.neovide_transparency = 0.9
  vim.opt.guifont = { 'Iosevka Term:h12' }
  vim.keymap.set('i', '<S-Insert>', '<C-R>+', opts)
elseif vim.g.GuiLoaded then  -- nvim-qt
  -- Nvim-qt needs this kind of notation
  vim.opt.guifont = { 'Iosevka NF:h11' }
  vim.keymap.set('i', '<S-Insert>', '<C-R>+', opts)
end

if vim.fn.has('win32') == 1 then -- Windows specific options
  vim.g.grayout_libclang_path = 'C:\\Program Files\\LLVM\\bin'
  vim.opt.shell = 'C:/Programme/Git/bin/bash.exe'
  vim.opt.shellcmdflag = '--login -i -c'
  vim.opt.shellxquote = ''
end

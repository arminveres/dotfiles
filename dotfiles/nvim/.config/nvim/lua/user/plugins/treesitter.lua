local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
  vim.notify("treesitter not ok")
  return
end

ts.define_modules {
  fold = {
    attach = function()
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldmethod = 'expr'
      vim.cmd 'normal zx' -- force reevaluate folds
      vim.cmd 'normal zR' -- reopen all folds
    end,
    detach = function() end,
  }
}


local status_ok, tsconf = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  vim.notify("ts configs not ok")
  return
end

tsconf.setup {
  ensure_installed = "all", -- one of "all", "maintained" (deprecated), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  fold = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
-- possible modules for treesitter:
-- textobjects
-- refactor

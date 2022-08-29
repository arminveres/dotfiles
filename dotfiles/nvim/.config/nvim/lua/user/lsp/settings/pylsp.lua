return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          --[[ ignore = { 'W391' }, ]]
          maxLineLength = 100
        },
        rope_completion = {
          enabled = true,
        }
      }
    }
  }
}

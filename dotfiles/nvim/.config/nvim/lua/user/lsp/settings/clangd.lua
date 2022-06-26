return {
  cmd = {
    "clangd",
    "--background-index",
    "--cross-file-rename",
    "--header-insertion=never",
    "--clang-tidy",
    "-j=8",
    -- "-fallback-style='{BasedOnStyle: Google, AccessModifierOffset: -1}'",
    -- "--inlay-hints",
    -- "--offset-encoding=utf-8",
  }
}

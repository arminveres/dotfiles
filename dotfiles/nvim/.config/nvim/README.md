#### TODO

- [ ] Move from `lsp-installer` to `mason.nvim`
- [ ] add debug protocol DAP [nvim-dap](https://github.com/mfussenegger/nvim-dap)
      and [dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [ ] add [lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)
- JAVA
  - [ ] leverage 'codelens'
  - [ ] install jdtls nvim

#### DONE

- [x] update config to 0.7 APIs
- Telescope
  - [x] add cursor relative lsp code action menu (achieved with dressing.nvim)
  - [x] add on word grep search (not having to call and type manually in the word I'm looking for in the project's scope)
- [x] fix `clangd_extensions` still not working (both probably regular and the extensions gets called,
      which conflicts)
- [x] move over to `lsp-saga.nvim` (potentially remove `dressing.nvim`)

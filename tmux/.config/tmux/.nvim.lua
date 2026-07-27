vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "tmux.conf", ".tmux.conf", "tmux.remote.conf" },
	callback = function()
		vim.lsp.start({
			name = "tmux",
			cmd = { "tmux-language-server" },
		})
	end,
})

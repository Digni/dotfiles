return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", {})
		vim.keymap.set("n", "<leader>tT", ":TestFile<CR>", {})
		vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", {})
		vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", {})
		--vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})
		vim.cmd("let test#strategy = 'vimux'")
	end,
}

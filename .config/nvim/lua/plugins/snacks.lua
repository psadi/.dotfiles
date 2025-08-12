return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		terminal = {},
		lazygit = {},
		indent = {},
	},
	map("n", "<leader>gg", "<cmd>lua Snacks.lazygit()<CR>", { noremap = true, silent = true }),
	map("n", "<c-\\>", "<cmd>lua Snacks.terminal.open()<CR>", { noremap = true, silent = true }),
}

return {
	"deparr/tairiki.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tairiki").setup({})
		require("tairiki").load()
		require("tairiki").load()
	end,
}

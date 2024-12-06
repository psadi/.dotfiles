return {
	"deparr/tairiki.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tairiki").setup({
			transparent = true,
		})
		require("tairiki").load()
	end,
}

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight.colors").setup({
			style = "night",
		})
	end,
}

return {
	"echasnovski/mini.nvim",
	version = "false",
	config = function()
		require("mini.comment").setup()
		require("mini.files").setup()
		require("mini.pairs").setup()
		require("mini.starter").setup({ evaluate_single = true })
		require("mini.statusline").setup()
		require("mini.surround").setup()
	end,
}

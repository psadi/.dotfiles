return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
			},
			no_italic = true,
			integrations = {
				gitsigns = true,
				treesitter = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}

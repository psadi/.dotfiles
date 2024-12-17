return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			integrations = {
				blink_cmp = true,
				mini = {
					enabled = true,
					indentscope_color = "lavender",
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

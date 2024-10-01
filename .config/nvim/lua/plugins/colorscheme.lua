return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "main",
			dark_variant = "main",
			dim_inactive_windows = true,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true,
				migrations = true,
			},

			styles = {
				italic = false,
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
}

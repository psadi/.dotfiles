return {
	"stevearc/oil.nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		})
	end,
}

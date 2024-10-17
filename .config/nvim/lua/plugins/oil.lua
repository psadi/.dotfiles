return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		})
	end,
}

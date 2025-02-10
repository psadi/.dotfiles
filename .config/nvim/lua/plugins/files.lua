return {
	{
		"ibhagwan/fzf-lua",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("fzf-lua").setup({})
		end,
	},
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("oil").setup({
				delete_to_trash = true,
				view_options = {
					show_hidden = true,
				},
			})
		end,
	},
}

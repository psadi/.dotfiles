return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local config = require("nvim-treesitter.configs")

			config.setup({
				auto_install = true,
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "auto",
					globalstatus = true,
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		event = "VeryLazy",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = false,
			lualine_bold = true,
		},
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		config = function()
			require("quicker").setup()
		end,
	},
}

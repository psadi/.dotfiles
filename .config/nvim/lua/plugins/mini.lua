return {
	{
		"nvim-mini/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"nvim-mini/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"nvim-mini/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup({
				draw = {
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "│",
			})
		end,
	},
	{
		"nvim-mini/mini.trailspace",
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	{
		"nvim-mini/mini.starter",
		version = false,
		config = function()
			require("mini.starter").setup()
		end,
	},
	{
		"nvim-mini/mini.pick",
		version = false,
		config = function()
			require("mini.pick").setup()
		end,
	},
}

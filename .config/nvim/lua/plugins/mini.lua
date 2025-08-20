return {
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.icons",
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
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
		"echasnovski/mini.trailspace",
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	{
		"echasnovski/mini.starter",
		version = false,
		config = function()
			require("mini.starter").setup()
		end,
	},
}

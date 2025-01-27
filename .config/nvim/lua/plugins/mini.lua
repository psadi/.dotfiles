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
				delay = 0,
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
}

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
		"nvim-mini/mini.trailspace",
		version = false,
		config = function()
			require("mini.trailspace").setup()
		end,
	},
}

return {
	"blazkowolf/gruber-darker.nvim",
	config = function()
		require("gruber-darker").setup({
			italic = {
				strings = false,
			},
		})
	end,
}

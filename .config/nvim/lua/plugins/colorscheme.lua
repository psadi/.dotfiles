return {
	"blazkowolf/gruber-darker.nvim",
	config = function()
		require("gruber-darker").setup({
			italic = {
				strings = false,
				comments = true,
				operators = false,
				folds = false,
			},
		})
		vim.cmd.colorscheme("gruber-darker")
	end,
}

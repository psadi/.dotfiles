return {
	"thimc/gruber-darker.nvim",
	config = function()
		require("gruber-darker").setup({
			transparent = false,
			underline = true,
			bold = true,
		})
		vim.cmd.colorscheme("gruber-darker")
	end,
}

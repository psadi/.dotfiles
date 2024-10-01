return {
	"olivercederborg/poimandres.nvim",
	config = function()
		require("poimandres").setup({
			disable_italics = true,
			dim_nc_background = true,
		})
		vim.cmd("colorscheme poimandres")
	end,
}

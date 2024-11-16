return {
	"morhetz/gruvbox",
	config = function()
		vim.o.background = "dark"
		vim.cmd("let g:gruvbox_contrast_dark = 'hard'")
		vim.cmd("colorscheme gruvbox")
	end,
}

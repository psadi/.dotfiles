vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user.treesitter", {}),
	pattern = {
		"bash",
		"go",
		"gomod",
		"gowork",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"sh",
		"terraform",
		"terraform-vars",
		"yaml",
	},
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		globalstatus = true,
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
})

vim.cmd("colorscheme kanagawa")

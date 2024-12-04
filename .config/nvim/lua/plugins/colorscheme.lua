return {
	-- "deparr/tairiki.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("tairiki").setup({
	-- 		transparent = true,
	-- 	})
	-- 	require("tairiki").load()
	-- end,
	"Mofiqul/vscode.nvim",
	config = function()
		require("vscode").setup({
			transparent = true,
		})
		vim.cmd.colorscheme("vscode")
	end,
}

return {
	"akinsho/toggleterm.nvim",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	lazy = false,
	config = function()
		require("toggleterm").setup({
			direction = "tab",
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			auto_scroll = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local git = Terminal:new({ cmd = "lazygit", hidden = true })

		function GitToggle()
			git:toggle()
		end

		map("n", "<leader>lg", "<cmd>lua GitToggle()<CR>", { noremap = true, silent = true })
	end,
}

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

		-- Lazygit
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

		function GitToggle()
			lazygit:toggle()
		end

		map("n", "<leader>lg", "<cmd>lua GitToggle()<CR>", { noremap = true, silent = true })

		-- Opencode
		local opencode = Terminal.new({ cmd = "opencode", hidden = true })

		function OpenCodeToggle()
			opencode:toggle()
		end

		map("n", "<leader>ai", "<cmd>lua OpenCodeToggle()<CR>", { noremap = true, silent = true })
	end,
}

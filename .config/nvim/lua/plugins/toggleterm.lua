return {
	"akinsho/toggleterm.nvim",
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	lazy = false,
	config = function()
		require("toggleterm").setup({
			direction = "tab",
			-- open_mapping = [[<c-`>]],
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			auto_scroll = true,
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
		local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })
		local k9s = Terminal:new({ cmd = "k9s --logoless --headless --readonly --crumbsless", hidden = true })
		local yazi = Terminal:new({ cmd = "yazi", hidden = true })

		function LazyGitToggle()
			lazygit:toggle()
		end

		function LazyDockerToggle()
			lazydocker:toggle()
		end

		function K9sToggle()
			k9s:toggle()
		end

		function YaziToggle()
			yazi:toggle()
		end
		map("n", "<leader>lg", "<cmd>lua LazyGitToggle()<CR>", { noremap = true, silent = true })
		map("n", "<leader>ld", "<cmd>lua LazyDockerToggle()<CR>", { noremap = true, silent = true })
		map("n", "<leader>k9", "<cmd>lua K9sToggle()<CR>", { noremap = true, silent = true })
		map("n", "<leader>yz", "<cmd>lua YaziToggle()<CR>", { noremap = true, silent = true })
	end,
}

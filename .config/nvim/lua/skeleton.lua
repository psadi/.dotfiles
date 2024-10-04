local M = {}

function M.setup()
	M.path = vim.fn.expand("$HOME/.config/nvim/skeletons")
end

local function pick()
	-- get the selected filename
	local line = vim.api.nvim_get_current_line()

	-- read the content of the skeleton file
	local path = M.path .. "/" .. line
	local lines = vim.fn.readfile(path)

	-- add an empty line at the end for visual separation
	table.insert(lines, #lines + 1, "")

	-- close the popover
	vim.api.nvim_win_close(0, false)

	-- insert read lines at current cursor position in current buffer
	local current = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_buf_set_text(0, current[1] - 1, 0, current[1] - 1, 0, lines)
end

function M.show()
	-- read all file names in the skeleton directory and filter them by the
	-- file type of the current buffer
	local lines = vim.fn.systemlist({ "ls", M.path })
	local filtered = {}
	for _, v in ipairs(lines) do
		if string.find(v, vim.bo.filetype) then
			table.insert(filtered, v)
		end
	end

	-- create a new unlisted scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- read UI attributes
	local ui = vim.api.nvim_list_uis()[1]

	-- open a floating window with the scratch buffer and turn off most features
	-- like a statusline or autocmds
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = 50,
		height = 10,
		col = ui.width / 2 - 25,
		row = ui.height / 2 - 5,
		anchor = "NW",
		style = "minimal",
		border = "rounded",
		noautocmd = true,
	})

	-- register pick function to Enter key or leave with Escape
	vim.api.nvim_buf_create_user_command(0, "Pick", pick, {})
	local opts = { silent = true, nowait = true, noremap = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "<Enter>", ":Pick<cr>", opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", ":close<cr>", opts)

	-- set the list of file names into the scratch buffer
	vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, filtered)
	vim.bo.modifiable = false
end

return M

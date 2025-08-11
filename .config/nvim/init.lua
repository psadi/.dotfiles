-- Keymaps
vim.g.mapleader = " "

map = vim.keymap.set
cmd = vim.cmd
set = cmd.set
opt = cmd.opt

set("expandtab")
set("tabstop=4")
set("softtabstop=4")
set("shiftwidth=4")
set("relativenumber")
set("colorcolumn=80")
set("shortmess+=I")
set("t_Co=256")
set("termguicolors")
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "•", extends = ">", precedes = "<", nbsp = "%" }
vim.o.statusline = "%<%f %l,%c%V"

opt = false

map("n", "<c-l>", ":nohlsearch<CR>")
map("n", "<leader>bd", "<CMD>bd<CR>", { silent = true })
map("n", "<leader>BD", "<CMD>bd!<CR>", { silent = true })
map("n", "<leader>qq", "<CMD>q!<CR>", { silent = true })
map("n", "<leader>%", "<CMD>source %<CR>", { desc = "Source Config" })
vim.api.nvim_set_keymap("n", "<leader>w", ":set list!<CR>", { noremap = true, silent = true })

-- MiniDeps: https://github.com/echasnovski/mini.deps
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
	cmd('echo "Installing `mini.deps`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.deps",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	cmd("packadd mini.deps | helptags ALL")
	cmd('echo "Installed `mini.deps`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local add = MiniDeps.add
map("n", "<leader>dc", "<CMD>DepsClean<CR>", {silent=true})
map("n", "<leader>du", "<CMD>DepsUpdate<CR>", {silent=true})

-- FzfLua: http://github.com/ibhagwan/fzf-lua
add({
	source = "ibhagwan/fzf-lua",
	depends = { "echasnovski/mini.icons" },
	config = function() end,
})

require("fzf-lua").setup({})

map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
map("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
map("n", "<leader>fg", "<CMD>FzfLua grep_visual<CR>", { silent = true })
map("n", "<leader>gC", "<CMD>FzfLua git_commits<CR>", { silent = true })
map("n", "<leader>gS", "<CMD>FzfLua git_status<CR>", { silent = true })
map("n", "<leader>gB", "<CMD>FzfLua git_branches<CR>", { silent = true })
map("n", "<leader>gT", "<CMD>FzfLua git_tags<CR>", { silent = true })
map("n", "<leader>H", "<CMD>FzfLua search_history<CR>", { silent = true })
map("n", "<leader>K", "<CMD>FzfLua keymaps<CR>", { silent = true })

-- Oil: https://github.com/stevearc/oil.nvim
add({
	source = "stevearc/oil.nvim",
	depends = { "echasnovski/mini.icons" },
})

require("oil").setup({
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
	},
})

map("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Treesitter: https://github.com/nvim-treesitter/nvim-treesitter
add({
	source = "nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
})

require("nvim-treesitter.configs").setup({
	auto_install = true,
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-- MiniCompletion: https://github.com/echasnovski/mini.completion
add({
	source = "echasnovski/mini.completion",
})

require("mini.completion").setup()

-- MiniTrailspace: https://github.com/echasnovski/mini.trailspace
add({
	source = "echasnovski/mini.trailspace",
})

require("mini.trailspace").setup()

map("n", "<leader>tr", "<CMD>lua MiniTrailspace.trim()<CR>", { silent = true })
map("n", "<leader>ltr", "<CMD>lua MiniTrailspace.trim_last_lines()<CR>", { silent = true })

-- ColorScheme: Gruvbox: https://github.com/ellisonleao/gruvbox.nvim

add({
	source = "rebelot/kanagawa.nvim",
})

-- require("rose-pine").setup({
-- 	-- contrast = "hard",
-- })

cmd("colorscheme kanagawa")

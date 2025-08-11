-- Opts
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

-- Install Packages
vim.pack.add({
	"https://github.com/echasnovski/mini.completion",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/echasnovski/mini.trailspace",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/stevearc/oil.nvim",
})

-- ColorScheme
cmd("colorscheme kanagawa")

-- Load Plugins
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.trailspace").setup()
require("fzf-lua").setup({})
require("oil").setup({
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
	},
})
require("nvim-treesitter.configs").setup({
	auto_install = true,
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

-- Keymaps
map("n", "<c-l>", ":nohlsearch<CR>")
map("n", "<leader>bd", "<CMD>bd<CR>", { silent = true })
map("n", "<leader>BD", "<CMD>bd!<CR>", { silent = true })
map("n", "<leader>qq", "<CMD>q!<CR>", { silent = true })
map("n", "<leader>%", "<CMD>source %<CR>", { desc = "Source Config" })
vim.api.nvim_set_keymap("n", "<leader>w", ":set list!<CR>", { noremap = true, silent = true })
map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
map("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
map("n", "<leader>fg", "<CMD>FzfLua grep_visual<CR>", { silent = true })
map("n", "<leader>gC", "<CMD>FzfLua git_commits<CR>", { silent = true })
map("n", "<leader>gS", "<CMD>FzfLua git_status<CR>", { silent = true })
map("n", "<leader>gB", "<CMD>FzfLua git_branches<CR>", { silent = true })
map("n", "<leader>gT", "<CMD>FzfLua git_tags<CR>", { silent = true })
map("n", "<leader>H", "<CMD>FzfLua search_history<CR>", { silent = true })
map("n", "<leader>K", "<CMD>FzfLua keymaps<CR>", { silent = true })
map("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>tr", "<CMD>lua MiniTrailspace.trim()<CR>", { silent = true })
map("n", "<leader>ltr", "<CMD>lua MiniTrailspace.trim_last_lines()<CR>", { silent = true })


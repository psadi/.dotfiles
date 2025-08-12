-- Opts
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.set("expandtab")
vim.cmd.set("tabstop=4")
vim.cmd.set("softtabstop=4")
vim.cmd.set("shiftwidth=4")
vim.cmd.set("relativenumber")
vim.cmd.set("colorcolumn=80")
vim.cmd.set("shortmess+=I")
vim.cmd.set("t_Co=256")
vim.cmd.set("termguicolors")
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "•", extends = ">", precedes = "<", nbsp = "␣" }
vim.opt.winborder = "rounded"
vim.opt.statusline = "%<%f %l,%c%V"

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
vim.cmd("colorscheme kanagawa")

-- Load Plugins
-- require("mini.completion").setup()
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

-- Keyvim.keymap.sets
vim.keymap.set("n", "<c-l>", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>bd", "<CMD>bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>BD", "<CMD>bd!<CR>", { silent = true })
vim.keymap.set("n", "<leader>qq", "<CMD>q!<CR>", { silent = true })
vim.keymap.set("n", "<leader>%", "<CMD>source %<CR>", { desc = "Source Config" })
vim.api.nvim_set_keymap("n", "<leader>w", ":set list!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", "<CMD>FzfLua grep_visual<CR>", { silent = true })
vim.keymap.set("n", "<leader>gC", "<CMD>FzfLua git_commits<CR>", { silent = true })
vim.keymap.set("n", "<leader>gS", "<CMD>FzfLua git_status<CR>", { silent = true })
vim.keymap.set("n", "<leader>gB", "<CMD>FzfLua git_branches<CR>", { silent = true })
vim.keymap.set("n", "<leader>gT", "<CMD>FzfLua git_tags<CR>", { silent = true })
vim.keymap.set("n", "<leader>H", "<CMD>FzfLua search_history<CR>", { silent = true })
vim.keymap.set("n", "<leader>K", "<CMD>FzfLua keyvim.keymap.sets<CR>", { silent = true })
vim.keymap.set("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>tr", "<CMD>lua MiniTrailspace.trim()<CR>", { silent = true })
vim.keymap.set("n", "<leader>ltr", "<CMD>lua MiniTrailspace.trim_last_lines()<CR>", { silent = true })

-- Lsp
vim.lsp.enable({
	"lua_ls",
	"ruff",
	"rust_analyzer",
	"terraformls",
	"ansiblels.lua",
	"yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
	end,
})
-- Diagnostics
vim.diagnostic.config({
	-- virtual_lines = true,
	virtual_lines = {
		current_line = true,
	},
})

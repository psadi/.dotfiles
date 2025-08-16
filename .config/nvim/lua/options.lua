---@diagnostic disable: lowercase-global
vim.g.mapleader = " "

-- global keymaps
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
vim.opt.winborder = "rounded"

opt = false

-- General
map("n", "<c-l>", ":nohlsearch<CR>")
-- map("n", "<C-`>", "<CMD>terminal<CR>", { silent = true })
map("n", "<leader>bd", "<CMD>bd<CR>", { silent = true })
map("n", "<leader>BD", "<CMD>bd!<CR>", { silent = true })
map("n", "<leader>qq", "<CMD>q!<CR>", { silent = true })

-- Lazy
map("n", "ll", "<CMD>Lazy<CR>", {})

-- Mason
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gd", vim.lsp.buf.definition, {})
map("n", "lm", "<CMD>Mason<CR>", {})

-- Fzf Lua
map("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
map("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
map("n", "<leader>fg", "<CMD>FzfLua grep_visual<CR>", { silent = true })
map("n", "<leader>gC", "<CMD>FzfLua git_commits<CR>", { silent = true })
map("n", "<leader>gS", "<CMD>FzfLua git_status<CR>", { silent = true })
map("n", "<leader>gB", "<CMD>FzfLua git_branches<CR>", { silent = true })
map("n", "<leader>gT", "<CMD>FzfLua git_tags<CR>", { silent = true })
map("n", "<leader>H", "<CMD>FzfLua search_history<CR>", { silent = true })
map("n", "<leader>K", "<CMD>FzfLua keymaps<CR>", { silent = true })
map({ "n", "v" }, "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", {})

-- Oil
map("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Reload Config
map("n", "<leader>%", "<CMD>source %<CR>", { desc = "Source Config" })

-- Toggle Whitespaces
vim.api.nvim_set_keymap("n", "<leader>w", ":set list!<CR>", { noremap = true, silent = true })

-- Mini TrailSpace
map("n", "<leader>tr", "<CMD>lua MiniTrailspace.trim()<CR>", { silent = true })
map("n", "<leader>ltr", "<CMD>lua MiniTrailspace.trim_last_lines()<CR>", { silent = true })

---@diagnostic disable: lowercase-global
vim.g.mapleader = " "
vim.wo.number = true
vim.opt.guifont = { "MonoLisa Nerd Font", ":h16" }


-- global keymaps
map = vim.keymap.set
cmd = vim.cmd
set = cmd.set
opt = cmd.opt

set("expandtab")
set("tabstop=2")
set("softtabstop=2")
set("shiftwidth=2")
set("relativenumber")
set("colorcolumn=80")
set("shortmess+=I")
cmd("colorscheme default")

opt = false

-- Navigate vim panes better
map("n", "<c-k>", ":wincmd k<CR>")
map("n", "<c-j>", ":wincmd j<CR>")
map("n", "<c-h>", ":wincmd h<CR>")
map("n", "<c-l>", ":wincmd l<CR>")

-- General
map("n", "<leader>h", ":nohlsearch<CR>")
map("n", "<C-`>", "<CMD>terminal<CR>", { silent = true })
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

map("n", "<leader>ss", require("skeleton").show, {})

vim.g.mapleader = " "
vim.wo.number = true

-- global keymaps
Vmap = vim.keymap.set
Vcmd = vim.cmd.set
Vopt = vim.cmd.opt

Vcmd "expandtab"
Vcmd "tabstop=2"
Vcmd "softtabstop=2"
Vcmd "shiftwidth=2"
Vcmd "relativenumber"

Vopt = false

-- Navigate vim panes better
Vmap('n', '<c-k>', ':wincmd k<CR>')
Vmap('n', '<c-j>', ':wincmd j<CR>')
Vmap('n', '<c-h>', ':wincmd h<CR>')
Vmap('n', '<c-l>', ':wincmd l<CR>')

-- General
Vmap('n', '<leader>h', ':nohlsearch<CR>')
Vmap("n", "<C-`>", "<CMD>terminal<CR>", { silent = true })
Vmap("n", "<leader>bd", "<CMD>bd<CR>", { silent = true })
Vmap("n", "<leader>BD", "<CMD>bd!<CR>", { silent = true })
Vmap("n", "<leader>qq", "<CMD>q!<CR>", { silent = true })

-- Lazy
Vmap('n', "l", "<CMD>Lazy<CR>", {})

-- Mason
Vmap('n', "<C-X>", "<CMD>Mason<CR>", {})
Vmap('n', "K", vim.lsp.buf.hover, {})
Vmap('n', "gd", vim.lsp.buf.definition, {})
Vmap('n', "cm", "<CMD>Mason<CR>", {})

-- Fzf Lua
Vmap("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
Vmap("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
Vmap("n", "<leader>f/", "<CMD>FzfLua grep_visual<CR>", { silent = true })
Vmap({ 'n', 'v' }, "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", {})

-- Oil
Vmap("n", "_", "<CMD>Oil<CR>", { desc = "Open parent directory" })

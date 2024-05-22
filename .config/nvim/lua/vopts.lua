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

Vopt = false

-- Navigate vim panes better
Vmap('n', '<c-k>', ':wincmd k<CR>')
Vmap('n', '<c-j>', ':wincmd j<CR>')
Vmap('n', '<c-h>', ':wincmd h<CR>')
Vmap('n', '<c-l>', ':wincmd l<CR>')

Vmap('n', '<leader>h', ':nohlsearch<CR>')

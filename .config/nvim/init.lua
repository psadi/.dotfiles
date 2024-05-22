Vmap = vim.keymap.set
vim.cmd.set "expandtab"
vim.cmd.set "tabstop=2"
vim.cmd.set "softtabstop=2"
vim.cmd.set "shiftwidth=2"
vim.g.mapleader = " "

-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- KeyVmaps
Vmap("n", "<C-`>", "<CMD>terminal<CR>", { silent = true })
Vmap("n", "<leader>q", "<CMD>bd<CR>", { silent = true })
Vmap("n", "<leader>Q", "<CMD>bd!<CR>", { silent = true })

---@diagnostic disable: lowercase-global
vim.g.mapleader = " "
vim.wo.number = true

-- global keymaps
map = vim.keymap.set
cmd = vim.cmd.set
opt = vim.cmd.opt

cmd("expandtab")
cmd("tabstop=2")
cmd("softtabstop=2")
cmd("shiftwidth=2")
cmd("relativenumber")
cmd("colorcolumn=80")

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
map("n", "l", "<CMD>Lazy<CR>", {})

-- Mason
map("n", "<C-X>", "<CMD>Mason<CR>", {})
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gd", vim.lsp.buf.definition, {})
map("n", "cm", "<CMD>Mason<CR>", {})

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
-- map("n", "_", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open parent directory" })


-- Neogit
map("n", "<leader>gg", "<CMD>Neogit<CR>", {})
map("n", "<leader>gc", "<CMD>Neogit commit<CR>", {})
map("n", "<leader>gl", "<CMD>Neogit log<CR>", {})
map("n", "<leader>gp", "<CMD>Neogit pull<CR>", {})
map("n", "<leader>gP", "<CMD>Neogit push<CR>", {})
map("n", "<leader>gf", "<CMD>Neogit fetch<CR>", {})
map("n", "<leader>gb", "<CMD>Neogit branch<CR>", {})
map("n", "<leader>gd", "<CMD>Neogit diff<CR>", {})
map("n", "<leader>gr", "<CMD>Neogit rebase<CR>", {})
map("n", "<leader>gw", "<CMD>Neogit worktree<CR>", {})
map("n", "<leader>gm", "<CMD>Neogit commit --amend<CR>", {})

-- map("n", "_", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open parent directory" })
-- Reload Config
map("n", "<leader>%", "<CMD>source %<CR>", { desc = "Source Config" })

-- Zig
function ZigBuild()
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("terminal zig build")
  vim.cmd("startinsert")
end

vim.api.nvim_set_keymap("n", "<leader>zb", ":lua ZigBuild()<CR>", { noremap = true, silent = true })

vim.cmd([[
  autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>:bd!<CR>
]])

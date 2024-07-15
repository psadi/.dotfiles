return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({})
    vim.keymap.set("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
    vim.keymap.set("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
    vim.keymap.set("n", "<leader>/", "<CMD>FzfLua grep_visual<CR>", { silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", {})
  end,
}

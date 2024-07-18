return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({})
    Vmap("n", "<leader>ff", "<CMD>FzfLua files<CR>", { silent = true })
    Vmap("n", "<leader>fb", "<CMD>FzfLua buffers<CR>", { silent = true })
    Vmap("n", "<leader>f/", "<CMD>FzfLua grep_visual<CR>", { silent = true })
    Vmap({ 'n', 'v' }, "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>", {})
  end
}

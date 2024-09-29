return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("toggleterm").setup({
      direction = "float",
      open_mapping = [[<c-`>]],
      hide_numbers = true,
      auto_scroll = true,
      -- float_opts = {
      --   border = "curved",
      --   width = 143,
      --   height = 34,
      -- },
    })

    local Terminal   = require('toggleterm.terminal').Terminal
    local lazygit    = Terminal:new({ cmd = "lazygit", hidden = true })
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })
    local k9s        = Terminal:new({ cmd = "k9s --logoless --headless --readonly --crumbsless", hidden = true })

    function LazyGitToggle()
      lazygit:toggle()
    end

    function LazyDockerToggle()
      lazydocker:toggle()
    end

    function K9sToggle()
      k9s:toggle()
    end

    map("n", "<leader>lg", "<cmd>lua LazyGitToggle()<CR>", { noremap = true, silent = true })
    map("n", "<leader>ld", "<cmd>lua LazyDockerToggle()<CR>", { noremap = true, silent = true })
    map("n", "<leader>k9", "<cmd>lua K9sToggle()<CR>", { noremap = true, silent = true })
  end
}

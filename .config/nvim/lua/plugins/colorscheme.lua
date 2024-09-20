return {
  -- "EdenEast/nightfox.nvim",
  -- config = function()
  --   vim.cmd("colorscheme carbonfox")
  -- end
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      styles = {
        italic = false,
      },

    })
    vim.cmd("colorscheme rose-pine")
  end
}

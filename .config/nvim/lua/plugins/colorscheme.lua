return {
--  "gmr458/vscode_modern_theme.nvim",
--  lazy = false,
--  priority = 1000,
--  config = function()
--    require("vscode_modern").setup({
--      cursorline = true,
--      transparent_background = false,
--      nvim_tree_darker = true,
--    })
--    vim.cmd.colorscheme("vscode_modern")
--  end,
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup {
        transparent = true,
        styles = {
           sidebars = "transparent",
           floats = "transparent",
        }
    }
    vim.cmd.colorscheme("tokyonight")
  end
}

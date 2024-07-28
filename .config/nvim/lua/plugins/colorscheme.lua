return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    require("tokyonight").setup({
      transparent = true,
      styles = {
         sidebars = "transparent",
         floats = "transparent",
      }
    })
    vim.cmd[[colorscheme tokyonight]]
  end
--  "ellisonleao/gruvbox.nvim",
--  priority = 1000,
--  config = function()
--    require("gruvbox").setup({
--      terminal_colors = true,
--      undercurl = true,
--      underline = true,
--      bold = true,
--      italic = {
--        strings = true,
--        emphasis = true,
--        comments = true,
--        operators = false,
--        folds = true,
--      },
--      strikethrough = true,
--      invert_selection = false,
--      invert_signs = false,
--      invert_tabline = false,
--      invert_intend_guides = false,
--      inverse = true,
--      contrast = "hard",
--      palette_overrides = {},
--      overrides = {},
--      dim_inactive = false,
--      transparent_mode = true,
--    })
--    vim.o.background = "dark"
--    vim.cmd("colorscheme gruvbox")
--  end
}

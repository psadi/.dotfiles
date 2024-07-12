return {
--  "lunarvim/darkplus.nvim",
--  name = "darkplus",
--  priority = 1000,
--  config = function()
--    vim.cmd.colorscheme "darkplus"
  "morhetz/gruvbox",
  name = "gruvbox",
  priority = 1000,
  config = function()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.cmd.colorscheme "gruvbox"
  end
}

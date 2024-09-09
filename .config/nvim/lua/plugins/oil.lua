return {
  'stevearc/oil.nvim',
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("oil").setup()
  end
}

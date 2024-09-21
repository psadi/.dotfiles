return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require("mini.pairs").setup()
    require("mini.comment").setup()
    require("mini.icons").setup()
    require("mini.starter").setup()
    require("mini.surround").setup()
    require('mini.operators').setup()
  end
}

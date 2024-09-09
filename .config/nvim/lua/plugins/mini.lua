return {
  {
    "echasnovski/mini.pairs",
    version = "false",
    config = function()
      require("mini.pairs").setup({
        defaults = { lazy = true }
      })
    end,
  },
  {
    "echasnovski/mini.comment",
    version = "false",
    config = function()
      require("mini.comment").setup({
        defaults = { lazy = true }
      })
    end,
  },
  {
    "echasnovski/mini.starter",
    version = "false",
    config = function()
      require("mini.starter").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "false",
    config = function()
      require("mini.surround").setup({
        defaults = { lazy = true }
      })
    end,
  },
}

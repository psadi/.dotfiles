return {
  {
    "echasnovski/mini.files",
    version = "false",
    config = function()
      require("mini.files").setup({
        defaults = { lazy = true }
      })
    end,
  },
}

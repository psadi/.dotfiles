return {
  {
    "echasnovski/mini.statusline",
    version = "false",
    config = function()
      require("mini.statusline").setup({
        defaults = { lazy = true }
      })
    end,
  },
}

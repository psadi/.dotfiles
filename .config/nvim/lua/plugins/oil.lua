return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup({
      delete_to_trash = true,
    })
  end
}

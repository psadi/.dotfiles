return {
  "echasnovski/mini.nvim",
  version = '*',
  config = function()
    require('mini.starter').setup({
      query_updaters = ''
    })
  end
}

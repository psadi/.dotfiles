return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    vim.cmd("colorscheme Carbonfox")
    require('lualine').setup {
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
      }
    }
  end
}

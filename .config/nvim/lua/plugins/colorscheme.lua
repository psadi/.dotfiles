return {
  -- "lunarvim/darkplus.nvim",
  -- name = "darkplus",
  -- priority = 1000,
  -- config = function()
  --   vim.cmd.colorscheme "darkplus"
  -- end
    "baliestri/aura-theme",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      vim.cmd([[colorscheme aura-dark]])
    end

}

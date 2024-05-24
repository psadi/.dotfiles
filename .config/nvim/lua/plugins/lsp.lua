return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "ruff_lsp", "zls" },
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.ruff.setup {}
      lspconfig.ruff_lsp.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      lspconfig.zls.setup({})

      Vmap('n', "<C-X>", "<CMD>Mason<CR>", {})
      Vmap('n', "K", vim.lsp.buf.hover, {})
      Vmap('n', "gd", vim.lsp.buf.definition, {})
    end
  }
}

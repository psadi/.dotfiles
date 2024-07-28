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
        ensure_installed = { "lua_ls", "zls", "ruff", "ruff_lsp" },
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "ms-jpq/coq_nvim",       branch = "coq" },
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { 'ms-jpq/coq.thirdparty', branch = "3p" }
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = 'shut-up',

        -- Your COQ settings here
      }
    end,
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.ruff.setup {}
      lspconfig.ruff_lsp.setup({
        init_options = {
          settings = {
            args = {},
          }
        }
      })
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
    end
  },
}

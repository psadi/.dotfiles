return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ruff", "ruff_lsp", "pyright", "gopls", "zls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "ms-jpq/coq_nvim",       branch = "coq" },
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = "shut-up",

        -- Your COQ settings here
      }
    end,
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        if client.name == "ruff_lsp" then
          client.server_capabilities.hoverProvider = false
        end
      end
      lspconfig.pyright.setup({
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              ignore = { "*" },
            },
          },
        },
      })
      lspconfig.ruff_lsp.setup({
        on_attach = on_attach,
        init_options = {
          settings = {
            args = {},
          },
        },
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      -- lspconfig.zls.setup({})
      lspconfig.gopls.setup({})
    end,
  },
}

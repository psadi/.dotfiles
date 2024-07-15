return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "ansible-lint",
        "yamllint",
        "ruff",
        "mypy",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ruff_lsp",
          "zls",
          "ansiblels",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.ruff.setup({})
      lspconfig.ruff_lsp.setup({
        -- on_attach = on_attach,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
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
      lspconfig.zls.setup({})
      lspconfig.ansiblels.setup({})
    end,
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = function()
      local opts = {
        format = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          python = { "ruff_format" },
          go = { "gofmt" },
          zig = { "zigfmt" },
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        },
      }
      return opts
    end,
  },
}

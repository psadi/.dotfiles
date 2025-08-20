return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ruff", "pyright", "terraformls", "gopls", "rust_analyzer" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "saghen/blink.cmp" },
		opts = {
			inlay_hints = { enabled = false },
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end
			lspconfig.pyright.setup({
				capabilities = capabilities,
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
			lspconfig.ruff.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = {
					settings = {
						args = {},
					},
				},
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
		end,
	},
	{
		"benomahony/uv.nvim",
		opts = {
			picker_integration = true,
		},
	},
}

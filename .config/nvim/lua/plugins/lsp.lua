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
				ensure_installed = { "lua_ls", "ruff", "pyright", "gopls" },
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		event = { "LspAttach" },
		version = "v0.*",
		dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
			},
			-- appearance = {
			-- 	use_nvim_cmp_as_default = true,
			-- },
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		-- list = { selection = {
		-- 	preselect = function(ctx)
		-- 		return ctx.mode ~= "cmdline"
		-- 	end,
		-- } },
		opts_extend = { "sources.default" },
		menu = {
			-- documentation = { auto_show = true, auto_show_delay_ms = 500 },
			ghost_text = { enabled = true },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
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
		end,
	},
}

return {
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					css = { "prettier" },
					go = { lsp_format = "fallback" },
					html = { "prettier" },
					json = { "prettier" },
					lua = { "stylua" },
					markdown = { "prettier" },
					python = { "ruff_format" },
					sh = { "shfmt" },
					yaml = { "prettier" },
				},
				format_on_save = {
					async = false,
					timeout_ms = 1000,
					lsp_fallback = true,
					lsp_format = "fallback",
				},
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			map({ "n", "v" }, "<leader>fmt", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file" })
		end,
	},
	{
		"zapling/mason-conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-conform").setup()
		end,
	},
}

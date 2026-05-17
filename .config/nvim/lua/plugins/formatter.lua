local format_group = vim.api.nvim_create_augroup("user.format", {})

local function format(bufnr)
	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
		return
	end

	vim.lsp.buf.format({
		bufnr = bufnr,
		timeout_ms = 1000,
		filter = function(client)
			return client.name ~= "ty"
		end,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = format_group,
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

		if not client:supports_method("textDocument/formatting") then
			return
		end

		vim.api.nvim_clear_autocmds({ group = format_group, buffer = event.buf })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = format_group,
			buffer = event.buf,
			callback = function()
				format(event.buf)
			end,
		})
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
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
	format(vim.api.nvim_get_current_buf())
end, { desc = "Format file" })

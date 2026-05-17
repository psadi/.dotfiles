local lsp = vim.lsp

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user.lsp", {}),
	callback = function(event)
		local client = assert(lsp.get_client_by_id(event.data.client_id))

		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
		end

		if client:supports_method("textDocument/completion") then
			lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})

lsp.config("ty", {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"ty.toml",
		".git",
	},
})

lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		".git",
	},
	init_options = {
		settings = {
			args = {},
		},
	},
})

lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"stylua.toml",
		".git",
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
})

lsp.config("terraformls", {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { ".terraform", ".git" },
})

lsp.enable({
	"gopls",
	"lua_ls",
	"ruff",
	"terraformls",
	"ty",
})

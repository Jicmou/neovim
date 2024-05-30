local lsp_zero = require("lsp-zero").preset({})
local lsp_config = require("lspconfig")

lsp_zero.preset("recommended")

---@diagnostic disable-next-line: unused-local
lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})

-- make sure these servers are installed
require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"eslint",
		"jsonls",
		"lua_ls",
		"marksman",
		"rust_analyzer",
		"stylelint_lsp",
		"taplo",
		"tsserver",
		"volar",
		"yamlls",
	},
})

-- TODO: Consider not to setup at all, since volar does decent job already.
-- TODO: Upgrade vue-language-server to version 2.
lsp_config.tsserver.setup({
	autostart = false,
})

lsp_config.eslint.setup({
	---@diagnostic disable-next-line: unused-local
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	workingDirectories = { mode = "auto" },
})

lsp_config.nginx_language_server.setup({
	filetypes = { "nginx" },
})

lsp_config.cssls.setup({})

lsp_config.yamlls.setup({
	on_attach = function(client)
		-- get first line of current buffer
		local firstLine = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]

		-- check if first lines begins with "apiVersion:"
		local isKubernetes = string.match(string.sub(firstLine, 1, 11), "apiVersion:")

		if isKubernetes then
			client.config.settings.yaml.schemas = {
				["Kubernetes"] = "/*.yaml",
			}

			client.notify("workspace/didChangeConfiguration", {
				settings = client.config.settings,
			})
		end
	end,

	settings = {
		yaml = {
			schemas = {},
		},
		redhat = { telemetry = { enabled = false } },
	},
})

lsp_config.volar.setup({
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
})

lsp_config.stylelint_lsp.setup({
	filetypes = {
		"css",
		"scss",
	},
})
--
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_config.jsonls.setup({
	filetypes = { "json", "jsonc" },
	provideFormatter = true,
	capabilities = capabilities,
})

-- (Optional) Configure lua language server for neovim
lsp_config.lua_ls.setup({
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Markdown language server
lsp_config.marksman.setup({})

lsp_config.rust_analyzer.setup({})

-- TOML language server
lsp_config.taplo.setup({})

lsp_zero.setup()

-- Make sure you setup `cmp` after lsp-zero
local cmp = require("cmp")

cmp.setup({
	-- completion = {
	--   autocomplete = false
	-- },
	mapping = {
		["<C-Space>"] = cmp.mapping.complete(),
	},
})

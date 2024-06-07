local lsp_config = require("lspconfig")

-- We need to get the vue-typescript-plugin path.
-- As it's a dependency of vue-language-server installed by Mason,
-- we get it from here.
local vue_typescript_plugin = "/home/jicmou/.local/share/nvim"
	.. "/mason/packages/vue-language-server/node_modules"
	.. "/@vue/language-server/node_modules"
	.. "/@vue/typescript-plugin"

lsp_config.tsserver.setup({
	init_options = {
		-- Mandatory for vue support, along with vue-language-server@2.x
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_typescript_plugin,
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},

	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue", -- We add vue here to have sfc covered by tsserver.
	},
})

local util = require("lspconfig.util")

-- We need to recursively find the local typescript package in monorepo
-- then fallback to a global version.
local function get_typescript_server_path(root_dir)
	-- Here we take the typescript dependency of vue-language-server
	-- as global fallback, when we can't find a local version.
	local global_ts = "/home/jicmou/.local/share/nvim"
		.. "/mason/packages/vue-language-server/node_modules"
		.. "/@vue/language-server/node_modules"
		.. "/typescript/lib"

	local found_ts = ""

	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end

	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

require("lspconfig").volar.setup({
	on_new_config = function(new_config, new_root_dir)
		new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
	end,
})

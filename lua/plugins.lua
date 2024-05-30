local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Install lazy
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Syntax highlighting on steroids
	"nvim-treesitter/nvim-treesitter",

	-- Awesome Fuzzy Finder
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		-- Lodash for lua
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Nice colorscheme
	{ "catppuccin/nvim", name = "catppuccin" },

	-- Classics from vim era. Tim Pope is THE pope.

	-- Do crazy stuff with strings
	-- Substitute: search and replace case sensitive and manages plural
	-- Coerction: easily convert string in camelCase, snake_case, TitleCase...
	"tpope/vim-abolish",

	-- Git integration so awesome it should be illegal
	"tpope/vim-fugitive",

	-- Should-be-builtin-kind-of-plugin
	-- Allows you to surround wih parens, quotes, tags ...
	"tpope/vim-surround",

	-- Git signs in gutter
	"airblade/vim-gitgutter",

	-- All-in-one formatters, It's kind of slow so not sure I'll keep it.
	"mhartington/formatter.nvim",

	-- ready-to-go lsp config ta have a nice start
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				cmd = function()
					---@diagnostic disable-next-line: param-type-mismatch
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},
})

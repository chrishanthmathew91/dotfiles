return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls", -- Neovim / Lua
				"ts_ls", -- JavaScript / TypeScript
				"html",
				"cssls",
				"eslint",
				-- Add back as needed: "tailwindcss", "svelte", "graphql", "emmet_ls", "prismals", "pyright"
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
				-- Python: "isort", "black", "pylint"
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
}

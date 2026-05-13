return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
			-- Performance optimizations for large projects
			settings = {
				-- Add file watching exclusions for common performance bottlenecks
				files = {
					watcherExclude = {
						["**/node_modules/**"] = true,
						["**/.git/**"] = true,
						["**/dist/**"] = true,
						["**/build/**"] = true,
						["**/coverage/**"] = true,
						["**/.nx/**"] = true,
						["**/ios/Pods/**"] = true,
						["**/android/.gradle/**"] = true,
						["**/DerivedData/**"] = true,
						["**/.yarn/**"] = true,
						["**/.jest-cache/**"] = true,
					},
				},
			},
			-- Limit memory usage
			init_options = {
				maxMemory = 4096, -- Limit LSP server memory to 4GB
			},
		})
	end,
}

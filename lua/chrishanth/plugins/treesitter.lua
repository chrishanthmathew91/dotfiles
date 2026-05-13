return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	-- Lazy will call: require("nvim-treesitter.configs").setup(opts)
	main = "nvim-treesitter.configs",
	opts = {
		highlight = {
			enable = true,
			disable = function(_, buf)
				local ok, n = pcall(vim.api.nvim_buf_line_count, buf)
				return ok and n > 10000
			end,
		},
		indent = {
			enable = true,
			disable = function(_, buf)
				local ok, n = pcall(vim.api.nvim_buf_line_count, buf)
				return ok and n > 10000
			end,
		},

		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"prisma",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		-- keep your language alias
		vim.treesitter.language.register("bash", "zsh")
	end,
}

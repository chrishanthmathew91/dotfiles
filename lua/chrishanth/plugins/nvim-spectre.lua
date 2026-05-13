return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>sr",
			function()
				require("spectre").open()
			end,
			desc = "Search & Replace (project)",
		},
		{
			"<leader>sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			mode = { "n", "x" },
			desc = "Search word (project)",
		},
		{
			"<leader>sf",
			function()
				require("spectre").open_file_search()
			end,
			mode = { "n", "x" },
			desc = "Search & Replace (current file)",
		},
		{
			"<leader>sF",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			mode = { "n", "x" },
			desc = "Search word (current file)",
		},
	},
	opts = {
		-- default uses ripgrep; respects .gitignore; supports per-file previews
	},
}

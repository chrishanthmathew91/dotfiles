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
			desc = "Search word",
		},
	},
	opts = {
		-- default uses ripgrep; respects .gitignore; supports per-file previews
	},
}

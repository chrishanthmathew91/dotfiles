return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indent = {
			enable = true,
			chars = { "│" },
			style = {
				"#E06C75",
				"#E5C07B",
				"#61AFEF",
				"#D19A66",
				"#98C379",
				"#C678DD",
				"#56B6C2",
			},
		},
		blank = { enable = false }, -- dots for blank lines if you want
		chunk = {
			enable = true, -- chunky braces/if blocks guides
			style = { "#5C6370" },
			duration = 0,
		},
		exclude_filetypes = { "help", "alpha", "neo-tree", "lazy" },
	},
	init = function()
		vim.opt.termguicolors = true
	end,
}

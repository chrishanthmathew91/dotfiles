return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local C = require("catppuccin.palettes").get_palette("mocha")
		require("hlchunk").setup({
			indent = {
				enable = true,
				chars = { "│" },
				style = {
					C.red,
					C.yellow,
					C.blue,
					C.peach,
					C.green,
					C.mauve,
					C.teal,
				},
			},
			blank = { enable = false },
			chunk = {
				enable = true,
				style = { C.overlay0 },
				duration = 0,
			},
			exclude_filetypes = { "help", "alpha", "neo-tree", "lazy" },
		})
	end,
	init = function()
		vim.opt.termguicolors = true
	end,
}

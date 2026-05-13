return {
	"petertriho/nvim-scrollbar",
	name = "scrollbar",
	event = "VeryLazy",
	dependencies = {
		"kevinhwang91/nvim-hlslens",
	},
	config = function()
		local scrollbar = require("scrollbar")
		local C = require("catppuccin.palettes").get_palette("mocha")
		local colors = {
			blue = C.blue,
			green = C.green,
			violet = C.mauve,
			yellow = C.yellow,
			red = C.red,
			orange = C.peach,
			cyan = C.teal,
		}

		scrollbar.setup({
			handle = {
				color = colors.blue,
			},
			marks = {
				Search = { color = colors.yellow },
				Error = { color = colors.red },
				Warn = { color = colors.orange },
				Info = { color = colors.blue },
				Hint = { color = colors.green },
				Misc = { color = colors.cyan },
			},
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"noice",
				"alpha",
			},
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = false, -- Requires gitsigns.nvim
				handle = true,
				search = false, -- Requires hlslens.nvim
			},
		})

		-- Enable hlslens for search highlighting
		require("hlslens").setup({
			calm_down = true,
			nearest_only = true,
			nearest_float_when = "always",
		})
	end,
}

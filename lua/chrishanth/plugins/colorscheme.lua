return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- keep in sync with get_palette("mocha") elsewhere & WezTerm Catppuccin Mocha
			transparent_background = true,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = { enabled = false },
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
			},
			default_integrations = true,
			custom_highlights = function(C)
				return {
					CursorLine = { bg = C.surface0 },
					CursorLineSign = { bg = C.surface0 },
					CursorLineNr = { fg = C.lavender, bold = true },
					LineNr = { fg = C.overlay0 },
					Visual = { bg = C.surface1 },
					Search = { bg = C.yellow, fg = C.base },
					CurSearch = { bg = C.pink, fg = C.base },
					Pmenu = { bg = C.mantle, fg = C.text },
					PmenuSel = { bg = C.surface1, fg = C.lavender },
					StatusLine = { bg = "NONE", fg = C.text },
					StatusLineNC = { bg = "NONE", fg = C.overlay0 },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}

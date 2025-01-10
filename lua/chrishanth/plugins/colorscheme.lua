return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			--- @usage 'auto'|'main'|'moon'|'dawn'
			variant = "moon",
			--- @usage 'main'|'moon'|'dawn'
			dark_variant = "moon",
			bold_vert_split = false,
			dim_nc_background = false,
			disable_background = true,
			disable_float_background = true,
			disable_italics = false,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = true,
      },

			--- @usage string hex value or named color from rosepinetheme.com/palette
			groups = {
				panel = "surface",
				panel_nc = "base",
				border = "highlight_med",
				comment = "muted",
				link = "iris",
				punctuation = "subtle",

				error = "love",
				hint = "iris",
				info = "foam",
				warn = "gold",

				headings = {
					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},
				-- or set all headings at once
				-- headings = 'subtle'
			},

			-- Change specific vim highlight groups
			-- https://github.com/rose-pine/neovim/wiki/Recipes
			highlight_groups = {
				ColorColumn = { bg = "rose" },

				-- Blend colours against the "base" background
				CursorLine = { bg = "foam", blend = 10 },
				StatusLine = { fg = "love", bg = "love", blend = 10 },

				-- By default each group adds to the existing config.
				-- If you only want to set what is written in this config exactly,
				-- you can set the inherit option:
				Search = { bg = "gold", inherit = false },
			},
		})
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

		vim.cmd([[colorscheme rose-pine]])
	end,
}

-- return {
-- 	"navarasu/onedark.nvim",
-- 	name = "onedark",
-- 	priority = 1000,
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "deep",
-- 			transparent = true,
-- 			term_colors = false,
-- 			ending_tildes = false,
-- 			cmp_itemkind_reverse = false,
--
-- 			toggle_style_key = "<leader>ot",
-- 			toggle_style_list = { "dark", "darker", "cool", "warm", "warmer", "deep", "light" },
--
-- 			-- Options are italic, bold, underline, none and combos 'italic,bold'
-- 			code_style = {
-- 				comments = "italic",
-- 				keywords = "none",
-- 				functions = "none",
-- 				strings = "none",
-- 				variables = "none",
-- 			},
--
-- 			lualine = { transparent = true },
-- 			diagnostics = { darker = true, undercurl = true, background = false },
-- 		})
--
-- 		vim.cmd([[colorscheme onedark]])
-- 	end,
-- }

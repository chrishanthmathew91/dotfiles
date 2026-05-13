-- Enhanced yank highlighting with custom colors
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

-- Set custom yank highlight color after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
	group = highlight_group,
	pattern = "*",
	callback = function()
		-- Create a custom highlight group for yank
		local C = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "YankHighlight", {
			bg = C.mauve,
			fg = "NONE",
			blend = 60,
		})
	end,
})

-- Trigger the colorscheme autocmd to set highlight immediately
vim.api.nvim_create_autocmd("VimEnter", {
	group = highlight_group,
	once = true,
	callback = function()
		vim.cmd("doautocmd ColorScheme")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.highlight.on_yank({
			higroup = "YankHighlight",
			timeout = 300,
			on_visual = true,
		})
	end,
})

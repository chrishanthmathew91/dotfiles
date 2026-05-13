return {
	"rcarriga/nvim-notify",
	name = "notify",
	event = "VeryLazy",
	config = function()
		local notify = require("notify")
		local bg = "#181825"
		local ok, palette = pcall(require("catppuccin.palettes").get_palette, "mocha")
		if ok and palette and palette.mantle then
			bg = palette.mantle
		end
		notify.setup({
			-- Animation style (fade_in_slide_out, fade, slide, static)
			stages = "fade_in_slide_out",
			-- Default timeout for notifications
			timeout = 3000,
			-- Max number of columns for messages
			max_width = nil,
			-- Max number of lines for a message
			max_height = nil,
			-- Render function for notifications
			render = "default",
			-- Default position: top_right, top_left, bottom_right, bottom_left, top_center, bottom_center, center
			top_down = true,
			-- Icons for the different levels
			icons = {
				ERROR = "󰅙",
				WARN = "󰀪",
				INFO = "󰋼",
				DEBUG = "󰆈",
				TRACE = "󰎁",
			},
			-- Minimum level to show
			level = 2,
			-- Animation stages
			background_colour = bg,
			-- Minimum width for notification windows
			minimum_width = 50,
			-- fps for animations
			fps = 30,
			-- Custom highlight groups
			on_open = nil,
			on_close = nil,
			on_rendered = nil,
		})

		-- Override vim.notify to use nvim-notify
		vim.notify = notify

		-- Fun example notification on startup (optional)
		-- vim.schedule(function()
		-- 	vim.notify("Welcome to Neovim! 🚀", "info", { title = "Nightfox Theme" })
		-- end)
	end,
}

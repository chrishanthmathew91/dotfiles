local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
	return
end
-- local icons = require("icons")

dashboard.setup({
	theme = "doom", --  theme is doom and hyper default is hyper
	disable_move = false, --  defualt is false disable move keymap for hyper
	shortcut_type = "letter", --  shorcut type 'letter' or 'number'
	change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
	hide = {
		statusline = false, -- hide statusline default is true
		tabline = false, -- hide the tabline
		winbar = false, -- hide winbar
	},
	config = {
		week_header = {
			enable = true,
		},
		packages = { enable = true }, -- show how many plugins neovim loaded
		project = { enable = true, limit = 8 },
		mru = { limit = 8 },
		shortcut = {
			{
				desc = "  .. Plugins",
				group = "@property",
				action = "Lazy",
				key = "p",
			},
			{
				desc = "  .. Mason",
				group = "@property",
				action = "Mason",
				key = "m",
			},
		},
	},
})

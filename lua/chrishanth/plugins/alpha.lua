return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header with fun colors
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
			"              🚀 Welcome · Catppuccin mocha          ",
		}

		-- Add fun colors to header
		dashboard.section.header.opts.hl = "DashboardHeader"
		local C = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = C.blue })

		-- Set menu with fun icons
		dashboard.section.buttons.val = {
			dashboard.button("e", "󰈔  New File", "<cmd>ene<CR>"),
			dashboard.button("SPC ee", "󰉋  Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fs", "󰍉  Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("SPC nd", "󰧑  Today note", "<cmd>ObsidianToday<CR>"),
			dashboard.button("SPC np", "󰐃  Pinned notes", "<cmd>NotesPinned<CR>"),
			dashboard.button("SPC wr", "󰁯  Restore Session", "<cmd>AutoSession restore<CR>"),
			dashboard.button("q", "󰗼  Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Add footer with fun info
		dashboard.section.footer.val = {
			"",
			"💡 Tip: Press <Space> to see all keymaps",
			"",
		}
		dashboard.section.footer.opts.hl = "DashboardFooter"
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = C.teal })

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}

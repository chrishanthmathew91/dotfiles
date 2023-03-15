local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local lualine_nightfly = require("lualine.themes.nightfly")

local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA&B",
	black = "#000000",
}

lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, --black
	},
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = lualine_nightfly,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				path = 1, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
			{
				"lsp_progress",
				spinner_symbols = {
					"🌑 ",
					"🌒 ",
					"🌓 ",
					"🌔 ",
					"🌕 ",
					"🌖 ",
					"🌗 ",
					"🌘 ",
				},
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- tabline = {
	-- 	lualine_c = {
	-- 		{
	-- 			"filename",
	-- 			path = 1,
	-- 		},
	-- 	},
	-- lualine_b = {},
	-- lualine_a = {},
	-- lualine_x = {},
	-- lualine_y = {},
	-- lualine_z = {},
	-- },
	extensions = {},
})

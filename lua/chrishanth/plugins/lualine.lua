return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
	config = function()
		local lualine = require("lualine")
		local stl_escape = require("lualine.utils.utils").stl_escape

		---@param path string absolute file path
		---@return string|nil
		local function find_git_root(path)
			local dir = vim.fn.fnamemodify(path, ":h")
			local git_dir = vim.fn.finddir(".git", dir .. ";")
			if git_dir ~= "" then
				return vim.fn.fnamemodify(git_dir, ":h")
			end
			local out = vim.trim(vim.fn.system({ "git", "-C", dir, "rev-parse", "--show-toplevel" }))
			if vim.v.shell_error == 0 and out ~= "" then
				return out
			end
			return nil
		end

		---@param full string
		---@param root string
		---@return string|nil relative path inside root, or nil if full is not under root
		local function path_relative_to(full, root)
			full = full:gsub("\\", "/"):gsub("/$", "")
			root = root:gsub("\\", "/"):gsub("/$", "")
			if full == root then
				return ""
			end
			local prefix = root .. "/"
			if vim.startswith(full, prefix) then
				return full:sub(#prefix + 1)
			end
			return nil
		end

		--- Path from repo root when inside a git project; else path relative to cwd (`:p:~:.`).
		local function project_relative_path()
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname == "" then
				return "[No Name]"
			end
			if bufname:match("^%a+://") then
				return stl_escape(bufname)
			end
			local full = vim.fn.fnamemodify(bufname, ":p")
			if vim.fs and vim.fs.normalize then
				full = vim.fs.normalize(full)
			end
			local root = find_git_root(full)
			local display
			if root then
				if vim.fs and vim.fs.normalize then
					root = vim.fs.normalize(root)
				end
				local rel = path_relative_to(full, root)
				display = rel ~= nil and rel or vim.fn.expand("%:~:.")
			else
				display = vim.fn.expand("%:~:.")
			end
			display = stl_escape(display)
			local symbols = {}
			if vim.bo.modified then
				table.insert(symbols, "󰏫 ")
			end
			if vim.bo.modifiable == false or vim.bo.readonly == true then
				table.insert(symbols, "󰈡 ")
			end
			return display .. (#symbols > 0 and " " .. table.concat(symbols, "") or "")
		end

		-- Fun function to get mode icon
		local function get_mode_icon()
			local mode = vim.fn.mode()
			local icons = {
				n = "󰋜", -- Normal
				i = "󰏫", -- Insert
				v = "󰈈", -- Visual
				V = "󰈈", -- Visual Line
				["\22"] = "󰈈", -- Visual Block
				c = "󰆍", -- Command
				r = "󰀘", -- Replace
				s = "󰆉", -- Select
				t = "󰆍", -- Terminal
			}
			return icons[mode] or "󰋜"
		end

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				-- catppuccin provides a lualine theme module named "catppuccin-nvim"
				theme = "catppuccin-nvim",
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				icons_enabled = true,
				always_divide_middle = true,
				globalstatus = false,
			},
			sections = {
				lualine_a = {
					{
						function()
							local mode = vim.fn.mode()
							local mode_map = {
								n = "N",
								i = "I",
								v = "V",
								V = "V",
								["\22"] = "V",
								c = "C",
								r = "R",
								s = "S",
								t = "T",
							}
							return get_mode_icon() .. " " .. (mode_map[mode] or mode:sub(1, 1))
						end,
						icons_enabled = true,
					},
				},
				lualine_b = {
					{ "branch", icon = "󰊢" },
				},
				lualine_c = {
					{ project_relative_path },
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_c = {
					{ project_relative_path },
				},
			},
		})
	end,
}

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local lualine = require("lualine")
-- 		local lazy_status = require("lazy.status")
-- -- Color table for highlights
-- -- stylua: ignore
-- local colors = {
--     bg       = '#202328',
--     fg       = '#bbc2cf',
--     yellow   = '#ECBE7B',
--     cyan     = '#008080',
--     darkblue = '#081633',
--     green    = '#98be65',
--     orange   = '#FF8800',
--     violet   = '#a9a1e1',
--     magenta  = '#c678dd',
--     blue     = '#51afef',
--     red      = '#ec5f67',
-- }
--
-- 		local conditions = {
-- 			buffer_not_empty = function()
-- 				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
-- 			end,
-- 			hide_in_width = function()
-- 				return vim.fn.winwidth(0) > 80
-- 			end,
-- 			check_git_workspace = function()
-- 				local filepath = vim.fn.expand("%:p:h")
-- 				local gitdir = vim.fn.finddir(".git", filepath .. ";")
-- 				return gitdir and #gitdir > 0 and #gitdir < #filepath
-- 			end,
-- 		}
--
-- 		-- Config
-- 		local config = {
-- 			options = {
-- 				-- Disable sections and component separators
-- 				theme = "onedark",
-- 				component_separators = "",
-- 				section_separators = "",
-- 				-- theme = {
-- 				--     -- We are going to use lualine_c an lualine_x as left and
-- 				--     -- right section. Both are highlighted by c theme .  So we
-- 				--     -- are just setting default looks o statusline
-- 				--     normal = { c = { fg = colors.fg, bg = colors.bg } },
-- 				--     inactive = { c = { fg = colors.fg, bg = colors.bg } },
-- 				-- },
-- 			},
-- 			sections = {
-- 				-- these are to remove the defaults
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 				-- These will be filled later
-- 				lualine_c = {},
-- 				lualine_x = {},
-- 			},
-- 			inactive_sections = {
-- 				-- these are to remove the defaults
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 				lualine_c = {},
-- 				lualine_x = {},
-- 			},
-- 		}
--
-- 		-- Inserts a component in lualine_c at left section
-- 		local function ins_left(component)
-- 			table.insert(config.sections.lualine_c, component)
-- 		end
--
-- 		-- Inserts a component in lualine_x ot right section
-- 		local function ins_right(component)
-- 			table.insert(config.sections.lualine_x, component)
-- 		end
--
-- 		ins_left({
-- 			function()
-- 				return "▊"
-- 			end,
-- 			color = { fg = colors.blue }, -- Sets highlighting of component
-- 			padding = { left = 0, right = 1 }, -- We don't need space before this
-- 		})
--
-- 		ins_left({
-- 			-- mode component
-- 			function()
-- 				return ""
-- 			end,
-- 			color = function()
-- 				-- auto change color according to neovims mode
-- 				local mode_color = {
-- 					n = colors.red,
-- 					i = colors.green,
-- 					v = colors.blue,
-- 					[""] = colors.blue,
-- 					V = colors.blue,
-- 					c = colors.magenta,
-- 					no = colors.red,
-- 					s = colors.orange,
-- 					S = colors.orange,
-- 					[""] = colors.orange,
-- 					ic = colors.yellow,
-- 					R = colors.violet,
-- 					Rv = colors.violet,
-- 					cv = colors.red,
-- 					ce = colors.red,
-- 					r = colors.cyan,
-- 					rm = colors.cyan,
-- 					["r?"] = colors.cyan,
-- 					["!"] = colors.red,
-- 					t = colors.red,
-- 				}
-- 				return { fg = mode_color[vim.fn.mode()] }
-- 			end,
-- 			padding = { right = 1 },
-- 		})
--
-- 		-- ins_left({
-- 		-- 	-- filesize component
-- 		-- 	"filesize",
-- 		-- 	cond = conditions.buffer_not_empty,
-- 		-- })
--
-- 		ins_left({
-- 			"filename",
-- 			path = 1,
-- 			cond = conditions.buffer_not_empty,
-- 			color = { fg = colors.yellow, gui = "" },
-- 		})
--
-- 		ins_left({ "location" })
--
-- 		-- ins_left({ "progress", color = { fg = colors.fg, gui = "" } })
--
-- 		-- ins_left({
-- 		-- 	"diagnostics",
-- 		-- 	sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic" },
-- 		-- 	symbols = { error = " ", warn = " ", info = " ", hint = "💡" },
-- 		-- 	diagnostics_color = {
-- 		-- 		color_error = { fg = colors.red },
-- 		-- 		color_warn = { fg = colors.yellow },
-- 		-- 		color_info = { fg = colors.cyan },
-- 		-- 	},
-- 		-- })
--
-- 		-- Insert mid section. You can make any number of sections in neovim :)
-- 		-- for lualine it's any number greater then 2
-- 		ins_left({
-- 			function()
-- 				return "%="
-- 			end,
-- 		})
--
-- 		ins_left({
-- 			-- Lsp server name .
-- 			function()
-- 				local msg = "No LSP"
-- 				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
-- 				local clients = vim.lsp.get_active_clients()
-- 				if next(clients) == nil then
-- 					return msg
-- 				end
-- 				for _, client in ipairs(clients) do
-- 					local filetypes = client.config.filetypes
-- 					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
-- 						return client.name
-- 					end
-- 				end
-- 				return msg
-- 			end,
-- 			icon = " LSP:",
-- 			color = { fg = "#ffffff", gui = "bold" },
-- 		})
--
-- 		-- Add components to right sections
-- 		ins_right({
-- 			"o:encoding", -- option component same as &encoding in viml
-- 			fmt = string.upper, -- I'm not sure why it's upper case either ;)
-- 			cond = conditions.hide_in_width,
-- 			color = { fg = colors.green, gui = "bold" },
-- 		})
--
-- 		ins_right({
-- 			"fileformat",
-- 			fmt = string.upper,
-- 			icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
-- 			color = { fg = colors.green, gui = "bold" },
-- 		})
--
-- 		ins_right({
-- 			"branch",
-- 			icon = "",
-- 			color = { fg = colors.violet, gui = "bold" },
-- 		})
--
-- 		ins_right({
-- 			"diff",
-- 			-- Is it me or the symbol for modified us really weird
-- 			symbols = { added = " ", modified = " ", removed = " " },
-- 			diff_color = {
-- 				added = { fg = colors.green },
-- 				modified = { fg = colors.orange },
-- 				removed = { fg = colors.red },
-- 			},
-- 			cond = conditions.hide_in_width,
-- 		})
--
-- 		ins_right({
-- 			function()
-- 				return "▊"
-- 			end,
-- 			color = { fg = colors.blue },
-- 			padding = { left = 1 },
-- 		})
--
-- 		-- Now don't forget to initialize lualine
-- 		lualine.setup(config)
-- 	end,
-- }

-- Custom Cheatsheet for Quick Keybinding Reference
-- Accessible via <leader>? for instant help

return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		local wk = require("which-key")
		
		wk.setup({
			preset = "modern",
			win = {
				border = "rounded",
				padding = { 1, 2 },
			},
			layout = {
				spacing = 3,
			},
		})

		-- Register key mappings with descriptions
		wk.add({
			-- File operations
			{ "<leader>f", group = "Find" },
			{ "<leader>ff", desc = "Files" },
			{ "<leader>fr", desc = "Recent files" },
			{ "<leader>fs", desc = "String in files" },
			{ "<leader>fc", desc = "String under cursor" },
			{ "<leader>ft", desc = "Todos" },
			{ "<leader>fb", desc = "Buffers" },
			{ "<leader>fk", desc = "Keybindings" },
			{ "<leader>fh", desc = "Help tags" },
			{ "<leader>fm", desc = "Man pages" },
			{ "<leader>fo", desc = "Vim options" },
			{ "<leader>fC", desc = "Commands" },
			{ "<leader>fH", desc = "Highlights" },
			{ "<leader>fj", desc = "Jumplist" },
			{ "<leader>fq", desc = "Quickfix" },
			{ "<leader>fl", desc = "Location list" },

			-- Git operations
			{ "<leader>g", group = "Git" },
			{ "<leader>gc", desc = "Commits" },
			{ "<leader>gC", desc = "Buffer commits" },
			{ "<leader>gb", desc = "Branches" },
			{ "<leader>gs", desc = "Status" },

			-- LSP operations
			{ "<leader>l", group = "LSP" },
			{ "<leader>lr", desc = "References" },
			{ "<leader>ld", desc = "Definitions" },
			{ "<leader>lD", desc = "Declarations" },
			{ "<leader>li", desc = "Implementations" },
			{ "<leader>lt", desc = "Type definitions" },
			{ "<leader>ls", desc = "Document symbols" },
			{ "<leader>lS", desc = "Workspace symbols" },

			-- Cursor Agent operations
			{ "<leader>a", group = "Agent" },
			{ "<leader>am", desc = "Cycle mode" },
			{ "<leader>aA", desc = "Ask mode" },
			{ "<leader>aP", desc = "Plan mode" },
			{ "<leader>aD", desc = "Debug mode" },
			{ "<leader>aG", desc = "Agent mode" },
			{ "<leader>aM", desc = "Cycle model" },
			{ "<leader>as", desc = "Select model" },
			{ "<leader>ar", desc = "Restart agent" },
			{ "<leader>a1", desc = "Claude 4 Sonnet" },
			{ "<leader>a2", desc = "Claude 3.5 Sonnet" },
			{ "<leader>a3", desc = "GPT-4o" },
			{ "<leader>a4", desc = "GPT-4o Mini" },
			{ "<leader>a5", desc = "Composer Fast" },

			-- Notes (Obsidian)
			{ "<leader>n", group = "Notes" },
			{ "<leader>nd", desc = "Today's note" },
			{ "<leader>nD", desc = "Daily notes" },
			{ "<leader>ny", desc = "Yesterday" },
			{ "<leader>nt", desc = "Tomorrow" },
			{ "<leader>ns", desc = "Search notes" },
			{ "<leader>nS", desc = "Search prompt" },
			{ "<leader>ne", desc = "Extract + pin" },
			{ "<leader>nr", desc = "Rename note" },
			{ "<leader>nC", desc = "Cleanup old dailies" },

			-- Window/Session management
			{ "<leader>w", group = "Workspace" },
			{ "<leader>wr", desc = "Restore session" },
			{ "<leader>ws", desc = "Save session" },
			{ "<leader>s", group = "Split" },
			{ "<leader>sv", desc = "Split vertical" },
			{ "<leader>sh", desc = "Split horizontal" },
			{ "<leader>se", desc = "Equal splits" },
			{ "<leader>sm", desc = "Maximize toggle" },

			-- Tab management
			{ "<leader>t", group = "Tabs" },
			{ "<leader>to", desc = "Open new tab" },
			{ "<leader>tx", desc = "Close tab" },
			{ "<leader>tn", desc = "Next tab" },
			{ "<leader>tp", desc = "Previous tab" },

			-- Trouble/Diagnostics
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>xw", desc = "Workspace diagnostics" },
			{ "<leader>xl", desc = "Location list" },

			-- Quick actions
			{ "<leader>+", desc = "Increment number" },
			{ "<leader>r", desc = "Toggle relative numbers" },
			{ "<leader>e", group = "Explorer" },
			{ "<leader>ec", desc = "Collapse file explorer" },
		})

		-- Custom cheatsheet function
		local function show_cheatsheet()
			local lines = {
				"🔍 ESSENTIAL KEYBINDINGS",
				"",
				"📁 FILES & SEARCH:",
				"  <leader>ff    Find files",
				"  <leader>fs    Search in files", 
				"  <leader>fb    Find buffers",
				"  <leader>fk    Find keybindings ⭐",
				"",
				"🤖 CURSOR AGENT:",
				"  <leader>aM    Cycle models ⭐",
				"  <leader>as    Select model ⭐",
				"  <leader>am    Cycle modes",
				"  <leader>a1-5  Quick model switch",
				"",
				"📝 NOTES:",
				"  <leader>nd    Today's note",
				"  <leader>ns    Search notes",
				"",
				"🌳 GIT:",
				"  <leader>g     LazyGit",
				"  <leader>gc    Git commits",
				"",
				"💡 LSP:",
				"  <leader>ca    Code actions",
				"  <leader>rn    Rename",
				"  <leader>lr    Find references",
				"",
				"❓ HELP:",
				"  <leader>?     This cheatsheet ⭐",
				"  <leader>fk    All keybindings",
				"  <leader>fh    Help docs",
				"",
				"Press 'q' to close, '/' to search"
			}
			
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			vim.bo[buf].filetype = 'help'
			vim.bo[buf].bufhidden = 'wipe'
			
			local width = 50
			local height = #lines + 2
			local win = vim.api.nvim_open_win(buf, true, {
				relative = 'editor',
				width = width,
				height = height,
				col = (vim.o.columns - width) / 2,
				row = (vim.o.lines - height) / 2,
				style = 'minimal',
				border = 'rounded',
				title = ' Quick Reference ',
				title_pos = 'center',
			})
			
			-- Add highlighting
			vim.api.nvim_set_hl(0, 'CheatsheetTitle', { fg = '#7aa2f7', bold = true })
			vim.api.nvim_set_hl(0, 'CheatsheetSection', { fg = '#f7768e', bold = true })
			vim.api.nvim_set_hl(0, 'CheatsheetKey', { fg = '#9ece6a' })
			vim.api.nvim_set_hl(0, 'CheatsheetStar', { fg = '#ff9e64', bold = true })
			
			local ns = vim.api.nvim_create_namespace('cheatsheet')
			vim.api.nvim_buf_add_highlight(buf, ns, 'CheatsheetTitle', 0, 0, -1)
			
			for i, line in ipairs(lines) do
				if line:match('^📁') or line:match('^🤖') or line:match('^📝') or line:match('^🌳') or line:match('^💡') or line:match('^❓') then
					vim.api.nvim_buf_add_highlight(buf, ns, 'CheatsheetSection', i-1, 0, -1)
				elseif line:match('<leader>') then
					local start_col = line:find('<leader>')
					local end_col = line:find('%s', start_col)
					if start_col and end_col then
						vim.api.nvim_buf_add_highlight(buf, ns, 'CheatsheetKey', i-1, start_col-1, end_col-1)
					end
					if line:match('⭐') then
						local star_col = line:find('⭐')
						if star_col then
							vim.api.nvim_buf_add_highlight(buf, ns, 'CheatsheetStar', i-1, star_col-1, star_col)
						end
					end
				end
			end
			
			-- Close on 'q' or escape
			vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true })
			vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true })
		end

		-- Register the cheatsheet keybinding
		vim.keymap.set("n", "<leader>?", show_cheatsheet, { desc = "Show keybinding cheatsheet" })
		
		-- Also add it to which-key
		wk.add({
			{ "<leader>?", desc = "Keybinding cheatsheet ⭐" }
		})
	end,
}
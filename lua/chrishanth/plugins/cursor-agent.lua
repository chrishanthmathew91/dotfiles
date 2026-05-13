return {
	"felixcuello/neovim-cursor",
	-- The plugin auto-calls setup(), but we still provide opts to override the command.
	-- This runs via a login shell so PATH/auth match your terminal, and keeps the terminal
	-- open if `cursor agent` exits so you can see any error output.
	opts = {
		-- Cursor CLI's "default model" is still Auto in your cli-config, so force Sonnet here.
		-- You can switch to another model id from `cursor agent --list-models`.
		command = {
			"zsh",
			"-lc",
			"cursor agent --model claude-4-sonnet; code=$?; echo; echo \"[cursor agent exited: $code]\"; exec zsh",
		},
	},
	keys = {
		{
			"<leader>am",
			function()
				local term = require("neovim-cursor").terminal
				local tabs = require("neovim-cursor").tabs

				-- Cycle modes in the agent UI.
				-- Note: actual supported modes depend on your Cursor CLI build.
				local modes = { "ask", "plan", "debug", "agent" }
				vim.g._cursor_agent_mode_idx = (vim.g._cursor_agent_mode_idx or 0) + 1
				if vim.g._cursor_agent_mode_idx > #modes then
					vim.g._cursor_agent_mode_idx = 1
				end
				local mode = modes[vim.g._cursor_agent_mode_idx]

				local active_id = tabs.get_active()
				if not (active_id and term.is_running(active_id)) then
					-- Create/show agent first (then send after it's ready)
					require("neovim-cursor").normal_mode_handler()
					vim.defer_fn(function()
						local id = tabs.get_active()
						if id and term.is_running(id) then
							term.send_text("/mode " .. mode, id)
						end
					end, 150)
					return
				end

				term.send_text("/mode " .. mode, active_id)
			end,
			mode = "n",
			desc = "Cursor Agent: cycle mode (ask/plan/debug/agent)",
		},
		{ "<leader>aA", function() require("neovim-cursor").terminal.send_text("/mode ask") end, mode = "n", desc = "Cursor Agent: mode ask" },
		{ "<leader>aP", function() require("neovim-cursor").terminal.send_text("/mode plan") end, mode = "n", desc = "Cursor Agent: mode plan" },
		{ "<leader>aD", function() require("neovim-cursor").terminal.send_text("/mode debug") end, mode = "n", desc = "Cursor Agent: mode debug" },
		{ "<leader>aG", function() require("neovim-cursor").terminal.send_text("/mode agent") end, mode = "n", desc = "Cursor Agent: mode agent" },
	},
}

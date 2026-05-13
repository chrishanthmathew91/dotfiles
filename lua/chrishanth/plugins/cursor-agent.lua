-- Cursor Agent Plugin with Model Switching Capabilities
--
-- Key Bindings:
--   Mode Control:
--     <leader>am - Cycle through modes (ask/plan/debug/agent)
--     <leader>aA - Set mode to ask
--     <leader>aP - Set mode to plan
--     <leader>aD - Set mode to debug
--     <leader>aG - Set mode to agent
--
--   Model Control:
--     <leader>aM - Cycle through available models
--     <leader>as - Select model from menu
--     <leader>ar - Restart agent with current model
--     <leader>a1-5 - Quick switch to specific models
--
-- Models can be updated in the models table below

return {
	"felixcuello/neovim-cursor",
	-- The plugin auto-calls setup(), but we still provide opts to override the command.
	-- This runs via a login shell so PATH/auth match your terminal, and keeps the terminal
	-- open if `cursor agent` exits so you can see any error output.
	opts = function()
		-- Available Cursor models - update this list based on `cursor agent --list-models`
		local models = {
			"claude-4-sonnet",
			"claude-4.6-sonnet-medium",
			"claude-4.6-sonnet-medium-thinking",
			"claude-opus-4-7-medium",
			"claude-opus-4-7-high",
			"composer-2",
			"composer-2-fast",
			"gpt-5.5-medium",
		}

		-- Get current model (default to first in list)
		local current_model = vim.g._cursor_agent_model or models[1]

		return {
			command = {
				"zsh",
				"-lc",
				string.format(
					'cursor agent --model %s; code=$?; echo; echo "[cursor agent exited: $code]"; exec zsh',
					current_model
				),
			},
		}
	end,
	keys = function()
		-- Available models
		local models = {
			"claude-4-sonnet",
			"claude-4.6-sonnet-medium",
			"claude-4.6-sonnet-medium-thinking",
			"claude-opus-4-7-medium",
			"claude-opus-4-7-high",
			"composer-2",
			"composer-2-fast",
			"gpt-5.5-medium",
		}

		-- Model switching functions
		local function cycle_model()
			vim.g._cursor_agent_model_idx = (vim.g._cursor_agent_model_idx or 0) + 1
			if vim.g._cursor_agent_model_idx > #models then
				vim.g._cursor_agent_model_idx = 1
			end
			local model = models[vim.g._cursor_agent_model_idx]
			vim.g._cursor_agent_model = model
			vim.notify(string.format("Cursor Agent model set to: %s", model), vim.log.levels.INFO)
		end

		local function select_model()
			vim.ui.select(models, {
				prompt = "Select Cursor Agent Model:",
				format_item = function(item)
					local current = vim.g._cursor_agent_model or models[1]
					return item == current and string.format("● %s (current)", item) or string.format("  %s", item)
				end,
			}, function(choice)
				if choice then
					vim.g._cursor_agent_model = choice
					vim.notify(string.format("Cursor Agent model set to: %s", choice), vim.log.levels.INFO)
				end
			end)
		end

		local function restart_agent_with_model(model)
			vim.g._cursor_agent_model = model
			local tabs = require("neovim-cursor").tabs
			local term = require("neovim-cursor").terminal

			-- Close current agent if running
			local active_id = tabs.get_active()
			if active_id and term.is_running(active_id) then
				term.close(active_id)
			end

			-- Start new agent with selected model
			vim.defer_fn(function()
				require("neovim-cursor").normal_mode_handler()
				vim.notify(string.format("Started Cursor Agent with model: %s", model), vim.log.levels.INFO)
			end, 100)
		end

		return {
			-- Mode cycling (existing functionality)
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
				desc = "Cursor Agent: cycle mode",
			},

			-- Mode shortcuts (existing functionality)
			{
				"<leader>aA",
				function()
					require("neovim-cursor").terminal.send_text("/mode ask")
				end,
				mode = "n",
				desc = "Cursor Agent: mode ask",
			},
			{
				"<leader>aP",
				function()
					require("neovim-cursor").terminal.send_text("/mode plan")
				end,
				mode = "n",
				desc = "Cursor Agent: mode plan",
			},
			{
				"<leader>aD",
				function()
					require("neovim-cursor").terminal.send_text("/mode debug")
				end,
				mode = "n",
				desc = "Cursor Agent: mode debug",
			},
			{
				"<leader>aG",
				function()
					require("neovim-cursor").terminal.send_text("/mode agent")
				end,
				mode = "n",
				desc = "Cursor Agent: mode agent",
			},

			-- Model switching (new functionality)
			{ "<leader>aM", cycle_model, mode = "n", desc = "Cursor Agent: cycle model" },
			{ "<leader>as", select_model, mode = "n", desc = "Cursor Agent: select model" },
			{
				"<leader>ar",
				function()
					restart_agent_with_model(vim.g._cursor_agent_model or models[1])
				end,
				mode = "n",
				desc = "Cursor Agent: restart with current model",
			},

			-- Quick model shortcuts
			{
				"<leader>a1",
				function()
					restart_agent_with_model(models[1])
				end,
				mode = "n",
				desc = "Cursor Agent: " .. models[1],
			},
			{
				"<leader>a2",
				function()
					restart_agent_with_model(models[2])
				end,
				mode = "n",
				desc = "Cursor Agent: " .. models[2],
			},
			{
				"<leader>a3",
				function()
					restart_agent_with_model(models[3])
				end,
				mode = "n",
				desc = "Cursor Agent: " .. models[3],
			},
			{
				"<leader>a4",
				function()
					restart_agent_with_model(models[4])
				end,
				mode = "n",
				desc = "Cursor Agent: " .. models[4],
			},
			{
				"<leader>a5",
				function()
					restart_agent_with_model(models[5])
				end,
				mode = "n",
				desc = "Cursor Agent: " .. models[5],
			},
		}
	end,
}

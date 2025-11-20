return {
	"felixcuello/neovim-cursor",
	opts = {
		-- optional: choose default agent, window size, etc.
	},
	keys = {
		-- Toggle a floating terminal running the agent
		{
			"<leader>ai",
			function()
				require("neovim-cursor").toggle()
			end,
			mode = { "n", "v" },
			desc = "Cursor Agent",
		},
		-- Send visual selection to the agent
		{
			"<leader>cs",
			function()
				require("neovim-cursor").send_visual()
			end,
			mode = "v",
			desc = "Send to Cursor Agent",
		},
	},
}

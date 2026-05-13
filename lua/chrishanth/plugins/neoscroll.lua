return {
	"karb94/neoscroll.nvim",
	name = "neoscroll",
	event = "VeryLazy",
	config = function()
		require("neoscroll").setup({
			-- All these keys will be mapped to their corresponding default scrolling animation
			mappings = {
				-- Syntax: [keys] = {function, {arguments}}
				["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150", [['sine']] } },
				["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150", [['sine']] } },
				["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "300", [['sine']] } },
				["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "300", [['sine']] } },
				["<C-y>"] = { "scroll", { "-0.10", "false", "100", [['sine']] } },
				["<C-e>"] = { "scroll", { "0.10", "false", "100", [['sine']] } },
				["zt"] = { "zt", { "150", [['sine']] } },
				["zz"] = { "zz", { "150", [['sine']] } },
				["zb"] = { "zb", { "150", [['sine']] } },
			},
			hide_cursor = true, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop when mouse reaches buffer edge
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			easing_function = nil, -- Default easing function
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable "Performance Mode" on all buffers.
		})
	end,
}

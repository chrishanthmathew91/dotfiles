return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"lewis6991/async.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
		})
		pcall(function()
			require("telescope").load_extension("refactoring")
		end)

		vim.api.nvim_set_keymap(
			"v",
			"<leader>rr",
			"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
			{ noremap = true }
		)
	end,
}

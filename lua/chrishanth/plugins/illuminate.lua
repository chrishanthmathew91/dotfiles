return {
	"RRethy/vim-illuminate",
	event = "VeryLazy",
	config = function()
		require("illuminate").configure({
			-- providers: provider used to get references in the buffer, ordered by priority
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
			-- delay: delay in milliseconds
			delay = 100,
			-- filetype_overrides: filetype specific overrides.
			-- The keys are strings to represent the filetype while the values are tables that
			-- supports the same keys passed to .configure except for filetype_overrides.
			filetype_overrides = {},
			-- filetype_denylist: filetypes to not illuminate, this overrides filetype_allowlist
			filetype_denylist = {
				"dirvish",
				"fugitive",
				"alpha",
			},
			-- filetype_allowlist: filetypes to illuminate, this is overridden by filetype_denylist
			filetype_allowlist = {},
			-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
			-- See `:help mode()` for possible modes
			modes_denylist = {},
			-- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
			-- See `:help mode()` for possible modes
			modes_allowlist = {},
			-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
			-- Only applies to the 'regex' provider
			-- See `:help synIDattr()` for possible syntax attributes
			providers_regex_syntax_denylist = {},
			-- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
			-- Only applies to the 'regex' provider
			-- See `:help synIDattr()` for possible syntax attributes
			providers_regex_syntax_allowlist = {},
			-- under_cursor: whether or not to illuminate under the cursor
			under_cursor = false,
			-- large_file_cutoff: number of lines at which to use large_file_config
			-- The `highlight` and `providers` options are the only ones
			-- The `highlight` option is the same as the main `highlight` option
			-- The `providers` option is the same as the main `providers` option
			large_file_cutoff = 5000,
			-- large_file_config: config to use for large files (based on large_file_cutoff).
			-- Supports the same keys passed to .configure
			-- If nil, all features are disabled, if a table, merge with the main config
			large_file_overrides = nil,
			-- min_count_to_highlight: minimum number of matches required to perform highlighting
			min_count_to_highlight = 1,
		})

		-- Custom highlight color
		-- vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3EFFDC", blend = 30 })
		-- vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3EFFDC", blend = 30 })
		-- vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#65D1FF", blend = 30 })
	end,
}
